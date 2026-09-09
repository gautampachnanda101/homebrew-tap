<div class="home-hero">

# Tools for the local-first developer

One tap for **Kubernetes environments, AI workflow memory, and encrypted secrets**. Install what you need, keep it close to your machine, and get back to building.

</div>

<div class="quick-start">

**Start here**

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
k3d-local create --with-traefik
```

New to the tap? Follow the [5-minute getting started guide](getting-started.md). Looking for another tool? Browse the [tap catalog](taps/index.md).

</div>

## Pick your tool

<div class="grid cards" markdown>

<div class="tool-card" markdown>

### k3d-local

Create a useful local Kubernetes environment without stitching together the same setup scripts every time.

`brew install k3d-local`

- Traefik v3 and local TLS
- Optional observability and sample apps
- 12 ready-to-deploy service recipes

[Open the k3d-local guide](taps/k3d-local.md){ .md-button }

</div>

<div class="tool-card" markdown>

### Promptx

Keep AI-assisted development context searchable, encrypted, and available across your coding tools.

`brew install promptx`

- Local-first encrypted memory
- VS Code and MCP integrations
- Evidence-backed handoffs and search

[Open the Promptx guide](taps/promptx.md){ .md-button }

</div>

<div class="tool-card" markdown>

### Vaultx

Use `.env`-style workflows without leaving secrets in plaintext files or shell history.

`brew install vaultx`

- Encrypted local vault
- Touch ID support on macOS
- Safe secret injection into commands

[Open the Vaultx guide](taps/vaultx.md){ .md-button }

</div>

</div>

## Choose your next move

| You want to... | Start with |
| --- | --- |
| Install one or more tools | [Installation](installation.md) |
| Create your first local cluster | [Getting started](getting-started.md) |
| Deploy a service into k3d | [Examples and recipes](examples.md) |
| Learn the day-to-day commands | [Usage guide](usage.md) |
| Find a flag or command | [Command reference](reference/commands.md) |
| Fix a setup problem | [Troubleshooting](troubleshooting.md) |

## Built for local work

These formulas are maintained by [@gautampachnanda101](https://github.com/gautampachnanda101) for workflows where fast feedback, portable tooling, and control over your data matter.

!!! tip "Keep the catalog handy"
	Add this site to your bookmarks, or jump directly to the [tap catalog](taps/index.md) whenever you need a tool-specific install or troubleshooting path.

<div class="grid cards" markdown>

- :fontawesome-brands-github: **[Source on GitHub](https://github.com/gautampachnanda101/homebrew-tap)**

- :fontawesome-solid-bug: **[Report an issue](https://github.com/gautampachnanda101/homebrew-tap/issues)**

- :fontawesome-solid-code-branch: **[Contributing guide](https://github.com/gautampachnanda101/homebrew-tap/blob/main/CONTRIBUTING.md)**

</div>
