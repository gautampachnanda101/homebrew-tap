#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace kyverno --ignore-not-found=true
echo "Kyverno removed"
