# Helm Deployment Guide

Learn how to use Helm with k3d-local for deploying and customizing applications in your local cluster.

## Overview

k3d-local includes **Helm 3** pre-configured and ready to use. Helm is a package manager for Kubernetes that makes it easy to install, upgrade, and manage applications.

### Pre-installed Helm Charts

When you create a cluster with component flags, these Helm charts are automatically deployed:

| Chart | Namespace | Purpose | Customizable |
|-------|-----------|---------|--------------|
| **Traefik** | traefik | Ingress controller & load balancer | ✅ Yes |
| **Cert-Manager** | cert-manager | TLS certificate management | ✅ Yes |
| **Grafana** | grafana-stack | Metrics and logs visualization | ✅ Yes |
| **Loki** | grafana-stack | Log aggregation | ✅ Yes |
| **Prometheus** | grafana-stack | Metrics collection | ✅ Yes |
| **Mimir** | grafana-stack | Long-term metrics storage | ✅ Yes |
| **Tempo** | grafana-stack | Distributed tracing | ✅ Yes |

!!! info
    All charts are installed with production-ready defaults optimized for local development.

## Helm Basics

### Verify Helm Installation

```bash
helm version
```

**Expected output:**
```
version.BuildInfo{Version:"v3.12.0+k3s1", ...}
```

### List Installed Releases

```bash
# All namespaces
helm list --all-namespaces

# Specific namespace
helm list -n traefik
helm list -n grafana-stack
```

### View Release Status

```bash
helm status traefik -n traefik
helm status cert-manager -n cert-manager
```

### View Release Values

See what values were used to deploy a release:

```bash
# Full values used
helm get values traefik -n traefik

# All values including defaults
helm get values traefik -n traefik --all
```

## Customizing Pre-installed Charts

### Approach 1: Upgrade a Release (Recommended)

Modify a chart after creation:

```bash
# Create custom values file
cat > traefik-custom.yaml << EOF
dashboard:
  enabled: true
  ingressRoute:
    enabled: true
    entryPoint: websecure

ingressClass:
  enabled: true
  isDefaultClass: true

metrics:
  prometheus:
    enabled: true
EOF

# Upgrade the release
helm upgrade traefik traefik/traefik \
  -n traefik \
  -f traefik-custom.yaml
```

### Approach 2: Delete and Recreate

For more significant changes, delete and redeploy:

```bash
# Delete the release
helm uninstall traefik -n traefik

# Wait for deletion (resources cleanup takes a moment)
sleep 10

# Reinstall with custom values
helm install traefik traefik/traefik \
  -n traefik \
  -f traefik-custom.yaml
```

## Deploying Your Own Helm Charts

### From Helm Hub (Official Charts)

Add a chart repository and install:

```bash
# Add repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Search for charts
helm search repo bitnami | grep postgres

# Install PostgreSQL example
helm install my-postgres bitnami/postgresql \
  --namespace databases \
  --create-namespace \
  --set auth.postgresPassword=password123 \
  --set primary.persistence.size=10Gi
```

### From Private Repository

```bash
helm repo add myrepo https://charts.example.com
helm repo add myrepo https://charts.example.com --username user --password pass
helm repo update

helm install myapp myrepo/myapp \
  --namespace production \
  --create-namespace
```

### From Local Chart Directory

```bash
# Create a simple chart
helm create my-app

# Deploy
helm install my-app ./my-app \
  --namespace development \
  --create-namespace

# Upgrade after changes
helm upgrade my-app ./my-app \
  --namespace development
```

## Values Files & Overrides

### Understanding Values

Values files define configurable parameters. Create a `values.yaml`:

```yaml
# values.yaml
replicaCount: 2

image:
  repository: nginx
  tag: "1.21"

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: true
  hosts:
    - host: myapp.127.0.0.1.sslip.io
      paths:
        - path: /
          pathType: Prefix

resources:
  limits:
    cpu: 100m
    memory: 128Mi
```

### Deploy with Custom Values

Using a file:
```bash
helm install myapp mychart -f values.yaml
```

Overriding specific values from CLI:
```bash
helm install myapp mychart \
  --set replicaCount=3 \
  --set image.tag=1.22 \
  --set ingress.hosts[0].host=custom.127.0.0.1.sslip.io
```

Multiple values files (last one wins):
```bash
helm install myapp mychart \
  -f values.yaml \
  -f values-production.yaml
```

## Practical Example: Deploy PostgreSQL

### Step 1: Add Bitnami Repository

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

