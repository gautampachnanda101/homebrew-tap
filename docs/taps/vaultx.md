# vaultx

Zero-trust secrets broker — commit `vaultx.env` (references only, never values), and vaultx injects the real secrets into your process at runtime. Nothing is written to disk in plain text.

## Installation

### macOS and Linux (Homebrew)

```bash
brew tap gautampachnanda101/tap
brew install vaultx
```

Upgrade:

```bash
brew upgrade vaultx
```

### Windows (Scoop)

```powershell
scoop bucket add promptx https://github.com/gautampachnanda101/scoop-bucket
scoop install vaultx
```

Verify:

```bash
vaultx version
```

## First-Time Setup

```bash
vaultx init --biometric   # create vault + enable Touch ID (macOS)
# or
vaultx init               # create vault with master password only
```

Run a health check:

```bash
vaultx doctor
```

## The vaultx.env File

`vaultx.env` is a reference file — it contains secret names, not values. It is safe to commit to git.

At runtime, `vaultx run` resolves each reference from the vault and injects the real value into the process environment. Nothing touches disk.

Example `vaultx.env`:

```env
DB_PASSWORD=vaultx://myapp/db_password
API_KEY=vaultx://myapp/api_key
```

## Web UI

```bash
vaultx serve          # start daemon on http://127.0.0.1:7474/
open http://127.0.0.1:7474/
```

### Dashboard Tabs

**Secrets** — view, add, and manage vault entries. Values are never stored in plain text.

**Audit Log** — security event log: unlocks (success/failure), secret reads, writes, deletions. Supports syslog forwarding for compliance.

Touch ID authenticates the web UI on macOS.

### Serve Options

```bash
vaultx serve --port 8080                                    # custom port
vaultx serve --syslog-network local                         # local syslog
vaultx serve --syslog-network tcp --syslog-address host:514 # remote syslog
```

## Daily Workflows

### Store and Retrieve Secrets

```bash
vaultx set myapp/db_password "s3cr3t"    # store
vaultx get myapp/db_password             # retrieve
vaultx list                              # list all (values masked)
vaultx list myapp/                       # list under a prefix
vaultx delete myapp/db_password          # delete
```

### Run Commands with Secrets Injected

From a directory containing a `vaultx.env` file:

```bash
vaultx run -- go run ./cmd/server
vaultx run -- python manage.py runserver
vaultx run -- npm start
```

### Inject into Current Shell

```bash
eval $(vaultx shell)    # exports secrets as env vars in the current shell
```

### Docker

```bash
vaultx docker compose -- up --build    # Docker Compose with secrets injected
```

### Session Management

```bash
vaultx unlock    # unlock for this session (Touch ID or master password)
vaultx lock      # lock the vault (clear cached key)
```

Security defaults:

- Rate limiting: 10 unlock attempts per minute
- Lockout: 5 failed attempts locks the vault for 30 minutes

## Providers

vaultx supports multiple secret providers configured in `~/.vaultx/config.toml`:

- **Local** — encrypted vault at `~/.vaultx/vault.enc` (default)
- **1Password** — pull secrets from 1Password vaults
- **HashiCorp Vault** — connect to a Vault server
- **AWS Secrets Manager** — pull from AWS

Check provider health:

```bash
vaultx providers
```

## MFA (TOTP)

```bash
vaultx mfa enable    # generates TOTP secret + QR code + 10 recovery codes
vaultx unlock        # now prompts for TOTP code after master password
```

## Backup and Recovery

```bash
# Split into 5 shares, requiring any 3 to restore (Shamir M-of-N)
vaultx backup split --shares 5 --threshold 3

# Restore from shares
vaultx backup restore
```

## Import and Export

```bash
vaultx import    # import credentials from an external password manager
vaultx export    # export credentials to a file
```

## Built-in Docs

```bash
vaultx docs    # pretty-print the public user guide shipped with the binary
```

## Shell Completion

```bash
vaultx completion    # install tab completion (zsh, bash, fish, PowerShell)
```

## Kubernetes Integration

```bash
vaultx k3d    # helpers for k3d / Kubernetes External Secrets integration
```

## Command Reference

| Command | Purpose |
| ------- | ------- |
| `init [--biometric]` | Create vault, optionally enable Touch ID |
| `unlock` | Unlock vault for this session |
| `lock` | Lock vault (clear cached key) |
| `doctor` | Health check — vault, runtime deps |
| `serve` | Start daemon with embedded web UI |
| `set <key> <value>` | Store a secret |
| `get <key>` | Retrieve a secret |
| `list [prefix]` | List secrets (values masked) |
| `delete <key>` | Delete a secret |
| `run -- <cmd>` | Run command with secrets injected |
| `shell` | Print export statements for current shell |
| `docker compose -- ...` | Docker Compose with secret injection |
| `mfa enable` | Enable TOTP two-factor authentication |
| `backup split` | Split backup key into M-of-N shares |
| `backup restore` | Restore from shares |
| `audit` | View security audit log |
| `providers` | List configured providers and health |
| `import` | Import from external password manager |
| `export` | Export credentials to file |
| `k3d` | k3d / Kubernetes External Secrets helpers |
| `docs` | View built-in user guide |
| `completion` | Install shell tab completion |
| `version` | Show version |

## Troubleshooting

### Command Not Found After Install

```bash
which vaultx
brew --prefix
exec $SHELL
```

### Vault Locked After Failed Attempts

After 5 failed unlock attempts the vault locks for 30 minutes. Wait out the lockout or use a recovery code if MFA is enabled.

### Health Check

```bash
vaultx doctor
vaultx providers
```

### Check Version

```bash
vaultx version
brew info vaultx
```

### Reinstall if Binary Is Missing

```bash
brew reinstall vaultx
```

## Resources

- **Releases**: [homebrew-tap/releases](https://github.com/gautampachnanda101/homebrew-tap/releases)
- **Issues**: [homebrew-tap/issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
