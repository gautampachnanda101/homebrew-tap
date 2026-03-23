# Harbor Recipe for k3d-local

Production-ready Harbor installation using Kustomize overlays for your k3d-local cluster with TLS support.

## Quick Start

```bash
# 1. Ensure a k3d-local cluster is running with Traefik
k3d-local create --with-traefik

# 2. Clone this repo and navigate to the Harbor recipe
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/harbor

# 3. Install Harbor (local development)
./install.sh

# 4. Access Harbor
# URL: https://harbor.127.0.0.1.sslip.io
# Username: admin
# Password: Harbor12345
```

Prerequisites:
- Docker running
- k3d-local cluster created with --with-traefik
- kubectl configured

## What You Get

- Harbor core, portal, and registry components
- PostgreSQL and Redis backends
- TLS/HTTPS via cert-manager and Traefik
- Local and production overlays

## Recipe Structure

```text
harbor/
|- base/
|  |- kustomization.yaml
|  |- namespace.yaml
|  |- postgres.yaml
|  |- redis.yaml
|  |- core.yaml
|  |- registry.yaml
|  |- portal.yaml
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
./install.sh --environment prod --domain harbor.example.com
```

Script options:
- -e, --environment local|prod
- -d, --domain DOMAIN
- -n, --namespace NS (default: harbor)
- -h, --help

## Access and Usage

```bash
# Login
docker login harbor.127.0.0.1.sslip.io

# Tag and push
docker tag myimage:latest harbor.127.0.0.1.sslip.io/library/myimage:latest
docker push harbor.127.0.0.1.sslip.io/library/myimage:latest
```

## Troubleshooting

```bash
kubectl get pods -n harbor
kubectl get ingressroute -n harbor
kubectl get certificate -n harbor
kubectl logs -n harbor deployment/harbor-core
```

## Uninstall

```bash
./uninstall.sh
```
