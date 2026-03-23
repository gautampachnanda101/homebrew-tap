#!/usr/bin/env bash
set -euo pipefail

# Get ArgoCD admin password

NAMESPACE="${1:-argocd}"

echo "Retrieving ArgoCD admin password from namespace: $NAMESPACE"
echo ""

if ! kubectl get secret argocd-initial-admin-secret -n "$NAMESPACE" &> /dev/null; then
    echo "Error: argocd-initial-admin-secret not found in namespace $NAMESPACE"
    echo ""
    echo "This could mean:"
    echo "  1. ArgoCD is not installed yet"
    echo "  2. The password has been reset and the secret deleted"
    echo "  3. You're using the wrong namespace"
    echo ""
    echo "To reset the password, delete the secret and restart argocd-server:"
    echo "  kubectl delete secret argocd-secret -n $NAMESPACE"
    echo "  kubectl rollout restart deployment argocd-server -n $NAMESPACE"
    exit 1
fi

PASSWORD=$(kubectl -n "$NAMESPACE" get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d)

echo "Username: admin"
echo "Password: $PASSWORD"
echo ""
echo "Login with ArgoCD CLI:"
echo "  argocd login argocd.127.0.0.1.sslip.io --insecure --username admin --password '$PASSWORD'"
echo ""
echo "Change password:"
echo "  argocd account update-password"
