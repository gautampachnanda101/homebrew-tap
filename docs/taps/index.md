# Tap Catalog

This page lists public tap guides for currently visible formulas in this repository.

## Included Taps

- [k3d-local](k3d-local.md)
- [promptx](promptx.md)
- [vaultx](vaultx.md)

`ai-guardrails` is intentionally excluded for now.

## Common Install Flow

Use this shared pattern for all taps:

```bash
brew tap gautampachnanda101/tap
brew install <formula-name>
```

## Verify Installed Taps

```bash
brew search gautampachnanda101/tap/
brew list | grep -E "k3d-local|promptx|vaultx"
```

## Common Troubleshooting

### Formula not found

```bash
brew untap gautampachnanda101/tap
brew tap gautampachnanda101/tap
brew update
```

### Binary not found after install

```bash
brew --prefix
which k3d-local || true
which promptx || true
which vaultx || true
exec $SHELL
```

### Check formula details

```bash
brew info k3d-local
brew info promptx
brew info vaultx
```
