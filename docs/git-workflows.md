# Git Workflows Guide

Workflows and best practices for using k3d-local in development teams.

## Overview

This guide covers common Git workflows when developing with k3d-local in a local environment. Topics include:

- **Version control** for your Kubernetes manifests
- **Local configuration management**
- **Branching strategies** for multi-environment setups
- **CI/CD integration** with k3d-local
- **Team collaboration** patterns

## Organizing Your Code

### Recommended Directory Structure

```
my-project/
├── README.md
├── .gitignore
├── .github/
│   └── workflows/
│       ├── test.yml
│       └── deploy.yml
├── k8s/
│   ├── base/
│   │   ├── namespace.yaml
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── ingress.yaml
│   ├── overlays/
│   │   ├── development/
│   │   │   ├── kustomization.yaml
│   │   │   └── ingress-patch.yaml
│   │   ├── staging/
│   │   │   ├── kustomization.yaml
│   │   │   └── replicas-patch.yaml
│   │   └── production/
│   │       └── kustomization.yaml
│   └── helm/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       └── templates/
├── src/
│   └── application code
└── Makefile
```

### .gitignore for Kubernetes Projects

```gitignore
# Local development
*.local
.env
.env.local
kubeconfig

# Generated files
dist/
build/
*.tar.gz

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Kubernetes
.kube/
kubeconfig-*

# k3d
k3d-*.yaml
k3d-*.log

# Helm
charts/**/Chart.lock
```

## Version Control Best Practices

### 1. Commit Kubernetes Manifests

**DO:** Store manifests in version control

```bash
# Good - commit manifests
git add k8s/deployment.yaml
git add k8s/service.yaml
git commit -m "feat: add kubernetes deployment"
```

**DON'T:** Exclude manifests from version control

```bash
# Bad - never do this
*.yaml >> .gitignore  # Don't!
```

### 2. Use Meaningful Commit Messages

Follow conventional commits:

```
feat: add postgresql database deployment
fix: correct ingress routing rules
docs: update helm deployment guide
refactor: simplify deployment structure
test: add k8s manifest validation
chore: update dependencies
```

**Example commit:**
```bash
git commit -m "feat: add prometheus monitoring

- Deploy prometheus via helm
- Configure scrape intervals
- Add grafana datasource
- Closes #123"
```

### 3. Separate Concerns

Create separate commits for different concerns:

```bash
# Separate commits for clarity
git add k8s/database/
git commit -m "feat: add postgresql database"

git add k8s/api/
git commit -m "feat: add api deployment"

git add k8s/frontend/
git commit -m "feat: add frontend deployment"
```

## Branching Strategies

### Git Flow (Recommended for Teams)

```
main (production)
  ↑
  └─→ release/1.0.0
      ↑
      └─→ develop (staging/integration)
          ↑
          ├─→ feature/add-database
          ├─→ feature/update-api
          └─→ bugfix/fix-ingress-routing
```

**Workflow:**

```bash
# Create feature branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/add-database

# Work locally with k3d-local
make setup  # Creates local k3d cluster
kubectl apply -f k8s/database/

# Test your changes
kubectl get pods
kubectl logs deploy/postgres

# Commit and push
git add k8s/
git commit -m "feat: add postgresql deployment"
git push origin feature/add-database

# Create pull request
# ... review and merge to develop

# Later: Create release
git checkout develop
git checkout -b release/1.0.0
# ... bump versions, test

# Merge to main
git checkout main
git merge release/1.0.0
git tag v1.0.0
git push origin main --tags

# Merge back to develop
git checkout develop
git merge main
```

### GitHub Flow (Simpler, for Smaller Teams)

```
main (production)
  ↑
  └─→ feature/add-database
  └─→ bugfix/fix-routing
  └─→ docs/update-guide
```

**Workflow:**

```bash
# Create feature branch from main
git checkout main
git pull origin main
git checkout -b feature/add-database

# Test locally
make setup
kubectl apply -f k8s/database/

# Commit and push
git push origin feature/add-database

# Create pull request and merge
# Then deploy from main to production
```

## Local Development Workflow

### Setting Up for Development

