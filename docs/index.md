# Homebrew Tap

Official Homebrew tap for cross-platform development tools maintained by [@gautampachnanda101](https://github.com/gautampachnanda101).

## Overview

This tap provides pre-built formulas for development tools optimized for local development workflows.

### Available Packages

#### k3d-local

A comprehensive CLI tool for managing **local Kubernetes development environments** with k3d, Traefik v3, and cross-platform DNS resolution.

- **One-command setup** for complete Kubernetes cluster
- **Production-ready components**: k3d, Traefik, self-signed TLS
- **Cross-platform support**: macOS, Linux, Windows
- **Optional add-ons**: Grafana LGTM telemetry stack

**Quick install:**
```bash
brew tap gautampachnanda101/tap
brew install k3d-local
k3d-local create --with-traefik --with-apps
```

Perfect for:
- Local development and testing
- Kubernetes learning and training
- Application prototyping
- CI/CD pipeline validation

## Features

✅ **Automated installation** - Auto-detects and installs prerequisites  
✅ **Production-ready cluster** - Best practices built-in  
✅ **Easy management** - Simple CLI for common tasks  
✅ **Comprehensive docs** - Detailed guides for all use cases  
✅ **Active maintenance** - Regular updates via GoReleaser  

## Next Steps

- [Get started in 5 minutes](getting-started.md)
- [View installation options](installation.md)
- [Learn common usage patterns](usage.md)
- [Command reference](reference/commands.md)
