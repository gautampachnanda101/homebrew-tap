#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${1:-gitlab-runner}"

echo "Uninstalling GitLab Runner from namespace: $NAMESPACE"
kubectl delete namespace "$NAMESPACE" --ignore-not-found=true
echo "✓ GitLab Runner uninstalled"
