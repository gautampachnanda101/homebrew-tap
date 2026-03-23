#!/usr/bin/env bash
set -euo pipefail

# ArgoCD Installation Script for k3d-local
# Uses Kustomize overlays for environment-specific configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERLAY="local"
DOMAIN=""
NAMESPACE="argocd"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    cat <<EOF
ArgoCD Installation Script for k3d-local

USAGE:
    $0 [OPTIONS]

OPTIONS:
    -e, --environment ENV    Environment overlay to use (local|prod) [default: local]
    -d, --domain DOMAIN      Domain name for production environment
    -n, --namespace NS       Kubernetes namespace [default: argocd]
    -h, --help               Show this help message

EXAMPLES:
    # Install for local development (self-signed certs)
    $0

    # Install for production with Let's Encrypt
    $0 --environment prod --domain example.com

    # Install with custom namespace
    $0 --namespace argocd-system

REQUIREMENTS:
    - k3d-local cluster running (k3d-local create --with-traefik)
    - kubectl configured
    - cert-manager installed (included with k3d-local)

EOF
    exit 0
}

log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check kubectl
    if ! command -v kubectl &> /dev/null; then
        log_error "kubectl not found. Please install kubectl first."
        exit 1
    fi
    
    # Check cluster connection
    if ! kubectl cluster-info &> /dev/null; then
        log_error "Cannot connect to Kubernetes cluster. Is k3d-local running?"
        exit 1
    fi
    
    # Check cert-manager
    if ! kubectl get namespace cert-manager &> /dev/null; then
        log_warn "cert-manager namespace not found. Certificates may not be issued."
        log_warn "Install with: k3d-local create --with-traefik"
    fi
    
    # Check for required ClusterIssuer
    if [ "$OVERLAY" = "local" ]; then
        if ! kubectl get clusterissuer local-dev-ca-issuer &> /dev/null; then
            log_error "local-dev-ca-issuer not found. Create cluster with: k3d-local create --with-traefik"
            exit 1
        fi
    elif [ "$OVERLAY" = "prod" ]; then
        if ! kubectl get clusterissuer letsencrypt-prod &> /dev/null; then
            log_error "letsencrypt-prod issuer not found. Create cluster with: k3d-local create --use-letsencrypt"
            exit 1
        fi
    fi
}

install_argocd() {
    log_info "Installing ArgoCD using Kustomize overlay: $OVERLAY"
    
    local overlay_path="$SCRIPT_DIR/overlays/$OVERLAY"
    
    if [ ! -d "$overlay_path" ]; then
        log_error "Overlay not found: $overlay_path"
        exit 1
    fi
    
    # For production, substitute the domain
    if [ "$OVERLAY" = "prod" ]; then
        if [ -z "$DOMAIN" ]; then
            log_error "Domain is required for production environment. Use: --domain example.com"
            exit 1
        fi
        
        log_info "Using domain: $DOMAIN"
        kubectl apply -k "$overlay_path" --dry-run=client -o yaml | \
            sed "s/DOMAIN\.PLACEHOLDER/$DOMAIN/g" | \
            kubectl apply -f -
    else
        kubectl apply -k "$overlay_path"
    fi
}

wait_for_argocd() {
    log_info "Waiting for ArgoCD to be ready..."
    
    kubectl wait --for=condition=available --timeout=300s \
        deployment/argocd-server -n "$NAMESPACE" || {
        log_error "ArgoCD server failed to become ready"
        exit 1
    }
    
    kubectl wait --for=condition=available --timeout=300s \
        deployment/argocd-repo-server -n "$NAMESPACE" || {
        log_error "ArgoCD repo server failed to become ready"
        exit 1
    }
    
    log_info "ArgoCD is ready!"
}

display_access_info() {
    echo ""
    echo "========================================="
    echo "  ArgoCD Installation Complete! 🎉"
    echo "========================================="
    echo ""
    
    if [ "$OVERLAY" = "local" ]; then
        echo "Access ArgoCD at: https://argocd.127.0.0.1.sslip.io"
    else
        echo "Access ArgoCD at: https://argocd.$DOMAIN"
    fi
    
    echo ""
    echo "Login credentials:"
    echo "  Username: admin"
    echo "  Password: Run ./get-password.sh to retrieve"
    echo ""
    echo "Or get password with:"
    echo "  kubectl -n $NAMESPACE get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d && echo"
    echo ""
    
    # Check certificate status
    log_info "Checking certificate status..."
    kubectl get certificate -n "$NAMESPACE" 2>&1 | grep -v "No resources found" || true
    echo ""
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            OVERLAY="$2"
            shift 2
            ;;
        -d|--domain)
            DOMAIN="$2"
            shift 2
            ;;
        -n|--namespace)
            NAMESPACE="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            log_error "Unknown option: $1"
            usage
            ;;
    esac
done

# Validate overlay
if [ "$OVERLAY" != "local" ] && [ "$OVERLAY" != "prod" ]; then
    log_error "Invalid environment: $OVERLAY. Must be 'local' or 'prod'"
    exit 1
fi

# Main execution
main() {
    echo "========================================="
    echo "  ArgoCD Installation for k3d-local"
    echo "========================================="
    echo ""
    echo "Environment: $OVERLAY"
    [ -n "$DOMAIN" ] && echo "Domain: $DOMAIN"
    echo "Namespace: $NAMESPACE"
    echo ""
    
    check_prerequisites
    install_argocd
    wait_for_argocd
    display_access_info
}

main
