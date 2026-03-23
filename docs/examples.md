# Examples & Recipes

Production-ready Kustomize recipes for extending your k3d-local cluster with additional tools and services.

## Available Recipes

### ArgoCD - GitOps Continuous Delivery

Install ArgoCD with proper TLS support for managing your Kubernetes applications using GitOps principles.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration with HTTP and gRPC support
- ✅ One-command installation via script or kubectl
- ✅ Kustomize overlays for easy customization
- ✅ High availability configuration for production

**Quick Start:**
```bash
# Clone or download the examples
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain yourdomain.com
```

**Access:**

- Local: https://argocd.127.0.0.1.sslip.io
- Production: https://argocd.yourdomain.com

[View ArgoCD Recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/argocd)

## Coming Soon

We're working on additional recipes for popular cloud-native tools:

- **HashiCorp Vault** - Secrets management and encryption
- **Harbor** - Container registry with vulnerability scanning
- **GitLab Runner** - CI/CD pipeline execution
- **Keycloak** - Identity and access management
- **Backstage** - Developer portal and service catalog

## Recipe Structure

Each recipe follows a consistent structure using Kustomize:

```
recipe-name/
├── base/                       # Base Kubernetes manifests
│   ├── kustomization.yaml     # Base kustomize config
│   └── *.yaml                 # Resource definitions
├── overlays/
│   ├── local/                 # Local development overlay
│   │   └── kustomization.yaml
│   └── prod/                  # Production overlay
│       └── kustomization.yaml
├── install.sh                 # Installation script
├── get-password.sh            # Helper scripts (if needed)
├── uninstall.sh               # Cleanup script
└── README.md                  # Detailed documentation
```

## Using Recipes

### Prerequisites

All recipes require:
1. **k3d-local cluster** created with Traefik:
   ```bash
   k3d-local create --with-traefik
   ```

2. **kubectl** configured to access your cluster

3. **Kustomize** (optional, kubectl has built-in support)

### Installation Methods

#### Option 1: Using the Installation Script (Recommended)
```bash
cd examples/recipe-name
./install.sh
```

#### Option 2: Using kubectl with Kustomize
```bash
# Local development
kubectl apply -k examples/recipe-name/overlays/local/

# Production
kubectl apply -k examples/recipe-name/overlays/prod/
```

#### Option 3: Using Kustomize CLI
```bash
kustomize build examples/recipe-name/overlays/local/ | kubectl apply -f -
```

## Customizing Recipes

### Using Kustomize Overlays

Create your own overlay to customize any recipe:

```bash
# Create custom overlay
mkdir -p examples/recipe-name/overlays/custom
cd examples/recipe-name/overlays/custom

# Create kustomization.yaml
cat <<EOF > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

# Add your customizations
patches:
  - target:
      kind: Deployment
      name: my-app
    patch: |-
      - op: replace
        path: /spec/replicas
        value: 3
EOF

# Apply your custom overlay
kubectl apply -k .
```

### Common Customizations

**Change domain:**
```yaml
patches:
  - target:
      kind: Certificate
    patch: |-
      - op: replace
        path: /spec/dnsNames/0
        value: app.mydomain.com
```

**Adjust resources:**
```yaml
patches:
  - target:
      kind: Deployment
    patch: |-
      - op: add
        path: /spec/template/spec/containers/0/resources
        value:
          limits:
            cpu: 1000m
            memory: 1Gi
```

**Change namespace:**
```yaml
namespace: my-custom-namespace
```

## TLS Configuration

### Local Development

Recipes use self-signed certificates by default:
- ClusterIssuer: `local-dev-ca-issuer`
- Domain: `*.127.0.0.1.sslip.io`
- Automatic certificate issuance via cert-manager

### Production

For production with Let's Encrypt:

1. Create cluster with Let's Encrypt support:
   ```bash
   k3d-local create --with-traefik --use-letsencrypt \
     --domain yourdomain.com \
     --email admin@yourdomain.com
   ```

2. Use production overlay:
   ```bash
   ./install.sh --environment prod --domain yourdomain.com
   ```

**Requirements:**

- Domain must resolve to cluster's public IP
- Port 80 accessible for HTTP-01 challenge
- Port 443 for HTTPS traffic

## Contributing Recipes

We welcome recipe contributions! If you've created a useful recipe:

1. Fork the repository
2. Create your recipe following the structure above
3. Test with both local and production configurations
4. Include comprehensive documentation
5. Submit a pull request

**Guidelines:**

- Use Kustomize for all configuration
- Support both local and production environments
- Include installation and uninstall scripts
- Document all prerequisites and requirements
- Test TLS configuration thoroughly
- Follow Kubernetes best practices

## Support

- [Report issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [View k3d-local documentation](https://github.com/gautampachnanda101/local-cluster-k3d)
- [Browse source code](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples)

## Related Resources

- [k3d-local Documentation](index.md)
- [Kustomize Documentation](https://kustomize.io/)
- [cert-manager Documentation](https://cert-manager.io/docs/)
- [Traefik Documentation](https://doc.traefik.io/traefik/)
