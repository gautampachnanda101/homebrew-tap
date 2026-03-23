# Kyverno Recipe for k3d-local

Kyverno starter recipe for policy-as-code and admission controls.

## Quick Start

```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/kyverno
./install.sh
```

## Notes

- Starter scaffold only; add ClusterPolicy resources for real enforcement.
- Production should tune policy exceptions and reporting.
