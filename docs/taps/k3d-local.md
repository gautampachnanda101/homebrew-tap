# k3d-local

Cross-platform CLI for creating and managing local Kubernetes development clusters with k3d, Traefik v3, and optional telemetry.

## Installation

### macOS and Linux (Homebrew)

```bash
brew tap gautampachnanda101/tap
brew install k3d-local
```

Upgrade:

```bash
brew upgrade k3d-local
```

### Windows (Scoop)

```powershell
scoop bucket add promptx https://github.com/gautampachnanda101/scoop-bucket
scoop install k3d-local
```

Verify:

```bash
k3d-local --version
```

## Prerequisites

- Docker or Docker Desktop running
- macOS 10.14+, Linux, or Windows 10+

Missing dependencies (k3d, kubectl, helm) can be auto-installed:

```bash
k3d-local create --auto-install
```

## Quick Start

```bash
# Minimal cluster
k3d-local create

# With ingress controller (recommended)
k3d-local create --with-traefik

# Full stack — Traefik + sample apps + core components + telemetry
k3d-local create --with-traefik --with-core --with-telemetry --with-apps
```

Check status:

```bash
k3d-local status
```

Open the Traefik dashboard at `http://traefik.localhost/dashboard/` after creating with `--with-traefik`.

## create

Create a new cluster with optional add-ons.

```bash
k3d-local create [flags]
```

### Cluster Flags

| Flag | Default | Description |
| ---- | ------- | ----------- |
| `--name` | `local-dev` | Cluster name |
| `--servers` | `1` | Number of server nodes |
| `--agents` | `2` | Number of agent nodes |
| `--api-port` | `6550` | Kubernetes API port |
| `--http-port` | `80` | HTTP ingress port |
| `--https-port` | `443` | HTTPS ingress port |
| `--timeout` | `600` | Timeout in seconds |
| `--auto-install` | — | Auto-install missing dependencies |

### Add-on Flags

| Flag | Description |
| ---- | ----------- |
| `--with-traefik` | Install Traefik v3 ingress controller |
| `--with-apps` | Deploy sample applications |
| `--with-core` | Install core platform components (PostgreSQL, ScyllaDB, NATS, Kafka, SeaweedFS) |
| `--with-telemetry` | Install Grafana LGTM telemetry stack |

### TLS Flags

| Flag | Default | Description |
| ---- | ------- | ----------- |
| `--domain` | `127.0.0.1.sslip.io` | Domain name for TLS certificates |
| `--enforce-https` | — | Redirect HTTP to HTTPS for all ingresses |
| `--enable-local-dns` | — | Configure local DNS resolution via `/etc/resolver` (macOS) |
| `--use-letsencrypt` | — | Use Let's Encrypt for TLS (requires public domain) |
| `--email` | `noreply@dev-uk.uk` | Email for Let's Encrypt notifications |

### Registry Flags

| Flag | Default | Description |
| ---- | ------- | ----------- |
| `--create-regcred` | — | Create imagePullSecrets to avoid Docker Hub rate limits |
| `--docker-registry` | Docker Hub | Registry URL |
| `--docker-username` | — | Registry username |
| `--docker-password` | — | Registry password or token |
| `--docker-email` | — | Registry email (optional) |

### Add-on Details

**`--with-traefik`** — Installs Traefik v3 as the ingress controller with self-signed TLS. Services become reachable at `*.localhost`.

**`--with-apps`** — Deploys a set of example applications to validate the cluster is working end-to-end.

**`--with-core`** — Installs core platform components: PostgreSQL, ScyllaDB, NATS, Kafka, SeaweedFS.

**`--with-telemetry`** — Installs the Grafana LGTM stack (Loki, Tempo, Mimir, Grafana) for full local observability.

### Examples

```bash
k3d-local create
k3d-local create --with-traefik --with-apps
k3d-local create --with-traefik --with-core --with-telemetry --with-apps
k3d-local create --auto-install

# Avoid Docker Hub rate limits
k3d-local create --with-traefik --create-regcred \
  --docker-username myuser --docker-password dckr_pat_abc123

# Let's Encrypt with custom domain
k3d-local create --with-traefik --use-letsencrypt \
  --domain example.com --email admin@example.com
```

## install

Install add-ons into an existing cluster:

```bash
k3d-local install traefik
k3d-local install apps
k3d-local install core
k3d-local install telemetry
```

Optional flag: `--name` (default: `local-dev`)

## Cluster Management

```bash
k3d-local status          # show cluster and node health
k3d-local stop            # stop a running cluster
k3d-local start           # restart a stopped cluster
k3d-local delete          # delete cluster and all resources
k3d-local validate        # check readiness, certs, HTTPS wiring
k3d-local list-ingress    # list all ingress routes and their URLs
k3d-local trust-ca        # trust cluster CA certificate in system keychain
```

All management commands accept `--name` to target a named cluster. `validate` also accepts `--ci` to skip keychain checks in CI environments.

## Raw k3d Pass-Through

```bash
k3d-local k3d cluster list
k3d-local k3d node list
```

## Multiple Clusters

```bash
k3d-local create --name dev
k3d-local create --name staging

k3d-local status --name dev
k3d-local delete --name staging
```

## Deploy Examples Into Your Cluster

After creating a cluster with `--with-traefik`, deploy any of the pre-built example services:

```bash
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd
./install.sh
```

Available examples: ArgoCD, Vault, Harbor, Authentik, Keycloak, GitLab Runner, Backstage, External Secrets Operator, RabbitMQ, Kyverno, SpiceDB, OpenFGA.

See [Examples & Recipes](../examples.md) for the full list.

## Troubleshooting

### Docker Not Running

```bash
open -a Docker    # macOS
```

Or start Docker Desktop manually.

### Port Conflicts

```bash
lsof -i :80
lsof -i :443
```

Stop the conflicting process or pass `--http-port` / `--https-port` to use different ports.

### Missing Dependencies

```bash
brew install k3d kubectl helm
# or re-run create with --auto-install
```

### Full Debug Output

```bash
k3d-local create --with-traefik --verbose 2>&1 | tee debug.log
```

### Complete Reset

```bash
k3d-local delete
docker system prune -f
k3d-local create --with-traefik
```

## Resources

- **Releases**: [homebrew-tap/releases](https://github.com/gautampachnanda101/homebrew-tap/releases)
- **Issues**: [homebrew-tap/issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
- **k3d docs**: [k3d.io](https://k3d.io/)
