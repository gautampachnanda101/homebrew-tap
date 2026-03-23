# Command Reference

Complete reference for k3d-local CLI commands.

## Cluster Management

### create

Create a new k3d cluster with optional components.

**Syntax:**
```bash
k3d-local create [OPTIONS]
```

**Options:**

| Option | Description | Default |
|--------|-------------|---------|
| `--name` | Cluster name | k3d-local |
| `--servers` | Number of server nodes | 1 |
| `--agents` | Number of agent nodes | 2 |
| `--with-traefik` | Install Traefik ingress controller | disabled |
| `--with-apps` | Deploy sample applications | disabled |
| `--with-telemetry` | Deploy observability stack (Grafana LGTM) | disabled |
| `--with-core` | Install core components only | disabled |
| `--auto-install` | Auto-install missing prerequisites | disabled |
| `--k3d-version` | Specific k3d version | latest |
| `--verbose` | Enable verbose output | disabled |

**Examples:**

```bash
# Minimal cluster
k3d-local create

# Full-featured cluster
k3d-local create --with-traefik --with-apps

# With observability
k3d-local create --with-traefik --with-apps --with-telemetry

# Auto-install dependencies
k3d-local create --auto-install --with-traefik --with-apps

# Custom cluster size
k3d-local create --servers 3 --agents 4

# Specific k3d version
k3d-local create --k3d-version 5.8.3
```

### status

Display current cluster status and health information.

**Syntax:**
```bash
k3d-local status [OPTIONS]
```

**Options:**

| Option | Description |
|--------|-------------|
| `--name` | Cluster name (if not using default) |
| `--verbose` | Show detailed information |

**Output includes:**
- Node status (Ready/NotReady)
- Running containers
- Port mappings
- Service URLs
- Component health

**Example:**
```bash
k3d-local status
```

### delete

Remove cluster and clean up resources.

**Syntax:**
```bash
k3d-local delete [OPTIONS]
```

**Options:**

| Option | Description |
|--------|-------------|
| `--name` | Cluster name |
| `--verbose` | Show detailed deletion steps |

!!! warning
    This permanently removes cluster data.

**Example:**
```bash
k3d-local delete
```

## Component Management

### setup-traefik

Install or upgrade Traefik ingress controller.

**Syntax:**
```bash
k3d-local setup-traefik [OPTIONS]
```

**Includes:**
- Traefik v3 controller
- Dashboard configuration
- SSL/TLS support

### setup-apps

Deploy sample applications.

**Syntax:**
```bash
k3d-local setup-apps [OPTIONS]
```

**Deploys:**
- Sample hello-world application
- Ingress configuration
- Service endpoints

### setup-telemetry

Deploy Grafana LGTM observability stack.

**Syntax:**
```bash
k3d-local setup-telemetry [OPTIONS]
```

**Includes:**
- Grafana
- Loki (logs)
- Mimir (metrics)
- Tempo (traces)
- Alloy (data collection)

**Credentials:** `admin` / `admin`

## Utility Commands

### version

Show k3d-local version.

**Syntax:**
```bash
k3d-local version
```

**Output:**
```
k3d-local v1.0.3
```

### help

Display help information.

**Syntax:**
```bash
k3d-local help
k3d-local <command> --help
```

**Examples:**
```bash
k3d-local help
k3d-local create --help
```

## Combined Operations

### Quick Setups

**Full development environment (recommended):**
```bash
k3d-local create --with-traefik --with-apps
```

**With observability:**
```bash
k3d-local create --with-traefik --with-apps --with-telemetry
```

**Auto-install dependencies:**
```bash
k3d-local create --auto-install --with-traefik --with-apps
```

## Docker & Kubernetes Integration

### Using kubectl

k3d-local automatically configures kubectl:

```bash
# Get cluster info
kubectl cluster-info

# List nodes
kubectl get nodes

# Get all resources
kubectl get all --all-namespaces

# View logs
kubectl logs -f deployment/app-name

# Port forward
kubectl port-forward svc/app-name 3000:3000
```

### Using docker

Access cluster containers directly:

```bash
# List cluster containers
docker ps | grep k3d

# View kube-system namespace
docker ps | grep k3d-local-server

# Inspect node
docker logs k3d-local-server-0
```

## Configuration

### Environment Variables

Control k3d-local behavior via environment variables:

```bash
# Number of agent nodes
export K3D_AGENTS=3

# Memory per node
export K3D_MEMORY=4g

# K3s version
export K3S_VERSION=v1.31.5

k3d-local create
```

### Network Configuration

### Service Access

Access services via Traefik:

```bash
# HTTP
http://service-name.127.0.0.1.sslip.io:8080

# HTTPS (if enabled)
https://service-name.127.0.0.1.sslip.io:8443
```

### Port Mappings

| Service | Port | Protocol |
|---------|------|----------|
| Traefik HTTP | 8080 | HTTP |
| Traefik HTTPS | 8443 | HTTPS |
| kube-apiserver | 6443 | HTTPS (internal) |
| kubelet | 10250 | HTTPS (internal) |
| etcd | 2379-2380 | HTTPS (internal) |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Usage error (invalid flags/arguments) |
| 127 | Command not found |

## Tips

### Check Command Syntax

```bash
k3d-local <command> --help
```

### Verbose Debugging

```bash
k3d-local create --verbose
```

Detailed output helps troubleshoot issues.

### Dry Run (if supported)

```bash
k3d-local create --dry-run
```

Show what would be executed without making changes.

## See Also

- [Getting Started](../getting-started.md)
- [Usage Guide](../usage.md)
- [k3d Official Docs](https://k3d.io/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
