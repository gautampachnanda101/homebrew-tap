# Backstage Recipe for k3d-local

Developer portal starter recipe using Kustomize overlays.

## Quick Start

```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/backstage
./install.sh
```

## Notes

- This is a starter deployment scaffold for local experimentation.
- Production deployments should add persistent storage, ingress, auth, and external database.
