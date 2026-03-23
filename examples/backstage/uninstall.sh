#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace backstage --ignore-not-found=true
echo "Backstage removed"
