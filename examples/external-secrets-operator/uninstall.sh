#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace external-secrets --ignore-not-found=true
echo "External Secrets removed"