```bash
# Clone repository
git clone https://github.com/organization/project.git
cd project

# Create local k3d cluster
k3d-local create --with-traefik --with-apps

# Point kubectl to cluster
kubectl config use-context k3d-k3d-local

# Install dependencies
make install

# Deploy base infrastructure
kubectl create namespace development
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install postgres bitnami/postgresql -n development
```

### Daily Development Cycle

```bash
# 1. Start a new feature
git checkout -b feature/new-feature

# 2. Make code changes
# ... edit files, create new components ...

# 3. Deploy to local k3d
kubectl apply -f k8s/

# 4. Test locally
kubectl get pods -n development
kubectl port-forward svc/myapp 3000:3000
curl http://localhost:3000

# 5. Iterate until working
# ... make more changes, deploy again ...

# 6. Commit changes
git add .
git commit -m "feat: add new feature"

# 7. Push and create PR
git push origin feature/new-feature
# Create pull request on GitHub/GitLab
```

### Testing Before Commit

```bash

# 1. Verify manifests
kubectl apply -f k8s/ --dry-run=client

# 2. Lint YAML
yamllint k8s/

# 3. Validate configurations
kubeval k8s/*.yaml

# 4. Run full test suite
make test

# 5. Only then commit
git commit -m "feat: add feature (tested)"
```

## Working with Helm Charts

### Helm Chart Git Setup

```bash
# Initialize a new Helm chart
helm create my-app

# Version control
git init my-app
git add .
git commit -m "initial: helm chart scaffold"

# Update values for different environments
# values-dev.yaml
# values-staging.yaml
# values-prod.yaml

git add values*.yaml
git commit -m "chore: add environment-specific values"

# Deploy and test locally
helm install my-app ./my-app -f values-dev.yaml
```

### Sharing Helm Charts

**Publish to Helm Repository:**

```bash
# Package chart
helm package my-app

# Upload to repository
# (depends on your Helm repo hosting)

# Tag in git
git tag helm-chart-v1.0.0
git push origin helm-chart-v1.0.0
```

## Multi-Environment Configuration

### Using Kustomize for Overlays

```bash
# Base configuration
cat > k8s/base/kustomization.yaml << 'EOF'
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- namespace.yaml
- deployment.yaml
- service.yaml
- ingress.yaml
EOF

# Development overlay
cat > k8s/overlays/development/kustomization.yaml << 'EOF'
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
- ../../base

patchesStrategicMerge:
- deployment-patch.yaml

namePrefix: dev-
EOF

# Deploy using overlay
kubectl apply -k k8s/overlays/development

# Version control
git add k8s/
git commit -m "feat: add kustomize overlays for multi-environment"
```

### Branch per Environment

```bash
# Development branch
git checkout develop
kubectl apply -k k8s/overlays/development

# Staging branch
git checkout staging
kubectl apply -k k8s/overlays/staging

# Main/Production branch
git checkout main
kubectl apply -k k8s/overlays/production
```

## Continuous Integration Locally

### Run CI/CD Locally

Validate changes before pushing:

```bash
# Create Makefile targets for validation
cat > Makefile << 'EOF'
.PHONY: lint test validate deploy

lint:
	yamllint k8s/
	helm lint ./my-app

test:
	kubeval k8s/base/*.yaml
	kubectl apply -f k8s/ --dry-run=client

validate:
	@echo "Running tests..."
	$(MAKE) lint
	$(MAKE) test

deploy:
	kubectl apply -f k8s/overlays/development
	kubectl rollout status deployment -n development

clean:
	kubectl delete -f k8s/overlays/development
EOF

# Run validation before commit
make validate

# Only commit if validation passes
git commit -m "feat: add new feature (validated)"
```

### GitHub Actions Integration

Test with `k3d-local` in CI:

```yaml
# .github/workflows/test.yml
name: Test

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Create k3d cluster
        run: |
          curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
          k3d cluster create test-cluster
          
      - name: Apply manifests
        run: kubectl apply -f k8s/
        
      - name: Verify deployment
        run: |
          kubectl wait --for=condition=available --timeout=300s deployment -l app=myapp
          
      - name: Run tests
        run: |
          kubectl port-forward svc/myapp 3000:3000 &
          sleep 5
          curl http://localhost:3000
```

## Collaboration Patterns

### Code Review Process

