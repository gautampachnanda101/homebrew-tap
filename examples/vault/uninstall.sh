#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${1:-vault}"

echo "Uninstalling Vault from namespace: $NAMESPACE"

# Delete all resources
kubectl delete -k overlays/local/ --ignore-not-found=true 2>/dev/null || \
kubectl delete -k overlays/prod/ --ignore-not-found=true 2>/dev/null || \
kubectl delete namespace "$NAMESPACE" --ignore-not-found=true

echo "✓ Vault uninstalled"
