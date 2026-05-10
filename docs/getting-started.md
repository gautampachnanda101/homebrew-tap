# Getting Started

Get up and running with homebrew-tap tools in 5 minutes.

This tap provides three tools:

- **k3d-local** – Local Kubernetes development environment
- **promptx** – Prompt intelligence CLI with encrypted memory and web UI
- **vaultx** – Zero-trust encrypted secrets CLI with web UI

Choose the tool(s) you want to use to get started.

## k3d-local: Local Kubernetes

Get up and running with k3d-local in 5 minutes.

### Prerequisites

A modern system with:
- **macOS** 10.14+, **Linux** (most distributions), or **Windows 10+**
- **Docker** or **Docker Desktop** pre-installed
- **Internet connection** (for initial downloads)

!!! note
    Other dependencies (k3d, kubectl, helm) can be automatically installed using the `--auto-install` flag.

## Installation

### Quick Install (Recommended)

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

For detailed platform-specific instructions, see [Installation Guide](installation.md).

## Your First Cluster (< 2 minutes)

### Create a Basic Cluster

```bash
k3d-local create
```

This creates a cluster with:
- 1 server node + 2 agent nodes
- Kubernetes v1.31.5+
- Ready-to-use configuration

### Create a Full-Featured Cluster

```bash
k3d-local create --with-traefik --with-apps
```

This includes:
- ✅ k3d cluster
- ✅ Traefik v3 ingress controller
- ✅ Sample applications
- ✅ Pre-configured DNS (sslip.io)

## Access Your Services

Once creation completes, access services at:

| Service | URL |
|---------|-----|
| **Traefik Dashboard** | http://dashboard.127.0.0.1.sslip.io:8080 |
| **Sample App** | http://app.127.0.0.1.sslip.io:8080 |

!!! info
    All services use port 8080 by default (the k3d host port).

## Common Operations

### Deploy an Example Service

Once your cluster is running, deploy production-ready services using the [k3d-local examples](examples.md):

```bash
# Clone the repository
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples

# Deploy ArgoCD for GitOps
cd argocd && ./install.sh

# Or deploy Vault for secrets management
# cd ../vault && ./install.sh

# Or choose from 10+ other services
```

Available examples include:
- **ArgoCD** – GitOps continuous deployment
- **Vault** – Secrets management
- **Harbor** – Container registry
- **Authentik / Keycloak** – Identity management
- **GitLab Runner** – CI/CD executor
- **Backstage** – Developer portal
- **And 6 more** (External Secrets, RabbitMQ, SpiceDB, OpenFGA, Kyverno)

[View all examples →](examples.md)

### Check Cluster Status

```bash
k3d-local status
```

Displays current cluster state and component health.

### Deploy Your Application

```bash
kubectl apply -f your-app.yaml
```

Your cluster has kubectl pre-configured and ready to use.

### Delete Cluster

```bash
k3d-local delete
```

Safely tears down all components and frees resources.

## What's Next?

- Explore [detailed usage patterns](usage.md)
- Set up [Grafana telemetry stack](usage.md#observability)
- Review [available commands](reference/commands.md)
- Check [troubleshooting guide](troubleshooting.md)

## Need Help?

- See [Troubleshooting Guide](troubleshooting.md)
- Visit [k3d documentation](https://k3d.io/)
- Open an issue: [GitHub Issues](https://github.com/gautampachnanda101/homebrew-tap/issues)

---

## Promptx: Encrypted Memory for AI Workflows

Get Promptx up and running in 5 minutes.

### Prerequisites

- **Installed:** `brew install promptx`
- **Git repository** (recommended for context)
- **Internet connection** (for first-time setup)

### Installation

```bash
brew tap gautampachnanda101/tap
brew install promptx
```

### First-Time Setup (< 1 minute)

```bash
promptx setup
```

This creates:
- Encrypted vault for memory storage
- Passkey for encryption
- MCP registrations for IDE integrations

### Your First Memory Capture (< 2 minutes)

Start capturing interactions:

```bash
promptx memory-watch --repo . --interval 5 --force-store
```

This watches for:
- Git commits
- Code changes
- IDE interactions

In another terminal, work normally:

```bash
# Edit code, run tests, ask AI questions, etc.
# Everything is being captured and encrypted locally
```

### Query Your Memory

Ask questions about your session:

```bash
# Search your history
promptx search "function debugging" --repo . --limit 5

# Ask natural language questions
promptx ask "what changed today?" --repo . --limit 6

# Get evidence-based answers
promptx executor "how do we handle errors?" --repo . --limit 8
```

### Generate Prompts

Use local AI:

```bash
promptx generate "write a go cli for file sync"
```

### VS Code Integration

1. Install the VS Code extension:
   ```bash
   code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
   ```

2. In Copilot Chat, use:
   ```
   @promptx What changed in the auth module?
   @promptx /timeline
   ```

### Check Everything Works

```bash
promptx doctor
```

Shows:
- Vault status
- Memory backend health
- MCP registrations
- Configuration

## Vaultx: Encrypted Secrets CLI

Get vaultx running in 2 minutes.

```bash
brew tap gautampachnanda101/tap
brew install vaultx
```

### First-Time Setup

```bash
vaultx init      # create encrypted vault
vaultx unlock    # unlock for this session
```

### Store and Use Secrets

```bash
vaultx set myapp/db_password "s3cr3t"    # store a secret
vaultx get myapp/db_password             # retrieve it
vaultx run -- go run ./cmd/server        # inject into process
```

### Web UI

```bash
vaultx serve
open http://127.0.0.1:7474/
```

The dashboard has two tabs — **Secrets** (manage vault entries) and **Audit Log** (security events). Touch ID unlocks access on macOS.

### Verify Vaultx

```bash
vaultx --version
vaultx unlock
```

## What's Next?

### k3d-local Users

- [k3d-local Tap Guide](taps/k3d-local.md)
- [Detailed usage guide](usage.md#k3d-local-workflows)
- [Helm deployment](helm-deployment.md)
- [Customization options](customization.md)
- [Troubleshooting](troubleshooting.md)

### Promptx Users

- [Promptx Tap Guide](taps/promptx.md)
- [Daily workflows](usage.md#promptx-workflows)
- [VS Code Extension](taps/promptx.md#vs-code-extension)
- [MCP Integration](taps/promptx.md#mcp-integration)

### Vaultx Users

- [Vaultx Tap Guide](taps/vaultx.md)
- [Secrets management](taps/vaultx.md#daily-workflows)
- [MFA setup](taps/vaultx.md#mfa-totp)
- [Backup and recovery](taps/vaultx.md#backup-and-recovery)

### All Tools

- [Explore examples](examples.md)
- [View all commands](reference/commands.md)
- [Advanced usage](usage.md)

## Getting Help

- [Troubleshooting Guide](troubleshooting.md)
- [GitHub Issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [k3d Documentation](https://k3d.io/)
