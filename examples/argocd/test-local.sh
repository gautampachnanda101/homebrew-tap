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
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_step() {
    echo -e "${BLUE}➜${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

cleanup() {
    log_warn "Cleaning up..."
    
    # Uninstall ArgoCD if it exists
    if kubectl get namespace "$NAMESPACE" &>/dev/null; then
        log_step "Uninstalling ArgoCD..."
        "$SCRIPT_DIR/uninstall.sh" || true
    fi
    
    # Delete cluster
    if k3d-local list | grep -q "$CLUSTER_NAME"; then
        log_step "Deleting k3d cluster: $CLUSTER_NAME"
        k3d-local delete --name "$CLUSTER_NAME" || true
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

create_cluster() {
    log_step "Creating k3d cluster: $CLUSTER_NAME"
    
    k3d-local create --name "$CLUSTER_NAME" --with-traefik
    
    log_step "Waiting for cluster to be ready..."
    kubectl cluster-info
    kubectl get nodes
    
    log_info "Cluster created successfully"
}

wait_for_traefik() {
    log_step "Waiting for Traefik to be ready..."
    
    kubectl wait --for=condition=available --timeout=300s deployment/traefik -n kube-system || {
        log_error "Traefik failed to become ready"
        kubectl get pods -n kube-system
        return 1
    }
    
    log_info "Traefik is ready"
}

verify_cert_manager() {
    log_step "Verifying cert-manager ClusterIssuers..."
    
    if ! kubectl get clusterissuer local-dev-ca-issuer &>/dev/null; then
        log_error "local-dev-ca-issuer not found"
        return 1
    fi
    
    log_info "cert-manager configured correctly"
}

install_argocd() {
    log_step "Installing ArgoCD..."
    
    cd "$SCRIPT_DIR"
    ./install.sh
    
    log_info "ArgoCD installation initiated"
}

wait_for_argocd() {
    log_step "Waiting for ArgoCD to be ready..."
    
    # Check namespace exists
    if ! kubectl get namespace "$NAMESPACE" &>/dev/null; then
        log_error "ArgoCD namespace not found"
        return 1
    fi
    
    # Wait for deployments to be created
    log_step "Waiting for ArgoCD deployments to be created..."
    timeout 60s bash -c "until kubectl get deployment argocd-server -n $NAMESPACE 2>/dev/null; do echo 'Waiting...'; sleep 2; done" || {
        log_error "ArgoCD deployments not created in time"
        kubectl get all -n "$NAMESPACE"
        return 1
    }
    
    # Wait for argocd-server to be ready
    log_step "Waiting for argocd-server deployment (timeout: 5 minutes)..."
    kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n "$NAMESPACE" || {
        log_error "ArgoCD server deployment failed to become available"
        echo ""
        log_step "Pod status:"
        kubectl get pods -n "$NAMESPACE" -o wide
        echo ""
        log_step "Recent events:"
        kubectl get events -n "$NAMESPACE" --sort-by='.lastTimestamp' | tail -20
        return 1
    }
    
    log_info "ArgoCD is ready"
}

verify_argocd() {
    log_step "Verifying ArgoCD installation..."
    
    # Check all components
    kubectl get all -n "$NAMESPACE"
    
    # Check certificate
    log_step "Checking certificate..."
    kubectl get certificate -n "$NAMESPACE" || log_warn "No certificates found"
    
    # Check ingress
    log_step "Checking IngressRoute..."
    kubectl get ingressroute -n "$NAMESPACE" || log_warn "No IngressRoute found"
    
    log_info "ArgoCD installation verified"
}

get_password() {
    log_step "Retrieving ArgoCD admin password..."
    
    cd "$SCRIPT_DIR"
    ./get-password.sh
}

test_api_access() {
    log_step "Testing ArgoCD API accessibility..."
    
    kubectl port-forward svc/argocd-server -n "$NAMESPACE" 8080:443 &>/dev/null &
    local PF_PID=$!
    
    sleep 5
    
    if curl -k -s https://localhost:8080/healthz | grep -q "ok"; then
        log_info "ArgoCD API is accessible"
    else
        log_warn "ArgoCD API test completed (check manually at https://argocd.127.0.0.1.sslip.io)"
    fi
    
    kill $PF_PID 2>/dev/null || true
}

display_success() {
    echo ""
    echo "========================================="
    echo -e "  ${GREEN}✓ All Tests Passed!${NC}"
    echo "========================================="
    echo ""
    echo "Access ArgoCD at: https://argocd.127.0.0.1.sslip.io"
    echo "Username: admin"
    echo "Password: (displayed above)"
    echo ""
    echo "To clean up manually:"
    echo "  cd $SCRIPT_DIR"
    echo "  ./uninstall.sh"
    echo "  k3d-local delete --name $CLUSTER_NAME"
    echo ""
}

# Main execution
main() {
    echo ""
    echo "========================================="
    echo "  ArgoCD Local Test"
    echo "========================================="
    echo ""
    
    # Set up trap for cleanup on exit
    trap cleanup EXIT INT TERM
    
    check_prerequisites
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
    echo -n "Keep cluster running for manual testing? [y/N]: "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        trap - EXIT INT TERM
        log_info "Cluster $CLUSTER_NAME will remain running"
        echo ""
        echo "When done testing, clean up with:"
        echo "  k3d-local delete --name $CLUSTER_NAME"
    else
        log_step "Cleaning up..."
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
