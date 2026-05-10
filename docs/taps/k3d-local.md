# k3d-local Tap Guide

## Purpose

`k3d-local` is a cross-platform CLI for creating and managing local Kubernetes clusters with k3d and preconfigured components for developer environments.

## Install

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

Verify:

```bash
k3d-local version
```

## Basic Usage

```bash
# Create a cluster
k3d-local create --with-traefik

# Check status
k3d-local status

# Delete cluster
k3d-local delete
```

## Troubleshooting

### Docker is not running

`k3d-local` depends on Docker being available.

```bash
open -a Docker
# or
brew services start docker
```

### Port conflicts during cluster startup

```bash
lsof -i :8080
lsof -i :443
```

Stop conflicting processes or reconfigure your local setup before rerunning `k3d-local create`.

### Missing Kubernetes tooling

Install common dependencies:

```bash
brew install k3d kubectl helm
```
