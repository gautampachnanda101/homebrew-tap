# Usage Guide

Common workflows and usage patterns for k3d-local.

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
