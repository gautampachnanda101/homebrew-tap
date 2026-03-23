# ArgoCD Recipe for k3d-local

Production-ready ArgoCD installation using **Kustomize overlays** for your k3d-local cluster with proper TLS support.

## Quick Start

```bash
# 1. Install k3d-local (if you haven't already)
brew tap gautampachnanda101/tap
brew install k3d-local

# 2. Create k3d-local cluster with Traefik (required for ingress)
k3d-local create --with-traefik

# 3. Clone this repo and navigate to the ArgoCD recipe
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd

# 4. Install ArgoCD (local development with self-signed certs)
./install.sh

# 5. Access ArgoCD
# URL: https://argocd.127.0.0.1.sslip.io
# Username: admin
# Password: Run ./get-password.sh
```

**Prerequisites:**
- Docker running
- k3d-local cluster created with `--with-traefik` flag
- kubectl configured

## What You Get

- ✅ **ArgoCD Server** with web UI
- ✅ **ArgoCD CLI** accessible via ingress
- ✅ **TLS/HTTPS** with cert-manager integration
- ✅ **Automatic certificate management**
- ✅ **GitOps-ready** configuration
- ✅ **Kustomize-based** for easy customization

> **CI Tested:** This recipe is automatically tested in GitHub Actions. See the [test workflow](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/test-examples.yml) for validation status.

## Recipe Structure

```
argocd/
├── base/                    # Base ArgoCD manifests
│   ├── kustomization.yaml  # Base kustomize config
│   ├── certificate.yaml    # Certificate template
│   └── ingress.yaml        # Traefik IngressRoute
├── overlays/
│   ├── local/              # Local development overlay
│   │   └── kustomization.yaml
│   └── prod/               # Production overlay
│       └── kustomization.yaml
├── install.sh              # Installation script
├── get-password.sh         # Get admin password
├── uninstall.sh            # Uninstall script
└── README.md               # This file
```

## Installation Options

### Option 1: Script Installation (Recommended)

```bash
# Local development (self-signed certificates)
./install.sh

# Production (Let's Encrypt certificates)
./install.sh --environment prod --domain yourdomain.com

# Custom namespace
./install.sh --namespace my-argocd
```

**Script Options:**
- `-e, --environment ENV` - Environment overlay (local|prod) [default: local]
- `-d, --domain DOMAIN` - Domain name for production
- `-n, --namespace NS` - Kubernetes namespace [default: argocd]
- `-h, --help` - Show help

### Option 2: Manual Kustomize Installation

```bash
# Local development
kubectl apply -k overlays/local/

# Production (replace DOMAIN.PLACEHOLDER with your domain)
kubectl apply -k overlays/prod/ --dry-run=client -o yaml | \
  sed 's/DOMAIN\.PLACEHOLDER/example.com/g' | \
  kubectl apply -f -
```

### Option 3: Direct kubectl

```bash
# Install official ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Then apply your custom ingress and certificate
kubectl apply -f base/certificate.yaml
kubectl apply -f base/ingress.yaml
```

## Accessing ArgoCD

### Get Admin Password

```bash
# Use the helper script
./get-password.sh

# Or manually
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo
```

### Web UI

**Local Development:**
- URL: https://argocd.127.0.0.1.sslip.io
- Username: `admin`
- Password: from command above

**Production:**
- URL: https://argocd.yourdomain.com
- Username: `admin`
- Password: from command above

### ArgoCD CLI

```bash
# Install CLI
brew install argocd  # macOS
# or download from https://github.com/argoproj/argo-cd/releases

# Login
argocd login argocd.127.0.0.1.sslip.io --insecure  # local
argocd login argocd.yourdomain.com                  # production

# Change password
argocd account update-password
```

## Kustomize Structure

### base/
Base ArgoCD manifests that are common to all environments:
- Official ArgoCD installation
- Certificate template
- Traefik IngressRoute for HTTP and gRPC
- Patches for running server in insecure mode (TLS handled by Traefik)

### overlays/local/
Local development overlay:
- Self-signed certificates via `local-dev-ca-issuer`
- Single replica for lightweight operation
- Uses `127.0.0.1.sslip.io` domain
- Minimal resource allocation

