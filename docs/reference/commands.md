# Command Reference

Complete reference for the `k3d-local` CLI as verified against the installed Homebrew package.

## Top-Level Commands

- `create`: Create and set up a k3d cluster.
- `delete`: Delete the k3d cluster.
- `install`: Install optional components into an existing cluster.
- `k3d`: Pass-through mode for raw `k3d` commands.
- `start`: Start a stopped cluster.
- `status`: Show cluster status.
- `stop`: Stop a running cluster.
- `validate`: Validate cluster installation and HTTPS setup.
- `help`: Show help.

## Global Flags

- `-h, --help`: Show help.
- `-v, --verbose`: Enable verbose output.
- `--debug`: Enable debug output (includes verbose).
- `--version`: Print version information.

## create

Create a new k3d cluster with optional components.

Syntax:

```bash
k3d-local create [flags]
```

Key flags:

- `--name` (default: `local-dev`)
- `--servers` (default: `1`)
- `--agents` (default: `2`)
- `--api-port` (default: `6550`)
- `--http-port` (default: `8080`)
- `--https-port` (default: `8443`)
- `--timeout` (default: `600` seconds)
- `--with-traefik`
- `--with-apps`
- `--with-core`
- `--with-telemetry`
- `--auto-install`

Examples:

```bash
k3d-local create
k3d-local create --with-traefik --with-apps
k3d-local create --with-traefik --with-core --with-telemetry --with-apps
k3d-local create --auto-install
```

## install

Install components into an existing cluster.

Syntax:

```bash
k3d-local install [command]
```

Subcommands:

- `k3d-local install traefik`
- `k3d-local install apps`
- `k3d-local install core`
- `k3d-local install telemetry`

Optional flag:

- `--name` (default: `local-dev`)

## status

Show cluster status.

Syntax:

```bash
k3d-local status [flags]
```

Optional flag:

- `--name` (default: `local-dev`)

## start

Start a stopped cluster.

Syntax:

```bash
k3d-local start [flags]
```

Optional flag:

- `--name` (default: `local-dev`)

## stop

Stop a running cluster.

Syntax:

```bash
k3d-local stop [flags]
```

Optional flag:

- `--name` (default: `local-dev`)

## delete

Delete a cluster and its resources.

Syntax:

```bash
k3d-local delete [flags]
```

Optional flag:

- `--name` (default: `local-dev`)

## validate

Validate cluster readiness, certificates, and HTTPS wiring.

Syntax:

```bash
k3d-local validate [flags]
```

Optional flag:

- `--ci` (skip platform-specific keychain checks)

## Version and Help

Version:

```bash
k3d-local --version
```

Help:

```bash
k3d-local --help
k3d-local create --help
```

## See Also

- [Getting Started](../getting-started.md)
- [Usage Guide](../usage.md)
- [k3d Official Docs](https://k3d.io/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
