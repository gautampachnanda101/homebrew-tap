#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace spicedb --ignore-not-found=true
echo "SpiceDB removed"
