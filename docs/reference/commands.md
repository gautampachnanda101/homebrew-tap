# Command Reference

Complete reference for all CLI tools in this tap: `k3d-local`, `promptx`, and `vaultx`.

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
- `--http-port` (default: `80`)
- `--https-port` (default: `443`)
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

---

## Promptx

Local-first prompt intelligence CLI with encrypted memory and web UI.

### Core Commands

| Command | Description |
| ------- | ----------- |
| `promptx setup` | Initialize encrypted vault and MCP registration |
| `promptx doctor` | Health check — vault, memory backend, MCP, config |
| `promptx machine verify` | Verify machine identity |
| `promptx info` | Show version and configuration |

### Memory

| Command | Description |
| ------- | ----------- |
| `promptx memory-watch --repo . --interval 5` | Continuously capture interactions |
| `promptx memory-write "<text>" --repo .` | Write a memory entry directly |
| `promptx search "<query>" --repo .` | Full-text search |
| `promptx fuzzy-search "<query>" --repo .` | Semantic fuzzy search |
| `promptx ask "<question>" --repo .` | Natural language question |
| `promptx executor "<query>" --repo .` | Evidence-based execution |
| `promptx logs --limit 50` | View recent decrypted logs |

### Web UI

| Command | Description |
| ------- | ----------- |
| `promptx serve` | Start web server at `http://127.0.0.1:17171/` |
| `promptx ui` | Open web UI in browser |

### Context and Handoff

| Command | Description |
| ------- | ----------- |
| `promptx switch` | Create a handoff context pack |
| `promptx resume` | Resume from a handoff pack |
| `promptx context-pack --repo .` | Export context as markdown |
| `promptx commits --repo .` | View git commits linked to AI interactions |
| `promptx graph --repo .` | Visualize chat-code relationships |

### MCP Server

| Command | Description |
| ------- | ----------- |
| `promptx mcp` | Start MCP server |
| `promptx mcp-guard` | Start MCP server with auto-restart |
| `promptx mcp status` | Show MCP server status |

### Generation

| Command | Description |
| ------- | ----------- |
| `promptx generate "<prompt>"` | Generate a prompt using local AI |

---

## Vaultx

Zero-trust encrypted secrets CLI.

### Vault Commands

| Command | Description |
| ------- | ----------- |
| `vaultx init` | Create and encrypt a new vault |
| `vaultx unlock` | Unlock vault for this session |
| `vaultx --version` | Show version |

### Secrets Commands

| Command | Description |
| ------- | ----------- |
| `vaultx set <key> <value>` | Store a secret |
| `vaultx get <key>` | Retrieve a secret |
| `vaultx list [prefix]` | List secrets (values masked) |
| `vaultx delete <key>` | Delete a secret |

### Injection Commands

| Command | Description |
| ------- | ----------- |
| `vaultx run -- <cmd>` | Run command with secrets injected |
| `vaultx docker compose -- ...` | Docker Compose with secret injection |

### Dashboard

| Command | Description |
| ------- | ----------- |
| `vaultx serve [--port N]` | Start daemon with embedded web UI |

### Security Commands

| Command | Description |
| ------- | ----------- |
| `vaultx mfa enable` | Enable TOTP two-factor authentication |
| `vaultx backup split --shares N --threshold M` | M-of-N Shamir key split |
| `vaultx backup restore` | Restore vault from shares |
| `vaultx audit` | View security audit log |

---

## See Also

- [Getting Started](../getting-started.md)
- [Usage Guide](../usage.md)
- [Promptx Tap Guide](../taps/promptx.md)
- [Vaultx Tap Guide](../taps/vaultx.md)
- [k3d Official Docs](https://k3d.io/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
