# Homebrew Tap

Small, practical tools for local Kubernetes, AI-assisted development, and encrypted secrets.

Maintained by [@gautampachnanda101](https://github.com/gautampachnanda101). Install the tap, choose a formula, and use the tool-specific guide when you need more detail.

## Install

```bash
brew tap gautampachnanda101/tap
brew install <formula>
```

Use the [installation guide](installation.md) for Homebrew, Scoop, and direct downloads.

## Formulas

### k3d-local

Local Kubernetes environments built around k3d, Traefik, and optional observability components.

```bash
brew install k3d-local
k3d-local create --with-traefik
```

Read the [k3d-local guide](taps/k3d-local.md), or browse the [service recipes](examples.md).

### Promptx

Encrypted, local-first memory and context handoff for AI coding assistants.

```bash
brew install promptx
promptx setup
```

Read the [Promptx guide](taps/promptx.md) for memory, VS Code, MCP, and web UI workflows.

### Vaultx

An encrypted secrets broker for `.env`-style workflows, runtime injection, and audit logs.

```bash
brew install vaultx
vaultx init --biometric
```

Read the [Vaultx guide](taps/vaultx.md) for providers, MFA, backups, and integrations.

## Find your next step

| Goal | Guide |
| --- | --- |
| Install one or more formulas | [Installation](installation.md) |
| Create a local cluster | [Getting started](getting-started.md) |
| Deploy a service into k3d | [Examples and recipes](examples.md) |
| Learn common workflows | [Usage](usage.md) |
| Find a command or flag | [Command reference](reference/commands.md) |
| Fix a setup problem | [Troubleshooting](troubleshooting.md) |

## Project links

[Source on GitHub](https://github.com/gautampachnanda101/homebrew-tap) · [Report an issue](https://github.com/gautampachnanda101/homebrew-tap/issues) · [Contributing guide](https://github.com/gautampachnanda101/homebrew-tap/blob/main/CONTRIBUTING.md)
