# GitLab Runner Recipe for k3d-local

Install GitLab Runner on k3d-local using Kustomize overlays for local and production-style setups.

## Quick Start

```bash
# 1. Ensure a k3d-local cluster is running
k3d-local create --with-traefik

# 2. Clone this repo and navigate to the GitLab Runner recipe
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/gitlab-runner

# 3. Install GitLab Runner
./install.sh --gitlab-url https://gitlab.com --token glrt-xxxx
```

Prerequisites:
- Docker running
- k3d-local cluster available
- kubectl configured
- A valid GitLab runner token

## What You Get

- GitLab Runner deployment in Kubernetes
- Runner configuration via ConfigMap patching
- Local and production overlays
- Kubernetes executor setup

## Recipe Structure

```text
gitlab-runner/
|- base/
|  |- kustomization.yaml
|  |- namespace.yaml
|  |- configmap.yaml
|  |- deployment.yaml
|  |- rbac.yaml
|- overlays/
|  |- local/
|  |  |- kustomization.yaml
|  |- prod/
|     |- kustomization.yaml
|- install.sh
|- uninstall.sh
|- README.md
```

## Installation

```bash
# Local
./install.sh --gitlab-url https://gitlab.com --token glrt-xxxx

# Production overlay
./install.sh --environment prod --gitlab-url https://gitlab.com --token glrt-xxxx
```

Script options:
- -e, --environment local|prod
- -u, --gitlab-url URL
- -t, --token TOKEN
- -n, --namespace NS (default: gitlab-runner)
- -h, --help

## Verify Runner

```bash
kubectl get pods -n gitlab-runner
kubectl logs -n gitlab-runner deployment/gitlab-runner
```

Then check your GitLab project or group runner settings to confirm it registered.

## Troubleshooting

```bash
kubectl get configmap gitlab-runner-config -n gitlab-runner -o yaml
kubectl describe deployment gitlab-runner -n gitlab-runner
```

## Uninstall

```bash
./uninstall.sh
```
