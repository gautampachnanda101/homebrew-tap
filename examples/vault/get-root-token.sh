#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${1:-vault}"

echo "Vault Root Token (dev mode only):"
echo "root"
echo ""
echo "For production, retrieve the root token from your initialization output."
echo "Never store production tokens in plain text!"
