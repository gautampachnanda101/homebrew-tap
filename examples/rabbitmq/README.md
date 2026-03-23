# RabbitMQ Recipe for k3d-local

RabbitMQ starter recipe for local async messaging workflows.

## Quick Start

```bash
k3d-local create --with-traefik
cd homebrew-tap/examples/rabbitmq
./install.sh
```

## Notes

- Uses RabbitMQ management image for local testing.
- Production should add PVCs, user/permission bootstrap, and TLS.
