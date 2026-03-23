# Authentik Recipe for k3d-local

Production-ready Authentik installation using Kustomize overlays for your k3d-local cluster with TLS support.

## Quick Start

```bash
# 1. Ensure a k3d-local cluster is running with Traefik
k3d-local create --with-traefik

# 2. Clone this repo and navigate to the Authentik recipe
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/authentik

# 3. Install Authentik
./install.sh

# 4. Access setup flow
# URL: https://authentik.127.0.0.1.sslip.io/if/flow/initial-setup/
```

Prerequisites:
- Docker running
- k3d-local cluster created with --with-traefik
- kubectl configured

## What You Get

- Authentik server and worker deployments
- PostgreSQL and Redis backends
- TLS/HTTPS via cert-manager and Traefik
- Local and production overlays

## Recipe Structure

```text
authentik/
|- base/
|  |- kustomization.yaml
|  |- namespace.yaml
|  |- postgres.yaml
|  |- redis.yaml
|  |- secret.yaml
|  |- server.yaml
|  |- worker.yaml
|  |- service.yaml
|  |- certificate.yaml
|  |- ingress.yaml
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
./install.sh

# Production
./install.sh --environment prod --domain auth.example.com
```

Script options:
- -e, --environment local|prod
- -d, --domain DOMAIN
- -n, --namespace NS (default: authentik)
- -h, --help

## Access

- Initial setup: https://authentik.127.0.0.1.sslip.io/if/flow/initial-setup/
- Admin: https://authentik.127.0.0.1.sslip.io/if/admin/

## Troubleshooting

```bash
kubectl get pods -n authentik
kubectl get ingressroute -n authentik
kubectl get certificate -n authentik
kubectl logs -n authentik deployment/authentik-server
kubectl logs -n authentik deployment/authentik-worker
```

## Uninstall

```bash
./uninstall.sh
```
