# k3d-local Examples & Recipes

This directory contains production-ready recipes and examples for extending your k3d-local cluster with additional tools and services.

## Available Recipes

### [ArgoCD](./argocd/)
Install and configure ArgoCD with proper TLS support for GitOps workflows.

**Features:**
- ✅ Works with both self-signed (local) and Let's Encrypt (production) certificates
- ✅ Traefik ingress integration
- ✅ One-command installation
- ✅ Kustomize-based for easy customization

**Quick Start:**
```bash
# 1. Install k3d-local (if you haven't already)
brew tap gautampachnanda101/tap
brew install k3d-local

# 2. Create cluster with Traefik (required!)
k3d-local create --with-traefik

# 3. Install ArgoCD
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap/examples/argocd
./install.sh
```

## Coming Soon

- **Vault** - Secrets management
- **Prometheus/Grafana** - Enhanced monitoring
- **Backstage** - Developer portal
- **Harbor** - Container registry
- **GitLab Runner** - CI/CD integration
- **Keycloak** - Identity and access management

## Recipe Structure

Each recipe follows this structure:

```
recipe-name/
├── README.md                    # Detailed setup guide
├── install.sh                   # One-command installation script
├── values-local.yaml           # Helm values for local development
├── values-prod.yaml            # Helm values for production
└── manifests/                  # Optional raw Kubernetes manifests
    └── *.yaml
```

## Contributing Recipes

Have a recipe you'd like to share? We welcome contributions!

1. Create a new directory under `examples/`
2. Follow the structure above
3. Include comprehensive documentation
4. Test with both local and production configurations
5. Submit a PR

## Requirements

All recipes assume you have:
- **k3d-local** installed and cluster created
- **kubectl** configured
- **helm** installed (for Helm-based recipes)
- **Traefik** enabled (`--with-traefik` flag)

## Support

For issues or questions:
- [Open an issue](https://github.com/gautampachnanda101/homebrew-tap/issues)
- [View k3d-local docs](https://github.com/gautampachnanda101/local-cluster-k3d)
