# OpenFGA Recipe for k3d-local

OpenFGA starter recipe for fine-grained authorization models.

## Quick Start

```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/openfga
./install.sh
```

## Notes

- This is a starter deployment for local experimentation.
- Production should use persistent datastore, authn/authz, and ingress/TLS.
