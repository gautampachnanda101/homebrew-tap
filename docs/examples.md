# Examples & Recipes

Practical recipes and workflows, grouped by the tool they extend.

<div class="formula-grid">
  <article class="formula-item">
    <p class="formula-number">01</p>
    <h3>k3d-local</h3>
    <p>Kustomize recipes that deploy production-style services — ArgoCD, Vault, Harbor, and more — into your local cluster.</p>
    <a href="#k3d-local-cluster-recipes">Jump to k3d-local -&gt;</a>
  </article>
  <article class="formula-item">
    <p class="formula-number">02</p>
    <h3>Promptx</h3>
    <p>Capture AI coding context automatically, then query, share, or surface it from the CLI, web UI, or editor.</p>
    <a href="#promptx-workflow-examples">Jump to Promptx -&gt;</a>
  </article>
  <article class="formula-item">
    <p class="formula-number">03</p>
    <h3>Vaultx</h3>
    <p>Inject secrets into a process, shell, Docker Compose, or Kubernetes without ever writing values to disk.</p>
    <a href="#vaultx-secret-injection-examples">Jump to Vaultx -&gt;</a>
  </article>
</div>

## k3d-local Cluster Recipes

Kustomize recipes that deploy production-style services into your k3d-local cluster.

### Prerequisites

All recipes require:

1. **k3d-local cluster** created with Traefik:

   ```bash
   k3d-local create --with-traefik
   ```

2. **kubectl** configured to access your cluster
3. **Kustomize** (optional, kubectl has built-in support)

### Installation methods

#### Option 1: Using the installation script (recommended)

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

#### Option 3: Using the Kustomize CLI

```bash
kustomize build examples/recipe-name/overlays/local/ | kubectl apply -f -
```

### Production-ready recipes

These six ship with local and production overlays, TLS, and dedicated docs.

#### ArgoCD - GitOps Continuous Delivery

Install ArgoCD with proper TLS support for managing your Kubernetes applications using GitOps principles.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration with HTTP and gRPC support
- ✅ One-command installation via script or kubectl
- ✅ Kustomize overlays for easy customization
- ✅ High availability configuration for production

**Quick Start:**

```bash
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain yourdomain.com
```

**Access:**

- Local: `https://argocd.127.0.0.1.sslip.io`
- Production: `https://argocd.yourdomain.com`

[View ArgoCD recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/argocd)

#### HashiCorp Vault - Secrets Management

Install HashiCorp Vault for secure secrets management, encryption, and identity-based access.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ Dev mode for local development (auto-unsealed with root token)
- ✅ Production-ready configuration with sealed storage
- ✅ Kustomize overlays for easy customization

**Quick Start:**

```bash
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/vault

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain vault.yourdomain.com
```

**Access:**

- Local: `https://vault.127.0.0.1.sslip.io`
- Dev-mode token: use the value printed by the install script; never use dev mode outside local testing.
- Production: `https://vault.yourdomain.com`

[View Vault recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/vault)

#### Harbor - Container Registry

Install Harbor as a cloud-native container registry with vulnerability scanning, image signing, and replication.

**Features:**

- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ PostgreSQL and Redis backends for scalability
- ✅ Complete registry stack: portal, core, registry, jobservice
- ✅ Kustomize overlays for easy customization

**Quick Start:**

```bash
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/harbor

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain harbor.yourdomain.com
```

**Access:**

- Local: `https://harbor.127.0.0.1.sslip.io`
- Credentials: set and rotate them before sharing the registry.
- Production: `https://harbor.yourdomain.com`

[View Harbor recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/harbor)

#### GitLab Runner - CI/CD Executor

Install GitLab Runner with Kubernetes executor for running CI/CD pipelines in your cluster.

**Features:**

- ✅ Kubernetes executor for native pod-based builds
- ✅ RBAC configuration included
- ✅ Works with GitLab.com and self-hosted instances
- ✅ Configurable runner token and GitLab URL
- ✅ Kustomize overlays for easy customization

**Quick Start:**

```bash
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

[View GitLab Runner recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/gitlab-runner)

#### Keycloak - Identity and Access Management

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
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/keycloak

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain keycloak.yourdomain.com
```

**Access:**

- Local: `https://keycloak.127.0.0.1.sslip.io`
- Admin credentials: use the `get-password.sh` script
- Production: `https://keycloak.yourdomain.com`

[View Keycloak recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/keycloak)

#### Authentik - Open Source IDP

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
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/authentik

# Install for local development
./install.sh

# Or for production with Let's Encrypt
./install.sh --environment prod --domain auth.yourdomain.com
```

**Access:**

- Local: `https://authentik.127.0.0.1.sslip.io/if/flow/initial-setup/`
- First-time: visit the URL above to create an admin account
- Admin interface: `https://authentik.127.0.0.1.sslip.io/if/admin/`
- Production: `https://auth.yourdomain.com`

