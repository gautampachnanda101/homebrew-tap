# Usage Guide

Common workflows and usage patterns for k3d-local and Promptx.

## Understanding k3d-local + Examples

**k3d-local** creates a local Kubernetes cluster using k3d. Once your cluster is running, you can deploy additional tools and services into it using the [examples](examples.md).

**Workflow:**
1. Create cluster with k3d-local
2. Deploy examples into that cluster (using kubectl + Kustomize)
3. Manage the cluster and running services

All examples in this repository are designed to work seamlessly with k3d clusters created by k3d-local.

## k3d-local Workflows

## Basic Cluster Operations

### Create Cluster

```bash
# Minimal cluster (server + agents only)
k3d-local create

# With ingress controller
k3d-local create --with-traefik

# With sample applications
k3d-local create --with-apps

# Complete setup (recommended)
k3d-local create --with-traefik --with-apps
```

### Check Status

```bash
k3d-local status
```

Shows cluster node status, running containers, and port mappings.

### Delete Cluster

```bash
k3d-local delete
```

!!! warning
    This removes all cluster data. Ensure you've backed up any important data.

## Deploying Applications

### Using kubectl

Your kubectl is automatically configured to access the cluster:

```bash
# Deploy from YAML
kubectl apply -f deployment.yaml

# Check deployments
kubectl get deployments

# View pod logs
kubectl logs -f deployment/my-app

# Port forward (if not using ingress)
kubectl port-forward svc/my-app 3000:3000
```

### Using Ingress

If Traefik is installed, expose services via ingress:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
spec:
  rules:
  - host: myapp.127.0.0.1.sslip.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 8080
```

Apply and access at: `http://myapp.127.0.0.1.sslip.io:8080`

## Container Registry

### Using Local Registry

k3d-local includes a local registry for development:

```bash
# Tag and push image
docker tag my-image localhost:5000/my-image:latest
docker push localhost:5000/my-image:latest

# Use in deployment
kubectl set image deployment/my-app \
  my-app=localhost:5000/my-image:latest
```

### Using Docker Hub

Pull from public registries normally:

```yaml
containers:
- name: app
  image: ubuntu:latest  # Automatically pulled from Docker Hub
```

## Observability

### View Cluster Events

```bash
kubectl get events --all-namespaces

# Watch for new events
kubectl get events -A --watch
```

### Check Resource Usage

```bash
# Node resources
kubectl top nodes

# Pod resources
kubectl top pods --all-namespaces
```

### Access Traefik Dashboard

When using `--with-traefik`:

```
http://dashboard.127.0.0.1.sslip.io:8080/dashboard/
```

Shows:
- Active routes
- Middlewares
- Services
- Backend status

## Advanced Usage

### Custom Configuration

Create a cluster with custom settings:

```bash
# Create with custom node sizing and ports
k3d-local create --servers 2 --agents 3 --http-port 8081 --https-port 8444

# Add custom k3d arguments
k3d-local create -- --volume /host/path:/container/path@all
```

### Multiple Clusters

Create multiple isolated clusters:

```bash
k3d-local create --name dev
k3d-local create --name test

# Switch context (uses standard kubeconfig)
kubectl config use-context k3d-dev
kubectl config use-context k3d-test
```

### Debugging

Enable verbose output:

```bash
k3d-local create --verbose
```

Check k3d cluster details:

```bash
k3d cluster list
k3d node list
```

## Development Workflow

### Common Pattern: Test → Deploy → Verify

```bash
# 1. Build and push image
docker build -t localhost:5000/myapp:dev .
docker push localhost:5000/myapp:dev

# 2. Deploy
kubectl apply -f deployment.yaml

# 3. Check status
kubectl rollout status deployment/myapp

# 4. View logs
kubectl logs -f deployment/myapp

# 5. Test endpoint
curl http://myapp.127.0.0.1.sslip.io:8080
```

### Hot Reload for Development

Mount source code into running containers:

```yaml
volumes:
- name: src
  hostPath:
    path: /Users/you/project/src
    type: Directory
```

Changes to local files reflect in running containers.

## Telemetry & Monitoring

### Optional: Full Observability Stack

Deploy Grafana LGTM (Logs, Metrics, Traces):

```bash
k3d-local create --with-telemetry
```

Access monitoring stack:

| Service | URL |
|---------|-----|
| Grafana | http://grafana.127.0.0.1.sslip.io:8080 |
| Prometheus | http://prometheus.127.0.0.1.sslip.io:8080 |
| Loki | http://loki.127.0.0.1.sslip.io:8080 |
| Tempo | http://tempo.127.0.0.1.sslip.io:8080 |

Default credentials: `admin` / `admin`

### Monitoring Your Applications

Applications automatically send metrics/logs when telemetry stack is enabled.

