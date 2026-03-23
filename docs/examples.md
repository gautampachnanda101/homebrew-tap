# Examples & Recipes

Production-ready Kustomize recipes for extending your k3d-local cluster with additional tools and services.

## Table of Contents

- [Available Recipes](#available-recipes)
  - [ArgoCD - GitOps Continuous Delivery](#argocd-gitops-continuous-delivery)
  - [HashiCorp Vault - Secrets Management](#hashicorp-vault-secrets-management)
  - [Harbor - Container Registry](#harbor-container-registry)
  - [GitLab Runner - CI/CD Executor](#gitlab-runner-cicd-executor)
  - [Keycloak - Identity and Access Management](#keycloak-identity-and-access-management)
  - [Authentik - Open Source IDP](#authentik-open-source-idp)
- [Recipe Structure](#recipe-structure)
- [Using Recipes](#using-recipes)
  - [Prerequisites](#prerequisites)
  - [Installation Methods](#installation-methods)
- [Customizing Recipes](#customizing-recipes)
  - [Using Kustomize Overlays](#using-kustomize-overlays)
  - [Common Customizations](#common-customizations)
- [TLS Configuration](#tls-configuration)
  - [Local Development](#local-development)
  - [Production](#production)
- [Contributing Recipes](#contributing-recipes)
- [Support](#support)
- [Related Resources](#related-resources)

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

### HashiCorp Vault - Secrets Management

Install HashiCorp Vault for secure secrets management, encryption, and identity-based access.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ Dev mode for local development (auto-unsealed with root token)
- ✅ Production-ready configuration with sealed storage
- ✅ Kustomize overlays for easy customization

**Quick Start:**
```bash
# Clone or download the examples
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/vault

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain vault.yourdomain.com
```

**Access:**

- Local: https://vault.127.0.0.1.sslip.io
- Root Token (dev mode): `root`
- Production: https://vault.yourdomain.com

[View Vault Recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/vault)

### Harbor - Container Registry

Install Harbor as a cloud-native container registry with vulnerability scanning, image signing, and replication.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ PostgreSQL and Redis backends for scalability
- ✅ Complete registry stack: portal, core, registry, jobservice
- ✅ Kustomize overlays for easy customization

**Quick Start:**
```bash
# Clone or download the examples
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/harbor

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain harbor.yourdomain.com
```

**Access:**

- Local: https://harbor.127.0.0.1.sslip.io
- Default credentials: admin / Harbor12345
- Production: https://harbor.yourdomain.com

[View Harbor Recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/harbor)

### GitLab Runner - CI/CD Executor

Install GitLab Runner with Kubernetes executor for running CI/CD pipelines in your cluster.

**Features:**

- ✅ Kubernetes executor for native pod-based builds
- ✅ RBAC configuration included
- ✅ Works with GitLab.com and self-hosted instances
- ✅ Configurable runner token and GitLab URL
- ✅ Kustomize overlays for easy customization

**Quick Start:**
```bash
# Clone or download the examples
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/gitlab-runner

# Set your GitLab Runner token and URL
export GITLAB_RUNNER_TOKEN="your-registration-token"
export GITLAB_URL="https://gitlab.com"

# Install
./install.sh
```

**Configuration:**

- Get runner token from GitLab: Settings → CI/CD → Runners
- Runner will auto-register with your GitLab instance
- Default executor: Kubernetes (builds run in pods)

[View GitLab Runner Recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/gitlab-runner)

### Keycloak - Identity and Access Management

Install Keycloak for comprehensive identity and access management (IAM) with OpenID Connect and SAML support.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ PostgreSQL backend for production
- ✅ Admin console for managing realms, users, and clients
- ✅ OpenID Connect and SAML protocols
- ✅ Kustomize overlays for easy customization

**Quick Start:**
```bash
# Clone or download the examples
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/keycloak

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain keycloak.yourdomain.com
```

**Access:**

- Local: https://keycloak.127.0.0.1.sslip.io
- Admin credentials: Use get-password.sh script
- Production: https://keycloak.yourdomain.com

[View Keycloak Recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/keycloak)

### Authentik - Open Source IDP

Install Authentik as a modern, flexible identity provider with flow-based authentication and powerful policy engine.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration  
- ✅ PostgreSQL and Redis backends
- ✅ Server/worker architecture for scalability
- ✅ Modern UI with flow-based configuration
- ✅ OpenID Connect, SAML, LDAP support
- ✅ Kustomize overlays for easy customization

**Quick Start:**
```bash
# Clone or download the examples
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/authentik

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain auth.yourdomain.com
```

**Access:**

- Local: https://authentik.127.0.0.1.sslip.io/if/flow/initial-setup/
- First-time: Visit URL above to create admin account
- Admin interface: https://authentik.127.0.0.1.sslip.io/if/admin/
- Production: https://auth.yourdomain.com

[View Authentik Recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/authentik)

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
