# Getting Started

Get up and running with homebrew-tap tools in 5 minutes.

This tap provides three tools:

- **k3d-local** – Local Kubernetes development environment
- **promptx** – Prompt intelligence CLI with encrypted memory and web UI
- **vaultx** – Zero-trust encrypted secrets CLI with web UI

Choose the tool(s) you want to use to get started.

---

## k3d-local: Local Kubernetes

Get up and running with k3d-local in 5 minutes.

### Requirements

A modern system with:

- **macOS** 10.14+, **Linux** (most distributions), or **Windows 10+**
- **Docker** or **Docker Desktop** pre-installed
- **Internet connection** (for initial downloads)

!!! note
    Other dependencies (k3d, kubectl, helm) can be automatically installed using the `--auto-install` flag.

### Install k3d-local

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

For detailed platform-specific instructions, see [Installation Guide](installation.md).

### Create Your First Cluster

**Basic cluster:**

```bash
k3d-local create
```

This creates a cluster with 1 server node, 2 agent nodes, and a ready-to-use kubeconfig.

**Full-featured cluster:**

```bash
k3d-local create --with-traefik --with-apps
```

This includes:

- k3d cluster
- Traefik v3 ingress controller
- Sample applications
- Pre-configured DNS (sslip.io)

### Access Services

Once creation completes, access services at:

| Service           | URL                                              |
| ----------------- | ------------------------------------------------ |
| Traefik Dashboard | <http://dashboard.127.0.0.1.sslip.io/dashboard/> |
| Sample App        | <http://app.127.0.0.1.sslip.io>                  |

!!! info
    k3d-local defaults to port 80 (HTTP) and 443 (HTTPS), so no port suffix is needed in URLs.

### Common Operations

Deploy production-ready services using the [k3d-local examples](examples.md):

```bash
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd
./install.sh
```

Available examples include:

- **ArgoCD** – GitOps continuous deployment
- **Vault** – Secrets management
- **Harbor** – Container registry
- **Authentik / Keycloak** – Identity management
- **GitLab Runner** – CI/CD executor
- **Backstage** – Developer portal
- And 6 more (External Secrets, RabbitMQ, SpiceDB, OpenFGA, Kyverno)

[View all examples →](examples.md)

Check cluster status:

```bash
k3d-local status
```

Delete cluster:

```bash
k3d-local delete
```

---

## Promptx: Encrypted Memory for AI Workflows

Get Promptx up and running in 5 minutes.

Install:

```bash
brew tap gautampachnanda101/tap
brew install promptx
```

A Git repository and internet connection are recommended for first-time setup.

### Initialize Promptx

```bash
promptx setup
```

This creates:

- Encrypted vault for memory storage
- Passkey for encryption
- MCP registrations for IDE integrations

### Capture Memory

Start capturing interactions:

```bash
promptx memory-watch --repo . --interval 5 --force-store
```

This watches for:

- Git commits
- Code changes
- IDE interactions

In another terminal, work normally — everything is captured and encrypted locally.

### Query Memory

```bash
# Search your history
promptx search "function debugging" --repo . --limit 5

# Ask natural language questions
promptx ask "what changed today?" --repo . --limit 6

# Get evidence-based answers
promptx executor "how do we handle errors?" --repo . --limit 8
```

### VS Code Extension

1. Install the extension:

   ```bash
   code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
   ```

2. In Copilot Chat, use:

   ```text
   @promptx What changed in the auth module?
   @promptx /timeline
   ```

### Verify Promptx

```bash
promptx doctor
```

Shows vault status, memory backend health, MCP registrations, and configuration.

---

## Vaultx: Encrypted Secrets CLI

Get vaultx running in 2 minutes.

Install:

```bash
brew tap gautampachnanda101/tap
brew install vaultx
```

### Initialize Vaultx

```bash
vaultx init --biometric   # create vault + enable Touch ID (macOS)
vaultx unlock             # unlock for this session
```

### Store and Use Secrets

```bash
vaultx set myapp/db_password "s3cr3t"    # store a secret
vaultx get myapp/db_password             # retrieve it
vaultx run -- go run ./cmd/server        # inject into process
```

### Vaultx Web UI

```bash
vaultx serve
open http://127.0.0.1:7474/
```

The dashboard has two tabs — **Secrets** (manage vault entries) and **Audit Log** (security events). Touch ID unlocks access on macOS.

### Verify Vaultx

```bash
vaultx version
vaultx doctor
```

---

## Next Steps

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

## Need Help?

- [Troubleshooting Guide](troubleshooting.md)
- [GitHub Issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [k3d Documentation](https://k3d.io/)
