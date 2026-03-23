# Customization Guide

Extend and customize k3d-local for your specific development needs.

## Overview

k3d-local is built for extensibility. You can customize almost every aspect:

- **Cluster configuration** - nodes, resources, networking
- **Pre-installed components** - enable/disable Traefik, cert-manager, telemetry
- **Custom applications** - deploy your own apps via kubectl or Helm
- **Domain names** - use custom domains instead of sslip.io
- **Networking** - configure ingress, DNS, TLS
- **Storage** - persistent volumes and storage classes

## Basic Customization: Environment Variables

### Control Cluster Size

```bash
export K3D_SERVERS=3      # Number of server nodes (default: 1)
export K3D_AGENTS=4       # Number of agent nodes (default: 2)
export K3D_MEMORY=6g      # Memory per node (default: varies)

k3d-local create
```

### Control Installed Components

```bash
# Enable all components
k3d-local create \
  --with-traefik \
  --with-apps \
  --with-telemetry

# Enable only what you need
k3d-local create --with-traefik  # Just ingress, no apps/telemetry
```

### Custom Domain Names

By default, services use sslip.io. Configure a custom domain:

```bash
# Use a custom domain (requires DNS configuration or /etc/hosts)
k3d-local create --domain mycompany.local
```

Then access services at:
```
http://app.mycompany.local:8080
http://dashboard.mycompany.local:8080
```

!!! note
    Configure DNS or add entries to `/etc/hosts`:
    ```
    127.0.0.1  app.mycompany.local
    127.0.0.1  dashboard.mycompany.local
    ```

## Customization: Kubernetes Manifests

### Deploy Custom Applications

Create a `deployment.yaml` for your application:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: development
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app
        image: nginx:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "64Mi"
            cpu: "100m"
          limits:
            memory: "128Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: my-app
  namespace: development
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
  namespace: development
spec:
  rules:
  - host: my-app.127.0.0.1.sslip.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
```

Deploy your application:

```bash
# Create namespace
kubectl create namespace development

# Apply manifest
kubectl apply -f deployment.yaml

# Verify
kubectl get pods -n development
kubectl get ingress -n development

# Access
curl http://my-app.127.0.0.1.sslip.io:8080
```

### Apply Manifests from URL

Deploy directly from GitHub:

```bash
kubectl apply -f https://raw.githubusercontent.com/yourorg/yourrepo/main/k8s/deployment.yaml
```

## Customization: Helm Charts

See [Helm Deployment Guide](helm-deployment.md) for complete instructions.

### Quick Example: Deploy PostgreSQL

```bash
# Add Bitnami repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Create namespace
kubectl create namespace databases

# Deploy PostgreSQL
helm install pgdb bitnami/postgresql \
  -n databases \
  --set auth.postgresPassword=dev \
  --set primary.persistence.size=10Gi
```

Access from your application:
```bash
kubectl port-forward -n databases svc/pgdb-postgresql 5432:5432
# Connect: postgresql://postgres:dev@localhost:5432/postgres
```

## Customization: Storage

### Use Local Storage

By default, k3d-local uses local storage. View storage classes:

```bash
kubectl get storageclass
```

Create a persistent volume claim:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-data-pvc
  namespace: development
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: local-path
  resources:
    requests:
      storage: 10Gi
```

Use in deployment:

```yaml
spec:
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: my-data-pvc
  containers:
  - name: app
    volumeMounts:
    - name: data
      mountPath: /data
```

### Mount Host Volumes

Mount a directory from your host machine into containers:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  volumes:
  - name: source-code
    hostPath:
      path: /Users/yourname/projects/myapp
      type: Directory
  containers:
  - name: app
    volumeMounts:
    - name: source-code
      mountPath: /app
```

Perfect for development - changes on host are immediately reflected in container.

## Customization: Networking

### Expose Services Without Ingress

Use port-forward for services not exposed via Traefik:

```bash
# Forward local port to service
kubectl port-forward -n namespaces svc/service-name 3000:3000

# Access locally
curl http://localhost:3000
```

### Configure Custom Ingress Routes

Create a custom ingress route:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: custom-route
  namespace: development
spec:
  rules:
  - host: api.127.0.0.1.sslip.io
    http:
      paths:
      - path: /v1
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 8080
      - path: /v2
        pathType: Prefix
        backend:
          service:
            name: api-v2-service
            port:
              number: 8080
```

## Customization: Environment Configuration

### Set kubectl Context Alias

```bash
# Create alias for faster kubectl access
alias k=kubectl
alias kgp='kubectl get pods'
alias kdesc='kubectl describe'
alias klogs='kubectl logs'

# Add to ~/.bashrc or ~/.zshrc for permanent alias
echo "alias k=kubectl" >> ~/.zshrc
```

### Configure kubectl Auto-Complete

```bash
# Bash
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl

# Zsh
kubectl completion zsh | sudo tee /usr/share/zsh/site-functions/_kubectl
```

### Set Default Namespace

Avoid typing `-n namespace` repeatedly:

```bash
# Set default namespace
kubectl config set-context $(kubectl config current-context) --namespace=development

# Verify
kubectl config view | grep namespace

# Switch back to default
kubectl config set-context $(kubectl config current-context) --namespace=default
```

## Customization: Resource Limits

### Configure Per-Namespace Resource Quotas

Prevent resource exhaustion:

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: dev-quota
  namespace: development
spec:
  hard:
    requests.cpu: "2"
    requests.memory: "2Gi"
    limits.cpu: "4"
    limits.memory: "4Gi"
    pods: "20"
