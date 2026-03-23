# SpiceDB Recipe for k3d-local

SpiceDB starter recipe for relationship-based authorization.

## Quick Start

```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/spicedb
./install.sh
```

## Notes

- Local overlay uses in-memory datastore and dev pre-shared key.
- Production should use persistent datastore and strong key management.
