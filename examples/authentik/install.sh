#!/usr/bin/env bash

set -euo pipefail

ENVIRONMENT="local"
DOMAIN=""
NAMESPACE="authentik"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
    cat <<EOF
Install Authentik SSO/IAM on k3d-local cluster

Usage: $0 [OPTIONS]

Options:
    -e, --environment ENV    Environment overlay (local|prod) [default: local]
    -d, --domain DOMAIN      Domain name for production
    -n, --namespace NS       Kubernetes namespace [default: authentik]
    -h, --help              Show this help message

Examples:
    ./install.sh
    ./install.sh --environment prod --domain auth.example.com

EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment) ENVIRONMENT="$2"; shift 2 ;;
        -d|--domain) DOMAIN="$2"; shift 2 ;;
        -n|--namespace) NAMESPACE="$2"; shift 2 ;;
        -h|--help) usage ;;
        *) echo -e "${RED}Unknown option: $1${NC}"; usage ;;
    esac
done

if [[ "$ENVIRONMENT" != "local" && "$ENVIRONMENT" != "prod" ]]; then
    echo -e "${RED}Error: Environment must be 'local' or 'prod'${NC}"
    exit 1
fi

if [[ "$ENVIRONMENT" == "prod" && -z "$DOMAIN" ]]; then
    echo -e "${RED}Error: --domain is required for production${NC}"
    exit 1
fi

[[ "$ENVIRONMENT" == "local" ]] && DOMAIN="authentik.127.0.0.1.sslip.io"

echo -e "${GREEN}Installing Authentik: ${ENVIRONMENT}${NC}"

if ! kubectl cluster-info &>/dev/null; then
    echo -e "${RED}Error: Cannot connect to cluster${NC}"
    exit 1
fi

if [[ "$ENVIRONMENT" == "local" ]]; then
    kubectl apply -k overlays/local/
else
    kustomize build overlays/prod/ | sed "s/DOMAIN\\.PLACEHOLDER/$DOMAIN/g" | kubectl apply -f -
fi

echo ""
echo "Waiting for Authentik to be ready (this may take 1-2 minutes)..."
kubectl wait --for=condition=available --timeout=300s deployment/authentik-server -n "$NAMESPACE" || true
kubectl wait --for=condition=available --timeout=300s deployment/authentik-worker -n "$NAMESPACE" || true

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Authentik Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Access Authentik:"
echo "  URL: https://$DOMAIN/if/flow/initial-setup/"
echo ""
echo -e "${YELLOW}First-time setup:${NC}"
echo "  1. Visit the URL above to create your admin account"
echo "  2. Follow the setup wizard"
echo ""
echo "Admin Interface: https://$DOMAIN/if/admin/"
echo ""
