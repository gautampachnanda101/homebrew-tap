# Homebrew Tap by @gautampachnanda101

Official Homebrew tap for various cross-platform development tools and utilities.

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
- [Documentation](https://github.com/gautampachnanda101/local-cluster-k3d/tree/main/docs)
- [Releases](https://github.com/gautampachnanda101/local-cluster-k3d/releases)

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
