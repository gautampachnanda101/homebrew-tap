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

### k3d-local

Cross-platform local Kubernetes development environment with k3d.

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

**Links:**
- [Repository](https://github.com/gautampachnanda101/local-cluster-k3d)
- [Tap Documentation](docs/index.md)
- [Public Docs Site](https://gautampachnanda101.github.io/homebrew-tap/)
- [Upstream Project Docs](https://github.com/gautampachnanda101/local-cluster-k3d/tree/main/docs)
- [Releases](https://github.com/gautampachnanda101/local-cluster-k3d/releases)

## Examples & Recipes

Ready-to-use Kustomize recipes for extending your k3d-local cluster:

- **[ArgoCD](examples/argocd/)** - GitOps continuous delivery with proper TLS
- More recipes coming soon (Vault, Harbor, GitLab Runner, etc.)

[View all examples →](examples/README.md)

## Documentation

- Start here: [docs/index.md](docs/index.md)
- Quick start: [docs/getting-started.md](docs/getting-started.md)
- Install guide: [docs/installation.md](docs/installation.md)
- Usage guide: [docs/usage.md](docs/usage.md)
- Helm guide: [docs/helm-deployment.md](docs/helm-deployment.md)
- Customization: [docs/customization.md](docs/customization.md)
- Git workflows: [docs/git-workflows.md](docs/git-workflows.md)
- Troubleshooting: [docs/troubleshooting.md](docs/troubleshooting.md)
- Command reference: [docs/reference/commands.md](docs/reference/commands.md)

---

## General Usage

### List Available Packages
```bash
brew tap gautampachnanda101/tap
brew search gautampachnanda101/tap/
```

### Update Packages
```bash
brew update
brew upgrade <package-name>
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

Formulas are auto-generated from upstream releases. For package-specific issues, please visit the respective project repository.
