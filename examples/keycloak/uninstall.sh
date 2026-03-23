#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${1:-keycloak}"

echo "Uninstalling Keycloak from namespace: $NAMESPACE"
kubectl delete namespace "$NAMESPACE" --ignore-not-found=true
echo "✓ Keycloak uninstalled"
