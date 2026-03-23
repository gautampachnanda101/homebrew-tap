#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${1:-authentik}"

echo "Uninstalling Authentik from namespace: $NAMESPACE"
kubectl delete namespace "$NAMESPACE" --ignore-not-found=true
echo "✓ Authentik uninstalled"
