#!/usr/bin/env bash
set -euo pipefail
ENVIRONMENT="local"
while [[ $# -gt 0 ]]; do
  case "$1" in
    -e|--environment) ENVIRONMENT="$2"; shift 2 ;;
    -h|--help) echo "Usage: $0 [--environment local|prod]"; exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done
kubectl apply -k "overlays/${ENVIRONMENT}/"
echo "OpenFGA resources applied"
