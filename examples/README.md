# k3d-local Examples & Recipes

Production-ready recipes for extending your **k3d local Kubernetes clusters** with additional tools and services.

**What are these?** Examples of how to deploy industry-standard tools (ArgoCD, Vault, Harbor, etc.) into a k3d cluster created by [k3d-local](../docs/usage.md#k3d-local-workflows).

## Prerequisites

Before using any example, you **must** have:

1. **k3d-local installed:**
   ```bash
   brew tap gautampachnanda101/tap
   brew install k3d-local
   ```

2. **k3d cluster running with Traefik:**
   ```bash
   k3d-local create --with-traefik
   ```

3. **kubectl configured** (automatic after `k3d-local create`)

Then pick an example and follow its `./install.sh` script.

## Table of Contents

- [Available Recipes](#available-recipes)
  - [ArgoCD](#argocd)
  - [HashiCorp Vault](#hashicorp-vault)
  - [Harbor](#harbor)
  - [GitLab Runner](#gitlab-runner)
  - [Keycloak](#keycloak)
  - [Authentik](#authentik)
  - [Backstage](#backstage)
  - [External Secrets Operator](#external-secrets-operator)
  - [RabbitMQ](#rabbitmq)
  - [Kyverno](#kyverno)
  - [SpiceDB](#spicedb)
  - [OpenFGA](#openfga)
- [Quality Assurance](#quality-assurance)
- [What k3d-local Already Includes](#what-k3d-local-already-includes)
- [Recipe Structure](#recipe-structure)
- [Contributing Recipes](#contributing-recipes)
- [Requirements](#requirements)
- [Support](#support)

## Available Recipes

### [ArgoCD](./argocd/)
Install and configure ArgoCD with proper TLS support for GitOps workflows.

**Features:**
- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ One-command installation
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# 1. Install k3d-local (if you haven't already)
brew tap gautampachnanda101/tap
brew install k3d-local

# 2. Create cluster with Traefik (required!)
k3d-local create --with-traefik

# 3. Install ArgoCD
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd
./install.sh
```

### [HashiCorp Vault](./vault/)
Install and configure Vault for secrets management and encryption.

**Features:**
- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ Dev mode for local development (auto-unsealed)
- ✅ Production-ready configuration with proper storage
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# Same prerequisites as ArgoCD above

# Install Vault
cd homebrew-tap/examples/vault
./install.sh
```

### [Harbor](./harbor/)
Install and configure Harbor as a cloud-native container registry with vulnerability scanning.

**Features:**
- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ PostgreSQL and Redis for persistence
- ✅ Complete registry with portal, core, and registry components
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# Same prerequisites as ArgoCD above

# Install Harbor
cd homebrew-tap/examples/harbor
./install.sh
```

### [GitLab Runner](./gitlab-runner/)
Install GitLab Runner with Kubernetes executor for CI/CD pipelines.

**Features:**
- ✅ Kubernetes executor for native pod-based builds
- ✅ RBAC configuration included
- ✅ Configurable runner token and GitLab URL
- ✅ Support for both GitLab.com and self-hosted instances
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# Same prerequisites as ArgoCD above

# Install GitLab Runner
cd homebrew-tap/examples/gitlab-runner
# Set your token and GitLab URL first
export GITLAB_RUNNER_TOKEN="your-runner-token"
export GITLAB_URL="https://gitlab.com"
./install.sh
```

### [Keycloak](./keycloak/)
Install Keycloak for identity and access management (IAM).

**Features:**
- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ PostgreSQL backend for production
- ✅ Admin console for managing realms and users
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# Same prerequisites as ArgoCD above

# Install Keycloak
cd homebrew-tap/examples/keycloak
./install.sh
```

### [Authentik](./authentik/)
Install Authentik as an alternative open-source identity provider (IDP).

**Features:**
- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ PostgreSQL and Redis backends
- ✅ Server/worker architecture for scalability
- ✅ Modern UI with flow-based configuration
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# Same prerequisites as ArgoCD above

# Install Authentik
cd homebrew-tap/examples/authentik
./install.sh
```

### [Backstage](./backstage/)
Backstage starter recipe for developer portal setup.

**Quick Start:**
```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/backstage
./install.sh
```

### [External Secrets Operator](./external-secrets-operator/)
External Secrets starter with Vault integration examples.

**Quick Start:**
```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/external-secrets-operator
./install.sh
```

### [RabbitMQ](./rabbitmq/)
RabbitMQ starter recipe for local messaging workloads.

**Quick Start:**
```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/rabbitmq
./install.sh
```

### [Kyverno](./kyverno/)
Kyverno starter recipe for policy-as-code.

**Quick Start:**
```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/kyverno
./install.sh
```

### [SpiceDB](./spicedb/)
SpiceDB starter recipe for relationship-based authorization.

**Quick Start:**
```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/spicedb
./install.sh
```

### [OpenFGA](./openfga/)
OpenFGA starter recipe for fine-grained authorization models.

**Quick Start:**
```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/openfga
./install.sh
```

## Quality Assurance

All examples are automatically tested in CI:

- ✅ **Kustomize Syntax Validation** - Ensures all overlays build correctly
- ✅ **Integration Testing** - Deploys to real k3d clusters in GitHub Actions
- ✅ **Health Checks** - Verifies deployments reach ready state
- ✅ **Ingress Testing** - Confirms TLS certificates and routing work

View the latest test results in the [GitHub Actions](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/test-examples.yml) workflow.

## What k3d-local Already Includes

The following capabilities are already built into k3d-local and should not be duplicated as standalone examples:

- Cluster lifecycle and local Kubernetes bootstrap (k3d)
- Traefik ingress with HTTP/HTTPS routing
- cert-manager integration for local CA and Let's Encrypt flows
- Optional telemetry stack via `--with-telemetry` (Grafana, Loki, Mimir, Tempo, Alloy)
- Optional core data stack via `--with-core` (PostgreSQL, ScyllaDB, NATS, Kafka, SeaweedFS)
- Sample app deployment via `--with-apps`

Net-new examples should focus on platform services and workflows layered on top of these built-ins.

## Coming Soon

- **Calico (Tigera)** - Advanced CNI networking and policy
- **Octopus Deploy** - Release orchestration and deployment automation
- **Istio** - Service mesh and traffic management
- **Linkerd** - Lightweight service mesh
- **Consul** - Service discovery and mesh
- **Falco** - Runtime security monitoring
- **kube-hunter** - Kubernetes penetration testing checks
- **Trivy** - Vulnerability and config scanning
- **OPA/Gatekeeper** - Policy enforcement using OPA constraints

## Recipe Structure

Each recipe follows this structure:

```
recipe-name/
├── README.md                    # Setup and operations guide
├── install.sh                   # One-command installation script
├── uninstall.sh                 # Teardown script
├── base/                        # Shared Kustomize base
│   ├── kustomization.yaml
│   └── *.yaml
└── overlays/
  ├── local/                   # Local development overlay
  │   └── kustomization.yaml
  └── prod/                    # Production overlay
    └── kustomization.yaml
```

## Contributing Recipes

Have a recipe you'd like to share? We welcome contributions!

1. Create a new directory under `examples/`
2. Follow the structure above
3. Include comprehensive documentation
4. Test with both local and production configurations
5. Submit a PR

## Requirements

All recipes assume you have:
- **k3d-local** installed and cluster created
- **kubectl** configured
- **helm** installed (for Helm-based recipes)
- **Traefik** enabled (`--with-traefik` flag)

## Support

For issues or questions:
- [Open an issue](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [View k3d-local docs](https://github.com/gautampachnanda101/local-cluster-k3d)