```

Apply:
```bash
kubectl apply -f resourcequota.yaml
```

### Set Default Resource Requests/Limits

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: dev-limits
  namespace: development
spec:
  limits:
  - max:
      cpu: "2"
      memory: "2Gi"
    min:
      cpu: "100m"
      memory: "128Mi"
    default:
      cpu: "500m"
      memory: "512Mi"
    defaultRequest:
      cpu: "250m"
      memory: "256Mi"
    type: Container
```

## Customization: Development Workflow

### Hot-Reload Development Setup

Mount source code and auto-reload:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-app
  namespace: development
spec:
  replicas: 1
  selector:
    matchLabels:
      app: dev-app
  template:
    metadata:
      labels:
        app: dev-app
    spec:
      containers:
      - name: app
        image: node:18-alpine
        command: ["npm", "run", "dev"]
        ports:
        - containerPort: 3000
        volumeMounts:
        - name: source
          mountPath: /app
      volumes:
      - name: source
        hostPath:
          path: /Users/you/projects/myapp
          type: Directory
```

Now changes to local code automatically reload in container.

### Multi-Environment Testing

Use separate namespaces:

```bash
# Development environment
kubectl create namespace dev
# ... deploy dev apps ...

# Staging environment
kubectl create namespace staging
# ... deploy staging apps ...

# Switch between them
kubectl config set-context $(kubectl config current-context) --namespace=dev
kubectl config set-context $(kubectl config current-context) --namespace=staging
```

## Customization: Monitoring & Debugging

### Enable Resource Monitoring

View real-time resource usage:

```bash
# Node resources
kubectl top nodes

# Pod resources (requires metrics-server, often pre-installed)
kubectl top pods --all-namespaces

# Watch for changes
watch 'kubectl top pods --all-namespaces'
```

### Access Logs

```bash
# View current logs
kubectl logs deploy/my-app -n development

# Follow logs in real-time
kubectl logs -f deploy/my-app -n development

# View logs from previous crash
kubectl logs deploy/my-app --previous -n development

# View logs from all pods in deployment
kubectl logs -l app=my-app --all-containers=true -n development
```

### Interactive Debugging

```bash
# Execute commands in running pod
kubectl exec -it pod/my-app-xyz -- /bin/sh

# Debug new pod from an image
kubectl debug -it --image=busybox node/my-app-xyz

# Port-forward for debugging
kubectl port-forward pod/my-app-xyz 8080:8080
```

## Best Practices

### 1. Use Namespaces Organically

```bash
# Organize by tier
kubectl create namespace frontend
kubectl create namespace backend
kubectl create namespace databases

# Or by environment
kubectl create namespace dev
kubectl create namespace test
kubectl create namespace staging
```

### 2. Label Everything

```yaml
metadata:
  labels:
    app: my-app
    version: v1.0
    environment: development
    team: backend
```

Then query easily:
```bash
kubectl get pods -l app=my-app
kubectl get pods -l environment=development
kubectl get pods -l team=backend
```

### 3. Use ConfigMaps for Configuration

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: development
data:
  DATABASE_HOST: postgres.databases
  DATABASE_PORT: "5432"
  LOG_LEVEL: "debug"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  template:
    spec:
      containers:
      - name: app
        envFrom:
        - configMapRef:
            name: app-config
```

### 4. Use Secrets for Sensitive Data

```bash
# Create secret
kubectl create secret generic db-credentials \
  -n development \
  --from-literal=username=dev \
  --from-literal=password=secretpassword

# Reference in deployment
env:
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: db-credentials
      key: username
```

## Recipes

### Recipe: Node.js Development

```bash
# Create namespace
kubectl create namespace nodejs-dev

# Create ConfigMap for code
kubectl create configmap app-source \
  --from-file=./src \
  -n nodejs-dev

# Deploy with hot-reload
cat > node-app.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: node-app
  namespace: nodejs-dev
spec:
  replicas: 1
  selector:
    matchLabels:
      app: node-app
  template:
    metadata:
      labels:
        app: node-app
    spec:
      containers:
      - name: app
        image: node:18-alpine
        command: ["npm", "run", "dev"]
        ports:
        - containerPort: 3000
        resources:
          limits:
            memory: "256Mi"
            cpu: "500m"
EOF

kubectl apply -f node-app.yaml
kubectl port-forward -n nodejs-dev svc/node-app 3000:3000
```

### Recipe: Database + API Backend

```bash
# Databases namespace
helm install postgres bitnami/postgresql \
  -n databases \
  --create-namespace

# Backend namespace
kubectl create namespace backend
kubectl apply -f api-deployment.yaml -n backend

# Frontend namespace
kubectl create namespace frontend
kubectl apply -f web-deployment.yaml -n frontend

# Verify
kubectl get pods --all-namespaces
```

## Troubleshooting Customizations

### Changes Not Applied

```bash
# Verify manifest is correct
kubectl apply -f manifest.yaml --dry-run=client

# Check for errors
kubectl describe pod <pod-name>
```

### Resource Limits Hit

```bash
# Check quotas
kubectl describe resourcequota -n development

# Adjust or delete
kubectl edit resourcequota dev-quota -n development
```

### Networking Issues

```bash
# Test DNS
kubectl run -it --rm debug --image=busybox -- nslookup postgres.databases

# Check service endpoints
kubectl get endpoints -n databases

# Test connectivity
kubectl run -it --rm debug --image=busybox -- wget -O- http://postgres:5432
```

## Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Deployment Guide](helm-deployment.md)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Git Workflows](git-workflows.md)

## Next Steps

- Deep-dive into [Helm Deployment](helm-deployment.md)
- Explore [Git Workflows Guide](git-workflows.md) for team collaboration
- Check [Commands Reference](reference/commands.md) for k3d-local CLI
