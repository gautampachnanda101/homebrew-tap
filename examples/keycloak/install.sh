#!/usr/bin/env bash

set -euo pipefail

ENVIRONMENT="local"
DOMAIN=""
NAMESPACE="keycloak"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

usage() {
    cat <<EOF
Install Keycloak IAM on k3d-local cluster

Usage: $0 [OPTIONS]

Options:
    -e, --environment ENV    Environment overlay (local|prod) [default: local]
    -d, --domain DOMAIN      Domain name for production
    -n, --namespace NS       Kubernetes namespace [default: keycloak]
    -h, --help              Show this help message

Examples:
    ./install.sh
    ./install.sh --environment prod --domain keycloak.example.com

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

[[ "$ENVIRONMENT" == "local" ]] && DOMAIN="keycloak.127.0.0.1.sslip.io"

echo -e "${GREEN}Installing Keycloak: ${ENVIRONMENT}${NC}"

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
echo "Waiting for Keycloak to be ready (this may take a minute)..."
kubectl wait --for=condition=available --timeout=300s deployment/keycloak -n "$NAMESPACE" || true

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Keycloak Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Access Keycloak:"
echo "  URL: https://$DOMAIN"
echo "  Username: admin"
echo "  Password: admin"
echo ""
echo "Admin Console: https://$DOMAIN/admin"
echo ""
