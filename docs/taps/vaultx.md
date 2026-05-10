# vaultx

Zero-trust secrets CLI — the convenience of `.env` files with encrypted vault-backed secrets, Touch ID unlock, and an embedded web UI.

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
vaultx --version
```

## First-Time Setup

```bash
vaultx init      # create and encrypt the vault
vaultx unlock    # unlock for this session (Touch ID or master password)
```

## Web UI

Start the local daemon and open the browser dashboard:

```bash
vaultx serve          # start daemon on http://127.0.0.1:7474/
open http://127.0.0.1:7474/
```

### Dashboard Tabs

**Secrets** — view, add, and manage your vault entries. Secrets are never written to disk in plain text; they exist only in process memory and are injected directly into applications.

**Audit Log** — security event log covering vault unlocks (success/failure), secret reads, writes, and deletions. Audit logs can be forwarded to syslog for compliance use cases.

Authentication to the web UI uses Touch ID on macOS. The daemon token is stored locally and scoped to the running process.

### Serve Options

```bash
vaultx serve --port 8080                                    # custom port
vaultx serve --syslog-network local                         # local syslog
vaultx serve --syslog-network tcp --syslog-address host:514 # remote syslog
```

## Daily Workflows

### Store and Retrieve Secrets

```bash
vaultx set myapp/db_password "s3cr3t"    # store a secret
vaultx get myapp/db_password             # retrieve a value
vaultx list                              # list all secrets (values masked)
vaultx list myapp/                       # list secrets under a prefix
vaultx delete myapp/db_password          # delete a secret
```

### Run Commands with Secrets Injected

Replace `.env` files with vault-backed injection:

```bash
vaultx run -- go run ./cmd/server
vaultx run --env staging.env -- ./server
vaultx run -- python manage.py runserver
```

Secrets from `vaultx.env` are resolved at runtime and injected into the process environment — nothing is written to disk.

### Docker Compose

```bash
vaultx docker compose -- up --build
```

Injects secrets into the Docker Compose environment without exposing them in `docker inspect` output.

### Unlock and Session Management

```bash
vaultx unlock     # unlock for this session (Touch ID or master password)
```

Security defaults:

- Rate limiting: 10 unlock attempts per minute
- Lockout: 5 failed attempts locks the vault for 30 minutes

## MFA (TOTP)

Add two-factor authentication to vault unlocking:

```bash
vaultx mfa enable    # generates TOTP secret + QR code + 10 recovery codes
vaultx unlock        # now prompts for TOTP code after master password
```

## Backup and Recovery

Split the backup encryption key using M-of-N Shamir shares:

```bash
# Split into 5 shares, requiring any 3 to restore
vaultx backup split --shares 5 --threshold 3

# Restore from shares
vaultx backup restore
```

Useful for team escrow, compliance requirements, and M-of-N governance.

## Command Reference

| Command | Purpose |
| ------- | ------- |
| `init` | Create and encrypt a new vault |
| `unlock` | Unlock vault for this session |
| `serve` | Start daemon with embedded web UI |
| `set <key> <value>` | Store a secret |
| `get <key>` | Retrieve a secret value |
| `list [prefix]` | List secrets (values masked) |
| `delete <key>` | Delete a secret |
| `run -- <cmd>` | Run command with secrets injected |
| `docker compose -- ...` | Docker Compose with secret injection |
| `mfa enable` | Enable TOTP two-factor authentication |
| `backup split` | Split backup key into M-of-N shares |
| `backup restore` | Restore from shares |
| `audit` | View security audit log |

## Troubleshooting

### Command Not Found After Install

```bash
which vaultx
brew --prefix
exec $SHELL
```

### Vault Locked After Failed Attempts

After 5 failed unlock attempts the vault locks for 30 minutes. Wait out the lockout or use a recovery code if MFA is enabled.

### Check Formula and Version

```bash
brew info vaultx
vaultx --version
```

### Reinstall if Binary Is Missing

```bash
brew reinstall vaultx
```

## Resources

- 📦 **Releases**: [homebrew-tap/releases](https://github.com/gautampachnanda101/homebrew-tap/releases)
- 🐛 **Issues**: [homebrew-tap/issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
