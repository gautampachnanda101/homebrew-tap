#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace openfga --ignore-not-found=true
echo "OpenFGA removed"
