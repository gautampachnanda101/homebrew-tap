# Getting Started

Get up and running with k3d-local in 5 minutes.

## Prerequisites

A modern system with:
- **macOS** 10.14+, **Linux** (most distributions), or **Windows 10+**
- **Docker** or **Docker Desktop** pre-installed
- **Internet connection** (for initial downloads)

!!! note
    Other dependencies (k3d, kubectl, helm) can be automatically installed using the `--auto-install` flag.

## Installation

### Quick Install (Recommended)

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

For detailed platform-specific instructions, see [Installation Guide](installation.md).

## Your First Cluster (< 2 minutes)

### Create a Basic Cluster

```bash
k3d-local create
```

This creates a cluster with:
- 1 server node + 2 agent nodes
- Kubernetes v1.31.5+
- Ready-to-use configuration

### Create a Full-Featured Cluster

```bash
k3d-local create --with-traefik --with-apps
```

This includes:
- ✅ k3d cluster
- ✅ Traefik v3 ingress controller
- ✅ Sample applications
- ✅ Pre-configured DNS (sslip.io)

## Access Your Services

Once creation completes, access services at:

| Service | URL |
|---------|-----|
| **Traefik Dashboard** | http://dashboard.127.0.0.1.sslip.io:8080 |
| **Sample App** | http://app.127.0.0.1.sslip.io:8080 |

!!! info
    All services use port 8080 by default (the k3d host port).

## Common Operations

### Check Cluster Status

```bash
k3d-local status
```

Displays current cluster state and component health.

### Deploy Your Application

```bash
kubectl apply -f your-app.yaml
```

Your cluster has kubectl pre-configured and ready to use.

### Delete Cluster

```bash
k3d-local delete
```

Safely tears down all components and frees resources.

## What's Next?

- Explore [detailed usage patterns](usage.md)
- Set up [Grafana telemetry stack](usage.md#observability)
- Review [available commands](reference/commands.md)
- Check [troubleshooting guide](troubleshooting.md)

## Need Help?

- See [Troubleshooting Guide](troubleshooting.md)
- Visit [k3d documentation](https://k3d.io/)
- Open an issue: [GitHub Issues](https://github.com/gautampachnanda101/local-cluster-k3d/issues)
