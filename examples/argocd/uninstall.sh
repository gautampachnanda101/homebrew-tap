#!/usr/bin/env bash
set -euo pipefail

# Uninstall ArgoCD

NAMESPACE="${1:-argocd}"

echo "Uninstalling ArgoCD from namespace: $NAMESPACE"
echo ""

# Determine which overlay was used by checking the domain
OVERLAY="local"
if kubectl get ingressroute argocd-server -n "$NAMESPACE" -o yaml 2>/dev/null | grep -q "127.0.0.1.sslip.io"; then
    OVERLAY="local"
else
    OVERLAY="prod"
fi

echo "Detected overlay: $OVERLAY"
echo ""

# Delete using kustomize
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl delete -k "$SCRIPT_DIR/overlays/$OVERLAY" --ignore-not-found=true

echo ""
echo "ArgoCD uninstalled successfully"
echo ""
echo "To completely remove the namespace:"
echo "  kubectl delete namespace $NAMESPACE"