```bash
# Developer: Create feature branch and PR
git checkout -b feature/new-feature
# ... make commits ...
git push origin feature/new-feature

# On GitHub: Create Pull Request

# Reviewer: Test locally
git fetch origin feature/new-feature
git checkout origin/feature/new-feature
k3d-local delete  # Clean previous cluster
k3d-local create --with-traefik --with-apps

# Deploy and test
kubectl apply -f k8s/

# If issues, request changes
# If approved, merge
```

### Pair Programming with k3d-local

```bash
# Share screen and use same k3d cluster
# Both developers connect to same cluster:

# Dev 1
kubectl config get-contexts
kubectl config use-context k3d-k3d-local

# Dev 2
kubectl config get-contexts
kubectl config use-context k3d-k3d-local

# Create shared namespace and deploy
kubectl create namespace pair-session
kubectl apply -f k8s/ -n pair-session

# Track changes in git
git commit -m "feat: add feature (paired with @dev2)"
```

## Configuration Management

### Store Secrets Safely

**DON'T:**
```bash
# Never commit secrets!
git add secrets.yaml  # Don't!
```

**DO:**
```bash
# Use sealed-secrets or external-secrets operator
kubectl create secret generic myapp-secrets \
  --from-literal=password=secret \
  -n development

# Or use sealed-secrets CLI
# kubeseal -f secret.yaml -w sealed-secret.yaml
git add sealed-secret.yaml  # OK - encrypted

# Reference in manifests
env:
- name: PASSWORD
  valueFrom:
    secretKeyRef:
      name: myapp-secrets
      key: password
```

### .env Files for Local Development

```bash
# .env.local (not committed)
K3D_SERVERS=1
K3D_AGENTS=2
K3D_MEMORY=4g
DATABASE_PASSWORD=localdev
API_KEY=test-key-only

# Create gitignored files
echo ".env" >> .gitignore
echo ".env.local" >> .gitignore
echo "kubeconfig" >> .gitignore

git add .gitignore
git commit -m "chore: add .gitignore for local secrets"

# Use in shell
source .env.local
k3d-local create --with-traefik
```

## Troubleshooting Git + k3d-local

### Sync Cluster State with Git

```bash
# Apply latest from git
git pull origin main
kubectl apply -f k8s/

# Check for drift
kubectl diff -f k8s/

# Revert to git state
git checkout k8s/
kubectl apply -f k8s/
```

### Revert Changes

```bash
# Undo local k8s changes
kubectl rollout undo deployment/myapp -n development

# Revert git commits
git revert HEAD~1
git push origin develop

# Clean local development
k3d-local delete
k3d-local create --with-traefik --with-apps
```

## Best Practices Summary

✅ **DO:**
- Commit all Kubernetes manifests to git
- Use branching strategies (Git Flow or GitHub Flow)
- Test locally before pushing
- Write clear commit messages
- Use overlays for multi-environment configs
- Validate manifests in CI/CD
- Encrypt secrets before committing
- Tag releases in git

❌ **DON'T:**
- Commit `.env` files or secrets
- Use `kubectl apply` without version control
- Push directly to main branch
- Skip validation before commit
- Hardcode configuration in manifests
- Forget to update documentation
- Leave merged branches undeleted
- Ignore code review feedback

## Common Git Commands for k3d-local

```bash
# Feature branch workflow
git checkout -b feature/my-feature
kubectl apply -f k8s/
# ... test and iterate ...
git add .
git commit -m "feat: add feature"
git push origin feature/my-feature

# Sync with latest develop
git fetch origin develop
git rebase origin/develop

# Update local cluster with latest
git pull origin develop
kubectl apply -f k8s/
kubectl rollout restart deployment/myapp

# Cherry-pick a commit
git cherry-pick <commit-hash>

# View changes before commit
git diff k8s/
git add k8s/
git diff --cached k8s/
```

## Resources

- [Git Official Handbook](https://git-scm.com/book/en/v2)
- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)
- [Git Flow Cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)
- [Helm Best Practices](https://helm.sh/docs/chart_best_practices/)

## Next Steps

- Review [Customization Guide](customization.md) for extending cluster
- Deep-dive into [Helm Deployment](helm-deployment.md)
- Check [Commands Reference](reference/commands.md)
