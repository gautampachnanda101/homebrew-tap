# External Secrets Operator + Vault Recipe for k3d-local

Kustomize scaffold for integrating External Secrets with Vault.

## Quick Start

```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/external-secrets-operator
./install.sh
```

## Vault Integration

- Includes example SecretStore and ExternalSecret resources.
- Requires External Secrets CRDs and controller in-cluster.
- Configure a valid vault-token secret before syncing secrets.
