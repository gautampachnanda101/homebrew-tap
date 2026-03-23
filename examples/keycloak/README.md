# Keycloak Recipe for k3d-local

Production-ready Keycloak installation using Kustomize overlays for your k3d-local cluster with TLS support.

## Quick Start

```bash
# 1. Ensure a k3d-local cluster is running with Traefik
k3d-local create --with-traefik

# 2. Clone this repo and navigate to the Keycloak recipe
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/keycloak

# 3. Install Keycloak
./install.sh

# 4. Access Keycloak
# URL: https://keycloak.127.0.0.1.sslip.io
# Username: admin
# Password: admin
```

Prerequisites:
- Docker running
- k3d-local cluster created with --with-traefik
- kubectl configured

## What You Get

- Keycloak server with admin console
- PostgreSQL backend
- TLS/HTTPS via cert-manager and Traefik
- Local and production overlays

## Recipe Structure

```text
keycloak/
|- base/
|  |- kustomization.yaml
|  |- namespace.yaml
|  |- postgres.yaml
|  |- deployment.yaml
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
./install.sh --environment prod --domain keycloak.example.com
```

Script options:
- -e, --environment local|prod
- -d, --domain DOMAIN
- -n, --namespace NS (default: keycloak)
- -h, --help

## Access

- UI: https://keycloak.127.0.0.1.sslip.io
- Admin console: https://keycloak.127.0.0.1.sslip.io/admin

## Troubleshooting

```bash
kubectl get pods -n keycloak
kubectl get ingressroute -n keycloak
kubectl get certificate -n keycloak
kubectl logs -n keycloak deployment/keycloak
```

## Uninstall

```bash
./uninstall.sh
```
