# Installation

Complete installation guide for all packages (k3d-local and Promptx).

## Choose Your Package

This tap provides two main packages:

- **k3d-local** – Local Kubernetes cluster management
- **promptx** – Prompt intelligence CLI with encrypted memory

You can install one or both.

## Homebrew (macOS / Linux)

### Add Tap

```bash
brew tap gautampachnanda101/tap
```

### Install Packages

```bash
# Install k3d-local
brew install k3d-local

# Install promptx
brew install promptx

# Install both
brew install k3d-local promptx
```

### Upgrade

```bash
brew upgrade k3d-local
brew upgrade promptx
brew upgrade             # Upgrade all
```

### Uninstall

```bash
brew uninstall k3d-local
brew uninstall promptx
brew untap gautampachnanda101/tap  # Optional: remove tap entirely
```

## Windows

### Scoop Installation

Promptx and k3d-local are available via Scoop:

```powershell
# Add scoop bucket
scoop bucket add promptx https://github.com/gautampachnanda101/scoop-bucket

# Install
scoop install promptx
scoop install k3d-local
```

### Upgrade

```powershell
scoop update promptx
scoop update k3d-local
```

## Manual Installation (All Platforms)

Download binaries directly from [GitHub Releases](https://github.com/gautampachnanda101/homebrew-tap/releases):

```bash
# Download latest release (Linux x86_64 example)
curl -L https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc59/promptx_Linux_x86_64.tar.gz \
  -o promptx.tar.gz

# Extract
tar xzf promptx.tar.gz

# Move to PATH
sudo mv promptx /usr/local/bin/
chmod +x /usr/local/bin/promptx

# Verify
promptx --version
```

Available archives for each release:
- `promptx_Darwin_x86_64.tar.gz` (macOS Intel)
- `promptx_Darwin_arm64.tar.gz` (macOS Apple Silicon)
- `promptx_Linux_x86_64.tar.gz` (Linux Intel)
- `promptx_Linux_arm64.tar.gz` (Linux ARM)
- `k3d-local_*_*.tar.gz` (all platforms)

## k3d-local Installation

### macOS/Linux Homebrew

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

### Platform-Specific Notes

#### macOS (Apple Silicon &amp; Intel)

Homebrew automatically detects your architecture:

```bash
brew install k3d-local  # Correct version is auto-selected
```

Verify:
```bash
k3d-local --version
```

#### Linux

**Supported distributions:**
- Ubuntu 20.04+
- Debian 11+
- Fedora 34+
- CentOS 8+
- Any with glibc 2.31+

**Via Homebrew/Linuxbrew:**
```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

**Manual installation:**
```bash
# Download
curl -L https://github.com/gautampachnanda101/homebrew-tap/releases/download/v1.0.5/k3d-local_1.0.5_Linux_x86_64.tar.gz \
  -o k3d-local.tar.gz

# Extract and install
tar xzf k3d-local.tar.gz
sudo mv k3d-local /usr/local/bin/
chmod +x /usr/local/bin/k3d-local

# Verify
k3d-local --version
```

### Dependencies for k3d-local

**Required:**
- Docker 20.10+

**Optional (auto-installable with `--auto-install`):**
- k3d 5.8.3+
- kubectl 1.25+
- helm 3.0+

**Install dependencies manually:**

=== "macOS"

    ```bash
    brew install --cask docker
    brew install kubectl helm k3d
    ```

=== "Linux (Ubuntu/Debian)"

    ```bash
    sudo apt-get update
    sudo apt-get install -y docker.io kubectl helm
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
    ```

=== "Linux (Fedora/CentOS)"

    ```bash
    sudo dnf install -y docker kubectl helm
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
    ```

=== "Windows (Scoop)"

    ```powershell
    scoop install docker kubectl helm k3d
    ```

## Promptx Installation

### macOS/Linux Homebrew

```bash
brew tap gautampachnanda101/tap
brew install promptx
```

### Windows (Scoop)

```powershell
scoop bucket add promptx https://github.com/gautampachnanda101/scoop-bucket
scoop install promptx
```

### VS Code Extension (All Platforms)

After installing Promptx, install the VS Code extension:

**macOS/Linux:**
```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

**Windows:**
```powershell
code --install-extension "$env:USERPROFILE\scoop\apps\promptx\current\promptx-vscode-*.vsix"
```

**Manual:**
Extract the release archive and run:
```bash
code --install-extension promptx-vscode-*.vsix
```

### First-Run Setup

After installation, initialize Promptx:

```bash
promptx setup
```

This creates:
- Encrypted vault for memory storage
- Local passkey for encryption
- MCP registration for IDE integrations
- Background memory watch daemon

Verify:
```bash
promptx doctor
promptx machine verify
```

## First-Run Setup

### k3d-local

Create your first cluster:

```bash
# Option 1: Auto-install missing dependencies
k3d-local create --auto-install --with-traefik --with-apps

# Option 2: Manual (dependencies already installed)
k3d-local create --with-traefik --with-apps
```

See [Getting Started](getting-started.md) for details.

### Promptx

Initialize and start capturing:

```bash
# Initialize vault
promptx setup

# Start memory capture
promptx memory-watch --repo . --interval 5 --force-store

# Verify setup
promptx doctor
```

See [Promptx Guide](promptx.md) for details.

## Troubleshooting Installation

### Command Not Found

If `k3d-local` or `promptx` is not recognized:

```bash
# Check if installed
which k3d-local
which promptx

# Reload shell
exec $SHELL

# Check Homebrew
brew --prefix k3d-local
brew --prefix promptx

# Check PATH
echo $PATH
```

### Version Conflicts

Check installed versions:

```bash
brew list k3d-local
brew list promptx

k3d-local --version
promptx --version
```

### Platform-Specific Issues

**macOS ARM64 (Apple Silicon):**

Ensure you're on Homebrew ARM build:
```bash
brew --version
arch  # Should show arm64
```

**Linux glibc version:**

Check system glibc:
```bash
ldd --version
```

Ensure 2.31 or higher for Linux binaries.

### Still Having Issues?

1. Run diagnosis:
   ```bash
   prompts doctor
   prompts machine verify
   ```

2. Check troubleshooting guides:
   - [k3d-local Troubleshooting](troubleshooting.md)
   - [Promptx Guide - Troubleshooting](promptx.md#troubleshooting)

3. Report issues:
   - [GitHub Issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
