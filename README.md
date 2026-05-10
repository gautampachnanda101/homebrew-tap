# Homebrew Tap by @gautampachnanda101

[![Verify Formula](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/verify-formula.yml/badge.svg)](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/verify-formula.yml)
[![Validate Documentation](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/docs-validate.yml/badge.svg)](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/docs-validate.yml)
[![Publish Documentation](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/docs-publish.yml/badge.svg)](https://github.com/gautampachnanda101/homebrew-tap/actions/workflows/docs-publish.yml)

Official Homebrew tap for various cross-platform development tools and utilities.

Public docs (GitHub Pages): https://gautampachnanda101.github.io/homebrew-tap/

## Table of Contents

- [Overview](#overview)
- [Available Packages](#available-packages)
	- [k3d-local](#k3d-local)
- [Documentation](#documentation)
- [General Usage](#general-usage)
	- [List Available Packages](#list-available-packages)
	- [Update Packages](#update-packages)
	- [Uninstall](#uninstall)
- [About](#about)
- [Contributing](#contributing)

## Overview

This tap provides installable formulas and end-user documentation for local development tooling.

## Available Packages

### 1. k3d-local

Cross-platform local Kubernetes development environment with k3d, Traefik v3, and optional telemetry.

**Installation:**
```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

**Quick Start:**
```bash
# Create cluster with defaults
k3d-local create

# Create cluster with Traefik and sample apps
k3d-local create --with-traefik --with-apps

# Create full stack with all components
k3d-local create --with-traefik --with-core --with-telemetry --with-apps

# Check cluster status
k3d-local status

# Delete cluster
k3d-local delete
```

**Features:**
- ✅ One-command Kubernetes cluster setup
- ✅ Production-ready components (k3d, Traefik, self-signed TLS)
- ✅ Cross-platform support (macOS, Linux, Windows)
- ✅ Optional telemetry stack (Grafana LGTM)
- ✅ Auto-installs dependencies

**Perfect for:**

- Local development and testing
- Kubernetes learning and training
- Application prototyping
- CI/CD pipeline validation

**Links:**

- [k3d-local Tap Guide](docs/taps/k3d-local.md)

### 2. Promptx

Local-first prompt intelligence CLI with encrypted memory and cross-tool context handoff for AI coding assistants.

**Installation:**
```bash
brew tap gautampachnanda101/tap
brew install promptx
```

**Quick Start:**

```bash
# Initialize secure vault
promptx setup

# Start memory auto-capture
promptx memory-watch --repo . --interval 5

# Open the web dashboard
promptx serve && promptx ui

# Query memory
promptx memory-query "your topic" --repo . --limit 5

# Execute with evidence
promptx executor "what changed in mcp tools?" --repo . --limit 8
```

**Features:**

- ✅ Local-first encrypted memory capture
- ✅ Web dashboard — insights, timeline, memory, handoff, graph
- ✅ AI cost analytics with live model pricing
- ✅ Cross-tool handoff for GitHub Copilot, Claude, VS Code
- ✅ Evidence-based execution (no guessing)
- ✅ Automatic interaction logging linked to git commits
- ✅ VS Code extension with `@promptx` chat participant
- ✅ MCP server integration

**Perfect for:**

- AI-assisted development workflows
- Tracking AI costs and model usage across tools
- Context handoff between coding assistants
- Team collaboration across tools
- Memory-driven decision making

**Links:**

- [Promptx Tap Guide](docs/taps/promptx.md)
- [Public Docs Site](https://gautampachnanda101.github.io/homebrew-tap/)
- [GitHub Repository](https://github.com/gautampachnanda101/homebrew-tap)
- [GitHub Issues](https://github.com/gautampachnanda101/homebrew-tap/issues)

## Examples & Recipes

Ready-to-use **Kustomize recipes for extending your k3d cluster** created by k3d-local:

- **[ArgoCD](examples/argocd/)** - GitOps continuous delivery with proper TLS
- **[Vault](examples/vault/)** - Secrets management and encryption
- **[Harbor](examples/harbor/)** - Cloud-native container registry
- **[Authentik](examples/authentik/)** - Open-source identity server
- **[Keycloak](examples/keycloak/)** - Identity and access management
- **[GitLab Runner](examples/gitlab-runner/)** - Kubernetes CI/CD executor
- **[Backstage](examples/backstage/)** - Developer platform
- **[External Secrets Operator](examples/external-secrets-operator/)** - Sync secrets from external vaults
- **[RabbitMQ](examples/rabbitmq/)** - Message broker
- **[Kyverno](examples/kyverno/)** - Kubernetes policy engine
- **[SpiceDB](examples/spicedb/)** - Authorization engine
- **[OpenFGA](examples/openfga/)** - Fine-grained authorization

**Deploy an example into your k3d cluster:**

```bash
# Create cluster first
k3d-local create --with-traefik

# Then deploy ArgoCD (or any other example)
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd
./install.sh
```

[View all examples →](examples/README.md)

## Documentation

**Tap Guides:**

- [promptx](docs/taps/promptx.md) — web UI, memory, handoff, MCP, VS Code extension
- [k3d-local](docs/taps/k3d-local.md) — local Kubernetes cluster setup and management
- [vaultx](docs/taps/vaultx.md) — encrypted secrets CLI

**General:**

- Start here: [docs/index.md](docs/index.md)
- Quick start: [docs/getting-started.md](docs/getting-started.md)
- Install guide: [docs/installation.md](docs/installation.md)
- Usage guide: [docs/usage.md](docs/usage.md)
- Troubleshooting: [docs/troubleshooting.md](docs/troubleshooting.md)
- Command reference: [docs/reference/commands.md](docs/reference/commands.md)

**Public site:** <https://gautampachnanda101.github.io/homebrew-tap/>

---

## General Usage

### List Available Packages
```bash
brew tap gautampachnanda101/tap
brew search gautampachnanda101/tap/
```

Currently available:
- `k3d-local` – Local Kubernetes cluster management
- `promptx` – Prompt intelligence CLI with encrypted memory

### Install a Package
```bash
brew install <package-name>

# Examples:
brew install k3d-local
brew install promptx
brew install k3d-local promptx  # Install multiple
```

### Update Packages
```bash
brew update
brew upgrade <package-name>

# Upgrade all:
brew upgrade
```

### Uninstall a Package
```bash
brew uninstall <package-name>
brew uninstall promptx k3d-local  # Uninstall multiple
```

### Uninstall
```bash
brew uninstall <package-name>
brew untap gautampachnanda101/tap  # Remove tap entirely
```

## About

This tap is automatically maintained via GoReleaser for automated formula updates.

All formulas are verified on macOS and Linux via GitHub Actions CI.

## Contributing

Formulas are auto-generated from upstream releases. For package-specific issues, please raise an issue on this repo for the maintainer.
