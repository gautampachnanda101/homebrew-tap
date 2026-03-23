#!/usr/bin/env bash

set -euo pipefail

# Default values
ENVIRONMENT="local"
DOMAIN=""
NAMESPACE="vault"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    cat <<EOF
Install HashiCorp Vault on k3d-local cluster

Usage: $0 [OPTIONS]

Options:
    -e, --environment ENV    Environment overlay (local|prod) [default: local]
    -d, --domain DOMAIN      Domain name for production (required for prod)
    -n, --namespace NS       Kubernetes namespace [default: vault]
    -h, --help              Show this help message

Examples:
    # Local development (dev mode with root token)
    $0

    # Production with custom domain
    $0 --environment prod --domain vault.example.com

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
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
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Validate environment
if [[ "$ENVIRONMENT" != "local" && "$ENVIRONMENT" != "prod" ]]; then
    echo -e "${RED}Error: Environment must be 'local' or 'prod'${NC}"
    exit 1
fi

# Validate domain for production
if [[ "$ENVIRONMENT" == "prod" && -z "$DOMAIN" ]]; then
    echo -e "${RED}Error: --domain is required for production environment${NC}"
    exit 1
fi

# Set domain defaults
if [[ "$ENVIRONMENT" == "local" ]]; then
    DOMAIN="vault.127.0.0.1.sslip.io"
fi

echo -e "${GREEN}Installing HashiCorp Vault using Kustomize overlay: ${ENVIRONMENT}${NC}"
echo ""

# Check prerequisites
check_prerequisites() {
    echo "Checking prerequisites..."
    
    if ! kubectl cluster-info &>/dev/null; then
        echo -e "${RED}Error: Cannot connect to Kubernetes cluster. Is k3d-local running?${NC}"
        echo "Run: k3d-local create --with-traefik"
        exit 1
    fi
    
    echo -e "${GREEN}✓ Kubernetes cluster accessible${NC}"
}

# Install Vault
install_vault() {
    echo ""
    echo "Installing Vault..."
    
    if [[ "$ENVIRONMENT" == "local" ]]; then
        kubectl apply -k overlays/local/
    else
        # For production, substitute the domain placeholder
        kustomize build overlays/prod/ | \
            sed "s/DOMAIN\\.PLACEHOLDER/$DOMAIN/g" | \
            kubectl apply -f -
    fi
    
    echo -e "${GREEN}✓ Vault installed${NC}"
}

# Wait for Vault to be ready
wait_for_vault() {
    echo ""
    echo "Waiting for Vault to be ready..."
    kubectl wait --for=condition=available --timeout=300s deployment/vault -n "$NAMESPACE"
    echo -e "${GREEN}✓ Vault is ready${NC}"
}

# Display access information
show_access_info() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}Vault Installation Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo "Access Vault UI:"
    echo "  URL: https://$DOMAIN"
    echo ""
    if [[ "$ENVIRONMENT" == "local" ]]; then
        echo "Root Token: root"
        echo ""
        echo -e "${YELLOW}Note: This is a DEV MODE installation - NOT for production!${NC}"
        echo -e "${YELLOW}Data is stored in memory and will be lost on restart.${NC}"
    else
        echo "Initialize Vault:"
        echo "  kubectl exec -it -n $NAMESPACE deployment/vault -- vault operator init"
        echo ""
        echo -e "${YELLOW}IMPORTANT: Save the unseal keys and root token securely!${NC}"
    fi
    echo ""
}

# Main execution
check_prerequisites
install_vault
wait_for_vault
show_access_info