[View Authentik recipe →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/authentik)

### Starter recipes

Six more scaffolds for local experimentation. They install the same way and are lighter-weight than the recipes above — expect to add real policies, resources, or config before relying on them.

| Recipe | What it scaffolds | Directory |
| --- | --- | --- |
| Backstage | Developer portal starter | `examples/backstage` |
| External Secrets Operator | Integrates External Secrets with Vault (example `SecretStore` / `ExternalSecret`) | `examples/external-secrets-operator` |
| Kyverno | Policy-as-code and admission control starter | `examples/kyverno` |
| OpenFGA | Fine-grained authorization model starter | `examples/openfga` |
| RabbitMQ | Local async messaging with the management UI | `examples/rabbitmq` |
| SpiceDB | Relationship-based authorization starter (in-memory datastore) | `examples/spicedb` |

**Quick Start** (swap in the directory from the table above):

```bash
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/<recipe-directory>
./install.sh
```

[Browse all recipes on GitHub →](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples)

### Recipe structure

Each recipe follows a consistent structure using Kustomize:

```text
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

### Customizing recipes

#### Using Kustomize overlays

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

#### Common customizations

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

### TLS configuration

#### Local development

Recipes use self-signed certificates by default:

- ClusterIssuer: `local-dev-ca-issuer`
- Domain: `*.127.0.0.1.sslip.io`
- Automatic certificate issuance via cert-manager

#### Production

For production with Let's Encrypt:

1. Create the cluster with Let's Encrypt support:

   ```bash
   k3d-local create --with-traefik --use-letsencrypt \
     --domain yourdomain.com \
     --email admin@yourdomain.com
   ```

2. Use the production overlay:

   ```bash
   ./install.sh --environment prod --domain yourdomain.com
   ```

**Requirements:**

- Domain must resolve to the cluster's public IP
- Port 80 accessible for the HTTP-01 challenge
- Port 443 for HTTPS traffic

### Contributing recipes

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

## Promptx Workflow Examples

Local-first prompt intelligence for AI coding assistants: capture your assistant and git activity, store it encrypted on your machine, and pull the relevant slice back into any assistant's prompt.

### Capture context automatically

```bash
brew install promptx
promptx setup                 # encrypted vault; passkey in the OS keychain
promptx memory-watch --repo . # background capture of commits, diffs, IDE activity
```

### Query memory from the CLI

```bash
promptx search "function debugging"
promptx ask "what changed today?" --repo . --limit 5
promptx execute "how do we handle errors here?" --repo .
```

### Share conventions as context packs

```bash
promptx skill install code-review-checklist   # from the shared registry
promptx skill enable code-review-checklist    # applied to every generate/ask, no flags
promptx generate "add retry logic to the HTTP client"
```

### Run as a background service with a web UI

```bash
brew services start promptx   # promptx serve on http://localhost:17171
promptx ui                    # opens the dashboard: graph, insights, timeline, memory
```

### Editor integration (VS Code / Copilot Chat)

```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

Then, in Copilot Chat: `@promptx what changed in the auth module?`

[Full Promptx guide →](taps/promptx.md)

## Vaultx Secret Injection Examples

Zero-trust secrets broker: commit `vaultx.env` (references only, never values), and vaultx injects the real secrets into your process at runtime. Nothing is written to disk in plain text.

### Store and inject a secret

```bash
vaultx init --biometric              # create vault + enable Touch ID (macOS)
vaultx set myapp/db_password "<your-secret>"
vaultx run -- go run ./cmd/server    # secret is injected into the process env
```

### Reference file (safe to commit)

```env
DB_PASSWORD=vaultx://myapp/db_password
API_KEY=vaultx://myapp/api_key
```

### Inject into the current shell

```bash
eval $(vaultx shell)
```

### Docker Compose

```bash
vaultx docker compose -- up --build
```

### Kubernetes / External Secrets

```bash
vaultx k3d    # helpers for k3d / Kubernetes External Secrets integration
```

Pairs with the [External Secrets Operator recipe](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples/external-secrets-operator) above to pull vaultx-managed secrets into a k3d-local cluster.

### CI pipeline

```bash
vaultx unlock
vaultx run -- npm test
```

[Full Vaultx guide →](taps/vaultx.md)

## Support

- [Report issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [Browse source code](https://github.com/gautampachnanda101/homebrew-tap/tree/main/examples)

## Related Resources

- [k3d-local Documentation](index.md)
- [Promptx guide](taps/promptx.md)
- [Vaultx guide](taps/vaultx.md)
- [Kustomize Documentation](https://kustomize.io/)
- [cert-manager Documentation](https://cert-manager.io/docs/)
- [Traefik Documentation](https://doc.traefik.io/traefik/)