### overlays/prod/
Production overlay:
- Let's Encrypt certificates via `letsencrypt-prod`
- High availability with multiple replicas
- Resource limits and requests
- Custom domain support

## TLS Configuration

### Local Development (Default)

Uses self-signed certificates from your k3d-local cluster:
- ClusterIssuer: `local-dev-ca-issuer`
- Domain: `argocd.127.0.0.1.sslip.io`
- Certificate: Automatically issued by cert-manager

**Optional: Trust the Local CA**
```bash
# Export CA certificate
kubectl get secret local-dev-ca-secret -n cert-manager \
  -o jsonpath='{.data.tls\.crt}' | base64 -d > local-dev-ca.crt

# macOS: Add to Keychain
sudo security add-trusted-cert -d -r trustRoot \
  -k /Library/Keychains/System.keychain local-dev-ca.crt

# Linux: Add to system trust
sudo cp local-dev-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

### Production (Let's Encrypt)

For production domains with real certificates:

```bash
# 1. Create cluster with Let's Encrypt
k3d-local create --with-traefik --use-letsencrypt \
  --domain yourdomain.com \
  --email admin@yourdomain.com

# 2. Install ArgoCD with production config
./install.sh --production --domain yourdomain.com
```

**Requirements:**
- Domain must resolve to your cluster's public IP
- Port 80 accessible for HTTP-01 challenge
- Port 443 for HTTPS traffic

## Example: Deploy Your First App

### Create Application via UI
1. Go to https://argocd.127.0.0.1.sslip.io
2. Click "+ NEW APP"
3. Fill in details and save

### Create Application via CLI

```bash
argocd app create my-app \
  --repo https://github.com/your-org/your-repo \
  --path k8s \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default
```

### Create Application via kubectl

```yaml
# my-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/your-repo
    targetRevision: main
    path: k8s
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

```bash
kubectl apply -f my-app.yaml
```

## Troubleshooting

### ArgoCD UI Not Accessible

```bash
# Check ingress
kubectl get ingress -n argocd
kubectl describe ingress argocd-server -n argocd

# Check certificate
kubectl get certificate -n argocd
kubectl describe certificate argocd-server-cert -n argocd

# Check pods
kubectl get pods -n argocd
```

### Certificate Not Issued

```bash
# Check cert-manager
kubectl get certificaterequest -n argocd
kubectl logs -n cert-manager deployment/cert-manager

# Check issuer
kubectl get clusterissuer
kubectl describe clusterissuer local-dev-ca-issuer
```

### Reset Admin Password

```bash
# Via CLI
argocd account update-password

# Via kubectl - delete secret to regenerate
kubectl delete secret argocd-initial-admin-secret -n argocd
kubectl rollout restart deployment argocd-server -n argocd
```

## Upgrading

```bash
# Update Helm repo
helm repo update

# Upgrade ArgoCD
helm upgrade argocd argo/argo-cd \
  --namespace argocd \
  --values values-local.yaml  # or values-prod.yaml
```

## Uninstalling

```bash
# Via Helm
helm uninstall argocd --namespace argocd

# Via Script
./uninstall.sh

# Clean up namespace
kubectl delete namespace argocd
```

## Advanced Configuration

### Multi-Cluster Management

```bash
# Add another cluster
argocd cluster add my-other-cluster

# List clusters
argocd cluster list
```

### SSO Configuration

Edit `values-local.yaml` or `values-prod.yaml` to add SSO providers:

```yaml
configs:
  cm:
    url: https://argocd.yourdomain.com
    dex.config: |
      connectors:
        - type: github
          id: github
          name: GitHub
          config:
            clientID: $dex.github.clientId
            clientSecret: $dex.github.clientSecret
```

### Webhook Integration

Configure webhooks for instant sync:
1. Get webhook URL: `https://argocd.yourdomain.com/api/webhook`
2. Add to GitHub repo: Settings → Webhooks → Add webhook

## Resources

- [ArgoCD Official Docs](https://argo-cd.readthedocs.io/)
- [k3d-local Documentation](https://github.com/gautampachnanda101/local-cluster-k3d)
- [Traefik Ingress Guide](../../docs/guides/tls-setup.md)
- [cert-manager Documentation](https://cert-manager.io/docs/)

## Support

Issues or questions? [Open an issue](https://github.com/gautampachnanda101/homebrew-tap/issues)
