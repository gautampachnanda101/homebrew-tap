# Homebrew Tap

Official Homebrew tap for cross-platform development tools maintained by [@gautampachnanda101](https://github.com/gautampachnanda101).

## Overview

This tap provides pre-built formulas for development tools optimized for local development and AI-assisted workflows. All tools are cross-platform, zero-configuration, and production-ready.

## Available Packages

### 🐳 k3d-local

A comprehensive CLI tool for managing **local Kubernetes development environments** with k3d, Traefik v3, and cross-platform DNS resolution.

**Key features:**
- ✅ One-command setup for complete Kubernetes cluster
- ✅ Production-ready components: k3d, Traefik v3, self-signed TLS
- ✅ Cross-platform support: macOS, Linux, Windows
- ✅ Optional add-ons: sample apps, core components, Grafana LGTM telemetry
- ✅ Local container registry
- ✅ Automatic kubectl configuration
- ✅ **12 example services ready to deploy** (ArgoCD, Vault, Harbor, Keycloak, etc.)

**Quick install:**
```bash
brew tap gautampachnanda101/tap
brew install k3d-local
k3d-local create --with-traefik
```

Once your cluster is created, deploy services from [examples](examples.md) using simple install scripts.

**Perfect for:**
- Local development and testing
- Kubernetes learning and training
- Application prototyping
- CI/CD pipeline validation
- Edge computing simulation

### 🧠 Promptx

Local-first prompt intelligence CLI with encrypted memory and cross-tool context handoff. Integrates with GitHub Copilot, Claude, and VS Code.

**Key features:**
- ✅ Local-first encrypted memory capture and retrieval
- ✅ Cross-tool handoff (GitHub Copilot ↔ Claude ↔ VS Code)
- ✅ Evidence-based execution (no guessing)
- ✅ Automatic interaction logging linked to git commits
- ✅ VS Code extension with `@promptx` chat participant
- ✅ MCP server integration for IDE connectors
- ✅ Fuzzy and semantic search over encrypted history
- ✅ Self-learning from executor outcomes

**Quick install:**
```bash
brew tap gautampachnanda101/tap
brew install promptx
promptx setup
promptx memory-watch --repo . --interval 5
```

**Perfect for:**
- AI-assisted development workflows
- Prompt engineering and generation
- Context-aware coding assistance across tools
- Team collaboration with encrypted memory
- Learning from AI interactions

## Documentation by Tool

### k3d-local
- [Get started in 5 minutes](getting-started.md)
- [Installation guide](installation.md)
- [Usage patterns](usage.md)
- [Command reference](reference/commands.md)
- [Troubleshooting](troubleshooting.md)
- [Helm deployment](helm-deployment.md)
- [Customization](customization.md)

### Promptx
- [Promptx Guide](promptx.md)
- [Installation & Setup](promptx.md#installation)
- [Daily Workflows](promptx.md#daily-workflows)
- [VS Code Extension](promptx.md#vs-code-extension)
- [MCP Integration](promptx.md#mcp-integration)

## Resources

- 🏠 **Public Docs Site**: https://gautampachnanda101.github.io/homebrew-tap/
- 📦 **GitHub Repository**: https://github.com/gautampachnanda101/homebrew-tap
- 🐛 **Report Issues**: https://github.com/gautampachnanda101/homebrew-tap/issues
- 💬 **GitHub Discussions**: https://github.com/gautampachnanda101/homebrew-tap/discussions
