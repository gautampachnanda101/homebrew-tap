# HashiCorp Vault Recipe for k3d-local

Production-ready HashiCorp Vault installation using **Kustomize overlays** for your k3d-local cluster with proper TLS support.

## Quick Start

```bash
# 1. Ensure k3d-local cluster is running with Traefik
k3d-local create --with-traefik

# 2. Clone this repo and navigate to the Vault recipe
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/vault

# 3. Install Vault (local development with dev mode)
./install.sh

# 4. Access Vault
# URL: https://vault.127.0.0.1.sslip.io
# Root Token: root
```

**Prerequisites:**
- Docker running
- k3d-local cluster created with `--with-traefik` flag
- kubectl configured

## What You Get

- ✅ **Vault Server** with web UI
- ✅ **TLS/HTTPS** with cert-manager integration
- ✅ **Automatic certificate management**
- ✅ **Dev mode** for local development (with root token)
- ✅ **Kustomize-based** for easy customization
- ✅ **Production-ready** overlay for real deployments

> **CI Tested:** This recipe is automatically tested in GitHub Actions. See the [test workflow](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/test-examples.yml) for validation status.

## Recipe Structure

```
vault/
├── base/                    # Base Vault manifests
│   ├── kustomization.yaml  # Base kustomize config
│   ├── namespace.yaml      # Vault namespace
│   ├── configmap.yaml      # Vault configuration
│   ├── deployment.yaml     # Vault deployment
│   ├── service.yaml        # Vault service
│   ├── certificate.yaml    # Certificate template
│   └── ingress.yaml        # Traefik IngressRoute
├── overlays/
│   ├── local/              # Local development overlay  (dev mode)
│   │   └── kustomization.yaml
│   └── prod/               # Production overlay (sealed)
│       └── kustomization.yaml
├── install.sh              # Installation script
├── get-root-token.sh       # Get root token
├── uninstall.sh            # Uninstall script
└── README.md               # This file
```

## Installation Options

### Option 1: Script Installation (Recommended)

```bash
# Local development (dev mode with root token)
./install.sh

# Production (sealed Vault, must be initialized)
./install.sh --environment prod --domain vault.example.com
```

**Script Options:**
- `-e, --environment ENV` - Environment overlay (local|prod) [default: local]
- `-d, --domain DOMAIN` - Domain name for production
- `-n, --namespace NS` - Kubernetes namespace [default: vault]
- `-h, --help` - Show help

### Option 2: Manual Kustomize Installation

```bash
# Local development
kubectl apply -k overlays/local/

# Production (replace DOMAIN.PLACEHOLDER with your domain)
kustomize build overlays/prod/ | \
  sed 's/DOMAIN\.PLACEHOLDER/vault.example.com/g' | \
  kubectl apply -f -
```

## Accessing Vault

### Local Development

```bash
# Vault UI
https://vault.127.0.0.1.sslip.io

# Root Token (dev mode only)
./get-root-token.sh
# Output: root
```

### Production

```bash
# Initialize Vault (first time only)
kubectl exec -it -n vault deployment/vault -- vault operator init

# This will output unseal keys and root token
# SAVE THESE SECURELY - you cannot retrieve them later!

# Unseal Vault (requires 3 of 5 keys)
kubectl exec -it -n vault deployment/vault -- vault operator unseal <key1>
kubectl exec -it -n vault deployment/vault -- vault operator unseal <key2>
kubectl exec -it -n vault deployment/vault -- vault operator unseal <key3>
```

## Configuration

### Local vs Production

| Feature | Local (Dev Mode) | Production |
|---------|------------------|------------|
| **Certificate** | Self-signed (local-dev-ca-issuer) | Let's Encrypt (letsencrypt-prod) |
| **Domain** | vault.127.0.0.1.sslip.io | Custom domain |
| **Storage** | In-memory (ephemeral) | File storage (persistent) |
| **Auto-unseal** | ✅ Yes | ❌ No (manual) |
| **Root Token** | `root` (hardcoded) | Generated at init |
| **Data Persistence** | ❌ Lost on restart | ✅ Persistent volume |

### Environment Variables

For local development, Vault runs in dev mode with:
- `VAULT_DEV_ROOT_TOKEN_ID=root`
- `VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200`

For production, these are removed and Vault must be properly initialized and unsealed.

## Common Tasks

### Store a Secret

```bash
# Port-forward for CLI access
kubectl port-forward -n vault svc/vault 8200:8200 &

# Set Vault address
export VAULT_ADDR='http://127.0.0.1:8200'

# Login (dev mode)
export VAULT_TOKEN='root'

# Write a secret
vault kv put secret/myapp username=admin password=secret123

# Read a secret
vault kv get secret/myapp
```

### Enable KV Secrets Engine v2

```bash
vault secrets enable -path=secret kv-v2
```

### Create a Policy

```bash
vault policy write myapp-policy - <<EOF
path "secret/data/myapp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
```

## Production Considerations

⚠️ **IMPORTANT**: The local overlay runs Vault in **dev mode** which is:
- Automatically unsealed
- Stores data in memory
- Uses a pre-set root token
- **NOT suitable for production**

For production deployments:

1. **Use the prod overlay** with proper storage backend
2. **Initialize Vault** and save unseal keys securely
3. **Enable auto-unseal** using cloud KMS (AWS, GCP, Azure)
4. **Enable audit logging**
5. **Configure HA** with multiple replicas
6. **Use proper auth methods** (LDAP, OIDC, K8s auth)
7. **Rotate root token** after initial setup

## Customization

### Change Storage Backend

Edit `base/configmap.yaml` to use a different storage backend:

```hcl
# Example: PostgreSQL storage
storage "postgresql" {
  connection_url = "postgres://user:pass@postgres:5432/vault"
}
```

### Enable Database Secrets Engine

```bash
vault secrets enable database

vault write database/config/postgresql \
  plugin_name=postgresql-database-plugin \
  allowed_roles="readonly" \
  connection_url="postgresql://{{username}}:{{password}}@postgres:5432/mydb"
```

## Troubleshooting

### Vault is sealed

```bash
# Check status
kubectl exec -n vault deployment/vault -- vault status

# Unseal (requires unseal keys from initialization)
kubectl exec -n vault deployment/vault -- vault operator unseal <key>
```

### Cannot connect to Vault UI

```bash
# Check ingress
kubectl get ingressroute -n vault

# Check certificate
kubectl get certificate -n vault
kubectl describe certificate vault-tls -n vault

# Check Traefik
kubectl logs -n kube-system deployment/traefik
```

### Pod not starting

```bash
# Check logs
kubectl logs -n vault deployment/vault

# Check events
kubectl get events -n vault --sort-by='.lastTimestamp'
```

## Uninstall

```bash
./uninstall.sh

# Or manually
kubectl delete namespace vault
```

## Learn More

- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [Vault on Kubernetes](https://www.vaultproject.io/docs/platform/k8s)
- [Vault Best Practices](https://www.vaultproject.io/docs/internals/security)
- [Production Hardening](https://learn.hashicorp.com/tutorials/vault/production-hardening)

## Support

- [Report issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [View k3d-local documentation](https://github.com/gautampachnanda101/local-cluster-k3d)
- [Browse examples](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples)
