# Installation

Complete installation guide for all platforms.

## Homebrew (macOS / Linux)

### Add Tap

```bash
brew tap gautampachnanda101/tap
```

### Install Package

```bash
brew install k3d-local
```

### Upgrade

```bash
brew upgrade k3d-local
```

### Uninstall

```bash
brew uninstall k3d-local
brew untap gautampachnanda101/tap  # Optional: remove tap entirely
```

## macOS-Specific Notes

### M1/M2/M3 Apple Silicon

The formula automatically detects and uses the ARM64 binary:

```bash
brew install k3d-local  # Automatically installs correct version
```

### Intel Macs

Similarly, Intel 64-bit binaries are automatically selected.

### Verify Installation

```bash
k3d-local --version
```

## Linux

### Supported Distributions

- Ubuntu 20.04+
- Debian 11+
- Fedora 34+
- CentOS 8+
- Any other distribution with glibc 2.31+

### Install via Homebrew (Linuxbrew)

If you have Linuxbrew installed:

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

### Manual Installation

If Homebrew isn't available:

```bash
# Download latest release
curl -L https://github.com/gautampachnanda101/local-cluster-k3d/releases/download/v1.0.3/k3d-local_1.0.3_Linux_x86_64.tar.gz -o k3d-local.tar.gz

# Extract
tar xzf k3d-local.tar.gz

# Install to PATH
sudo mv k3d-local /usr/local/bin/
chmod +x /usr/local/bin/k3d-local

# Verify
k3d-local --version
```

## Dependencies

### Required

- **Docker** 20.10+ (must be installed separately)

### Optional (Auto-installable)

The `--auto-install` flag will automatically detect and install:

- **k3d** 5.8.3+
- **kubectl** 1.25+
- **helm** 3.0+

### Manual Dependency Installation

If you prefer to install manually:

=== "macOS"

    ```bash
    # Docker Desktop
    brew install --cask docker
    
    # Kubernetes tools
    brew install kubectl helm k3d
    ```

=== "Linux"

    ```bash
    # Ubuntu/Debian
    sudo apt-get update
    sudo apt-get install -y docker.io kubectl helm
    
    # k3d
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
    ```

=== "Windows"

    ```powershell
    # Using Scoop
    scoop bucket add main
    scoop install docker kubectl helm k3d
    ```

## First-Run Setup

After installation, start your first cluster:

```bash
# Option 1: Auto-install missing dependencies
k3d-local create --auto-install --with-traefik --with-apps

# Option 2: Manual prerequisite check
k3d-local create --with-traefik --with-apps
```

See [Getting Started](getting-started.md) for your next steps.

## Troubleshooting Installation

### Command Not Found

If `k3d-local` is not recognized after installation:

```bash
# Verify Homebrew installation
which k3d-local

# If empty, reload shell
exec $SHELL

# If still empty, check Homebrew paths
brew --prefix k3d-local
```

### Version Conflicts

Check installed version:

```bash
brew list k3d-local
k3d-local --version
```

To install a specific version:

```bash
brew install k3d-local@1.0.3  # May vary by version
```

### See Also

- [Troubleshooting Guide](troubleshooting.md)
- [GitHub Releases](https://github.com/gautampachnanda101/local-cluster-k3d/releases)
