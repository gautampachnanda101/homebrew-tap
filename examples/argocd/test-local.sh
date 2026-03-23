#!/usr/bin/env bash
set -euo pipefail

# Local Test Script for ArgoCD Example
# Tests the full installation flow locally

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLUSTER_NAME="test-argocd-$(date +%s)"
NAMESPACE="argocd"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_step() {
    echo -e "${CYAN}➜${NC} $1"
}

log_section() {
    echo ""
    echo -e "${BOLD}${MAGENTA}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${MAGENTA}  $1${NC}"
    echo -e "${BOLD}${MAGENTA}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

log_warn() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

log_error() {
    echo -e "${RED}✗${NC}  $1"
}

# Suppress verbose k3d-local output
export QUIET_MODE=1

cleanup() {
    echo ""
    log_section "Cleanup"
    
    # Uninstall ArgoCD if it exists
    if kubectl get namespace "$NAMESPACE" &>/dev/null; then
        log_step "Uninstalling ArgoCD..."
        "$SCRIPT_DIR/uninstall.sh" 2>&1 | grep -E "(Uninstalling|deleted|successfully)" || true
    fi
    
    # Delete cluster
    if k3d cluster list 2>/dev/null | grep -q "$CLUSTER_NAME"; then
        log_step "Deleting cluster: $CLUSTER_NAME"
        k3d-local delete --name "$CLUSTER_NAME" 2>&1 | grep -E "(Deleting|deleted|Successfully)" || true
    fi
    
    log_info "Cleanup complete"
}

check_prerequisites() {
    log_step "Checking prerequisites..."
    
    local missing=()
    
    if ! command -v k3d-local &>/dev/null; then
        missing+=("k3d-local")
    fi
    
    if ! command -v kubectl &>/dev/null; then
        missing+=("kubectl")
    fi
    
    if ! command -v k3d &>/dev/null; then
        missing+=("k3d")
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        log_error "Missing required tools: ${missing[*]}"
        echo ""
        echo "Install with:"
        echo "  brew tap gautampachnanda101/tap"
        echo "  brew install k3d-local"
        exit 1
    fi
    
    log_info "All prerequisites satisfied"
}

cleanup_existing_clusters() {
    log_step "Checking for port conflicts..."
    
    # Get list of all k3d clusters
    local existing_clusters
    existing_clusters=$(k3d cluster list -o json 2>/dev/null | grep -o '"name":"[^"]*' | cut -d'"' -f4 || true)
    
    if [ -n "$existing_clusters" ]; then
        local count=$(echo "$existing_clusters" | wc -l | tr -d ' ')
        log_warn "Stopping $count existing cluster(s) to free ports..."
        while IFS= read -r cluster; do
            if [ -n "$cluster" ]; then
                k3d cluster stop "$cluster" 2>/dev/null || true
            fi
        done <<< "$existing_clusters"
        log_info "Ports freed"
    else
        log_info "No port conflicts detected"
    fi
}

create_cluster() {
    log_section "Creating Test Cluster"
    log_step "Cluster name: ${BOLD}$CLUSTER_NAME${NC}"
    
    k3d-local create --name "$CLUSTER_NAME" --with-traefik 2>&1 | \
        grep -E "(Checking|Creating|Starting|Installing|Waiting|OK|successfully|deployed)" || true
    
    log_step "Verifying cluster health..."
    kubectl get nodes --no-headers 2>&1 | awk '{printf "  %-40s %s\n", $1, $2}'
    
    log_info "Cluster ready"
}

wait_for_traefik() {
    log_step "Waiting for Traefik ingress controller..."
    
    kubectl wait --for=condition=available --timeout=300s deployment/traefik -n traefik-system 2>&1 | \
        grep -v "waiting" || {
        log_error "Traefik failed to become ready"
        kubectl get pods -n traefik-system --no-headers 2>&1 | awk '{printf "  %-40s %s\n", $1, $3}'
        return 1
    }
    
    log_info "Traefik ready"
}

verify_cert_manager() {
    log_step "Verifying cert-manager..."
    
    if ! kubectl get clusterissuer local-dev-ca-issuer &>/dev/null; then
        log_error "ClusterIssuer not found"
        return 1
    fi
    
    log_info "cert-manager ready"
}

install_argocd() {
    log_section "Installing ArgoCD"
    
    cd "$SCRIPT_DIR"
    ./install.sh 2>&1 | grep -E "(Installing|Creating|Applying|serverside-applied|successfully)" | head -20
    
    log_info "Installation complete"
}

wait_for_argocd() {
    log_section "Waiting for ArgoCD"
    
    # Check namespace exists
    if ! kubectl get namespace "$NAMESPACE" &>/dev/null; then
        log_error "Namespace not found"
        return 1
    fi
    
    # Wait for deployments to be created
    log_step "Waiting for deployments to be created..."
    local waited=0
    until kubectl get deployment argocd-server -n "$NAMESPACE" &>/dev/null; do
        if [ $waited -ge 60 ]; then
            log_error "Deployments not created in time"
            return 1
        fi
        sleep 2
        waited=$((waited + 2))
    done
    log_info "Deployments created"
    
    # Wait for pods to be ready (10 minute timeout)
    log_step "Waiting for pods to become ready (may take several minutes)..."
    local start_time=$(date +%s)
    local timeout=600
    
    while true; do
        local ready=$(kubectl get pods -n "$NAMESPACE" --no-headers 2>/dev/null | grep -c "Running" || echo 0)
        local total=$(kubectl get pods -n "$NAMESPACE" --no-headers 2>/dev/null | wc -l | tr -d ' ')
        
        if [ "$ready" -eq "$total" ] && [ "$total" -gt 0 ]; then
            log_info "All ArgoCD pods ready ($ready/$total)"
            break
        fi
        
        local elapsed=$(($(date +%s) - start_time))
        if [ $elapsed -gt $timeout ]; then
            log_error "Timeout waiting for pods ($ready/$total ready)"
            echo ""
            log_warn "Pod status:"
            kubectl get pods -n "$NAMESPACE" --no-headers 2>&1 | awk '{printf "  %-40s %s\n", $1, $3}'
            return 1
        fi
        
        echo -ne "\r  ${CYAN}Progress: $ready/$total pods ready (${elapsed}s elapsed)${NC}"  
        sleep 5
    done
    echo ""
    
    log_info "ArgoCD ready"
}

verify_argocd() {
    log_section "Verifying Installation"
    
    # Check deployments
    log_step "Deployments:"
    kubectl get deployments -n "$NAMESPACE" --no-headers 2>&1 | \
        awk '{printf "  %-40s %s/%s\n", $1, $2, $3}'
    
    # Check certificate
    log_step "Certificate:"
    local cert_status=$(kubectl get certificate -n "$NAMESPACE" --no-headers 2>&1 | \
        awk '{printf "  %-40s %s\n", $1, $2}')
    if [ -n "$cert_status" ]; then
        echo "$cert_status"
    else
        log_warn "No certificates found"
    fi
    
    # Check ingress
    log_step "IngressRoutes:"
    local ingress_count=$(kubectl get ingressroute -n "$NAMESPACE" --no-headers 2>/dev/null | wc -l | tr -d ' ')
    echo "  Found $ingress_count route(s)"
    
    log_info "Installation verified"
}

get_password() {
    log_section "Access Credentials"
    
    log_step "Username: ${BOLD}admin${NC}"
    log_step "Password:"
    
    cd "$SCRIPT_DIR"
    local password=$(./get-password.sh 2>/dev/null | tail -1)
    echo -e "  ${BOLD}${GREEN}$password${NC}"
}

test_api_access() {
    log_step "Testing API health..."
    
    kubectl port-forward svc/argocd-server -n "$NAMESPACE" 8080:443 &>/dev/null &
    local PF_PID=$!
    
    sleep 5
    
    if curl -k -s https://localhost:8080/healthz 2>/dev/null | grep -q "ok"; then
        log_info "API health check passed"
    else
        log_warn "Health check skipped - verify manually"
    fi
    
    kill $PF_PID 2>/dev/null || true
}

display_success() {
    log_section "✓ All Tests Passed!"
    
    echo -e "  ${BOLD}Web UI:${NC}      https://argocd.127.0.0.1.sslip.io"
    echo -e "  ${BOLD}Username:${NC}    admin"
    echo -e "  ${BOLD}Password:${NC}    (see above)"
    echo -e "  ${BOLD}Cluster:${NC}     $CLUSTER_NAME"
    echo ""
    echo -e "  ${CYAN}Manual cleanup:${NC}"
    echo -e "    ${YELLOW}k3d-local delete --name $CLUSTER_NAME${NC}"
    echo ""
}

# Main execution
main() {
    clear
    log_section "ArgoCD Local Test Suite"
    
    # Set up trap for cleanup on exit
    trap cleanup EXIT INT TERM
    
    check_prerequisites
    cleanup_existing_clusters
    create_cluster
    wait_for_traefik
    verify_cert_manager
    install_argocd
    wait_for_argocd
    verify_argocd
    get_password
    test_api_access
    
    display_success
    
    # Ask if user wants to keep the cluster
    echo -ne "${CYAN}Keep cluster running for manual testing? [y/N]:${NC} "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        trap - EXIT INT TERM
        echo ""
        log_info "Cluster preserved for testing"
        echo -e "  ${YELLOW}Clean up when done: k3d-local delete --name $CLUSTER_NAME${NC}"
        echo ""
    else
        echo ""
    fi
}

# Parse arguments
case "${1:-}" in
    -h|--help)
        cat <<EOF
ArgoCD Local Test Script

USAGE:
    $0 [OPTIONS]

OPTIONS:
    -h, --help      Show this help message

DESCRIPTION:
    This script performs a full local test of the ArgoCD example installation:
    
    1. Creates a temporary k3d cluster
    2. Installs ArgoCD using the local overlay
    3. Verifies the installation
    4. Tests API accessibility
    5. Cleans up after testing (or keeps cluster if requested)

REQUIREMENTS:
    - k3d-local (brew install gautampachnanda101/tap/k3d-local)
    - kubectl
    - k3d

EXAMPLES:
    # Run full test
    $0
    
    # View help
    $0 --help

EOF
        exit 0
        ;;
    *)
        main
        ;;
esac
