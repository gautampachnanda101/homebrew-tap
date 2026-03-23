#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${1:-harbor}"

echo "Uninstalling Harbor from namespace: $NAMESPACE"
kubectl delete -k overlays/local/ --ignore-not-found=true 2>/dev/null || \
kubectl delete -k overlays/prod/ --ignore-not-found=true 2>/dev/null || \
kubectl delete namespace "$NAMESPACE" --ignore-not-found=true

echo "✓ Harbor uninstalled"