### Step 2: Create Custom Values

```bash
cat > postgres-values.yaml << EOF
auth:
  username: dev
  password: devpassword
  database: myapp_db

primary:
  persistence:
    size: 10Gi
    storageClassName: local-path

service:
  type: ClusterIP
  ports:
    postgresql: 5432

resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
EOF
```

### Step 3: Install

```bash
helm install postgres bitnami/postgresql \
  -n databases \
  --create-namespace \
  -f postgres-values.yaml
```

### Step 4: Access from Your Application

```bash
# Port forward for local testing
kubectl port-forward -n databases svc/postgres-postgresql 5432:5432

# In your app
DATABASE_URL=postgresql://dev:devpassword@localhost:5432/myapp_db
```

### Step 5: Verify

```bash
# Check pod status
kubectl get pods -n databases

# View logs
kubectl logs -n databases deploy/postgres -f

# Connect to database
kubectl exec -it -n databases pod/postgres-postgresql-0 -- \
  psql -U dev -d myapp_db
```

## Working with Multiple Environments

### Create Environment-Specific Values

```
charts/
├── values.yaml                # Base values
├── values-dev.yaml           # Development overrides
└── values-prod.yaml          # Production overrides
```

**values-dev.yaml:**
```yaml
replicaCount: 1
image:
  pullPolicy: Always
resources:
  limits:
    memory: 256Mi
```

**values-prod.yaml:**
```yaml
replicaCount: 3
image:
  pullPolicy: IfNotPresent
resources:
  limits:
    memory: 512Mi
```

### Deploy to Different Environments

```bash
# Development
helm install myapp ./charts -f charts/values.yaml -f charts/values-dev.yaml

# Production
helm install myapp ./charts -f charts/values.yaml -f charts/values-prod.yaml
```

## Managing Multiple Releases

### List All Releases Across Namespaces

```bash
helm list --all-namespaces
```

### Organizing Releases

Use meaningful release names and namespaces:

```bash
# Database tier
helm install postgres-prod bitnami/postgresql \
  -n databases-prod

# Application tier
helm install api-app ./charts \
  -n apps-prod

# Monitoring tier
helm install prometheus bitnami/prometheus \
  -n monitoring-prod
```

### Check Release History

```bash
# View revisions
helm history myapp -n myapp

# Rollback to previous revision
helm rollback myapp 1 -n myapp
```

## Troubleshooting Helm Deployments

### Chart Not Found

```bash
# Ensure repo is added
helm repo list

# Update repo cache
helm repo update

# Search for chart
helm search repo <chart-name>
```

### Values Not Applied

```bash
# View actual values used
helm get values release-name

# Dry run with values
helm install myapp --dry-run --debug \
  -f values.yaml myrepo/mychart
```

### Pod Stuck in Pending

```bash
# Describe pod for events
kubectl describe pod <pod-name>

# Check resource requests
helm get values <release> | grep resources
```

### Uninstall and Clean up

```bash
# Uninstall release
helm uninstall <release> -n <namespace>

# Delete namespace (caution: removes all resources)
kubectl delete namespace <namespace>
```

## Common Helm Patterns

### Conditional Installation

Install different charts based on conditions:

```bash
# Only install if telemetry is enabled
if [ "$WITH_TELEMETRY" = "true" ]; then
  helm install prometheus bitnami/prometheus \
    -n monitoring \
    --create-namespace
fi
```

### Secrets in Values

Store sensitive values in Kubernetes secrets:

```bash
# Create secret
kubectl create secret generic db-secret \
  --from-literal=password=supersecret \
  -n databases

# Reference in values
cat > values.yaml << EOF
externalSecrets:
  enabled: true
  secretName: db-secret
EOF
```

### Variable Substitution

Use environment variables in deployment:

```bash
export APP_VERSION=1.2.3
export DOMAIN=myapp.127.0.0.1.sslip.io

helm install myapp ./charts \
  --set image.tag=$APP_VERSION \
  --set ingress.hosts[0].host=$DOMAIN
```

## Resources

- [Helm Official Documentation](https://helm.sh/docs/)
- [Helm Chart Repository](https://artifacthub.io/)
- [Bitnami Helm Charts](https://github.com/bitnami/charts)
- [Traefik Helm Chart](https://github.com/traefik/traefik-helm-chart)

## Next Steps

- Explore [Customization Guide](customization.md) for extending the cluster
- Review [Commands Reference](reference/commands.md) for k3d-local CLI
- View [Git Workflows](git-workflows.md) for development patterns