See [k3d-local telemetry docs](https://github.com/gautampachnanda101/local-cluster-k3d/blob/main/docs/telemetry.md) for configuration.

## Networking

### DNS Resolution

All services use **sslip.io** for automatic DNS:

```bash
# These all resolve without additional configuration
curl http://app.127.0.0.1.sslip.io:8080
curl http://dashboard.127.0.0.1.sslip.io:8080
```

### Port Mapping

By default, Traefik uses port 8080. Access via:

- HTTP: `http://service.127.0.0.1.sslip.io:8080`
- HTTPS: `https://service.127.0.0.1.sslip.io:8443` (if enabled)

### Environment Variables

Configure behavior via environment variables:

```bash
# K3D_NODES - Number of agent nodes (default: 2)
export K3D_NODES=3

# K3D_MEMORY - Memory per node
export K3D_MEMORY=4g

k3d-local create
```

## Performance Tips

- **Limit resources** via Docker Desktop settings
- **Monitor disk usage** with `docker system df`
- **Use local registry** for faster image pulls
- **Clean up regularly** with `k3d-local clean`

## Next Steps

- Explore [Command Reference](reference/commands.md)
- Check [Troubleshooting Guide](troubleshooting.md)
- Visit [k3d-local repository](https://github.com/gautampachnanda101/local-cluster-k3d)

---

## Promptx Workflows

Promptx helps you capture, organize, and retrieve AI coding interactions with encrypted memory.

### Initial Setup

After installation:

```bash
# Initialize vault with passkey
promptx setup

# Start capturing interactions
promptx memory-watch --repo . --interval 5 --force-store

# Verify everything is working
promptx doctor
```

### Daily Memory Capture

**Continuously capture interactions:**

```bash
promptx memory-watch --repo . \
  --interval 5 \
  --watch-git \
  --watch-chats \
  --flush-interval 15 \
  --flush-batch 20 \
  --force-store
```

This watches for:
- Git commits
- IDE chat interactions
- Code changes

### Querying Your Memory

**Find information from past interactions:**

```bash
# Full-text search
promptx search "connection timeout" --repo . --limit 10

# Fuzzy search with semantic similarity
promptx fuzzy-search "database queries" --repo . --limit 5

# Natural language questions
promptx ask "what changed in authentication?" --repo . --limit 6
```

### Evidence-Based Execution

Get grounded answers backed by codebase context:

```bash
promptx executor "how do we handle errors?" --repo . --limit 8 --min-score 0.25
```

Options:
- `--limit` – Max history items to reference
- `--min-score` – Threshold (0-1) for confidence
- `--repo` – Repository path

### Generating Prompts

Use local AI to generate prompts:

```bash
promptx generate "build a rust CLI for file compression"
promptx generate "refactor auth module with MFA support"
```

### Recording Decisions

Write important decisions to memory:

```bash
promptx memory-write "Decision: migrate from UUID to Ulid for IDs" \
  --repo . \
  --type decision \
  --tags architecture,database \
  --force-store
```

### Git Integration

**View commits linked to AI interactions:**

```bash
promptx commits --repo . --limit 20 --pretty --group-by-assistant
```

**Visualize chat-code relationships:**

```bash
promptx graph --repo . --window 200 --json
```

### VS Code Integration

**Using in Copilot Chat:**

```
@promptx What changed in the build system?
@promptx /timeline
@promptx /record start   # Begin recording
@promptx /record stop    # Stop recording
```

**Commands available:**
- `Promptx: Show Timeline` – Git commits with chat annotations
- `Promptx: Query Memory` – Search encrypted history
- `Promptx: Show Insights` – Memory and session graphs
- `Promptx: Resume / Handoff` – Transfer context between tools

### Multi-Repository Setup

Monitor multiple projects:

```bash
# Watch repo-a
promptx memory-watch --repo ~/work/project-a --interval 5 --force-store

# Watch repo-b (parallel terminal)
promptx memory-watch --repo ~/work/project-b --interval 5 --force-store
```

Query across repos:

```bash
promptx memory-query "authentication patterns" --repo ~/work/project-a --limit 5
```

### Cross-Tool Handoff

Seamlessly transfer context between tools:

```bash
# Create a handoff pack
promptx switch

# Later, resume in another tool (Claude, vs Code, etc.)
promptx resume
```

### MCP Server Integration

Run Promptx as an MCP client for Claude, Cline, or custom tools:

```bash
# Start MCP server
promptx mcp

# In another terminal, use it with MCP-compatible tools
```

Keep MCP running with auto-restart:

```bash
promptx mcp-guard
```

### CI/CD Integration

Capture interactions in automated workflows:

```bash
# One-time capture
promptx memory-watch --repo . --once --ingest-existing --force-store

# Analyze build history
promptx executor "recent build failures" --repo . --min-score 0.5
```

### Learning from Outcomes

Analyze executor performance over time:

```bash
promptx benchmark-executor "what changed in api?" \
  --repo . \
  --limit 20 \
  --iterations 5
```

Shows P50/P95/P99 latencies and evidence quality.

### Viewing Recent Interactions

**Decrypt and view recent logs:**

```bash
promptx logs --limit 50

# Show a single turn interactively
promptx quicklog

# Wrap output from another tool
some-command | promptx wrap "description of what happened"
```

### Exporting Context

**Create a context pack for sharing:**

```bash
promptx context-pack --repo . --window 100 > my-context.md
```

Share the markdown with teammates or paste into chat.

### Troubleshooting

**Health checks:**

```bash
promptx doctor
promptx machine verify
promptx info
promptx mcp status
```

**Common issues:**

```bash
# Passkey problems
export PROMPTX_PASSKEY="your-secure-key"

# Storage location
export PROMPTX_HOME="/custom/path"

# Backend selection
export PROMPTX_MEMORY_BACKEND=sqlite-v2-token  # Default
export PROMPTX_MEMORY_BACKEND=vector-stub      # Vectors
```

## k3d-local + Promptx Together

Combine both tools for a complete development environment:

```bash
# Terminal 1: Create and manage cluster
k3d-local create --with-traefik --with-apps
k3d-local status

# Terminal 2: Capture development interactions
promptx memory-watch --repo . --interval 5 --force-store

# Terminal 3: Deploy and test your app
kubectl apply -f deployment.yaml
kubectl logs -f deployment/my-app

# Later, query your session
promptx executor "what errors occurred during deploy?" --repo . --limit 10
```

## Next Steps

- Read [Promptx Guide](promptx.md) for full reference
- Explore [k3d-local Reference](reference/commands.md)
- See [Examples](examples.md) for recipes
