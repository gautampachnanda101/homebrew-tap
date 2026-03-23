#!/usr/bin/env bash

set -euo pipefail

ENVIRONMENT="local"
GITLAB_URL=""
RUNNER_TOKEN=""
NAMESPACE="gitlab-runner"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
    cat <<EOF
Install GitLab Runner on k3d-local cluster

Usage: $0 [OPTIONS]

Options:
    -e, --environment ENV    Environment overlay (local|prod) [default: local]
    -u, --gitlab-url URL     GitLab instance URL (required)
    -t, --token TOKEN        Runner registration token (required)
    -n, --namespace NS       Kubernetes namespace [default: gitlab-runner]
    -h, --help              Show this help message

Examples:
    ./install.sh --gitlab-url https://gitlab.com --token glrt-xxxx

EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment) ENVIRONMENT="$2"; shift 2 ;;
        -u|--gitlab-url) GITLAB_URL="$2"; shift 2 ;;
        -t|--token) RUNNER_TOKEN="$2"; shift 2 ;;
        -n|--namespace) NAMESPACE="$2"; shift 2 ;;
        -h|--help) usage ;;
        *) echo -e "${RED}Unknown option: $1${NC}"; usage ;;
    esac
done

if [[ -z "$GITLAB_URL" || -z "$RUNNER_TOKEN" ]]; then
    echo -e "${RED}Error: --gitlab-url and --token are required${NC}"
    usage
fi

echo -e "${GREEN}Installing GitLab Runner: ${ENVIRONMENT}${NC}"

if ! kubectl cluster-info &>/dev/null; then
    echo -e "${RED}Error: Cannot connect to cluster${NC}"
    exit 1
fi

if [[ "$ENVIRONMENT" == "local" ]]; then
    kubectl apply -k overlays/local/
else
    kubectl apply -k overlays/prod/
fi

# Patch the configmap with actual values
kubectl patch configmap gitlab-runner-config -n "$NAMESPACE" --type merge -p "$(cat <<EOF
data:
  config.toml: |
    concurrent = 10
    check_interval = 3
    
    [[runners]]
      name = "k3d-runner"
      url = "$GITLAB_URL"
      token = "$RUNNER_TOKEN"
      executor = "kubernetes"
      
      [runners.kubernetes]
        namespace = "$NAMESPACE"
        image = "alpine:latest"
        privileged = true
EOF
)"

kubectl rollout restart deployment/gitlab-runner -n "$NAMESPACE"

echo ""
echo "Waiting for GitLab Runner to be ready..."
kubectl wait --for=condition=available --timeout=120s deployment/gitlab-runner -n "$NAMESPACE" || true

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}GitLab Runner Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Runner should now appear in your GitLab instance."
echo ""
