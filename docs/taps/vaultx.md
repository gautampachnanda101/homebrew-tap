# vaultx Tap Guide

## Purpose

`vaultx` is a zero-trust secrets CLI designed to replace plain-text secret workflows with an encrypted vault-based approach.

## Install

```bash
brew tap gautampachnanda101/tap
brew install vaultx
```

Verify:

```bash
vaultx version
```

## Basic Usage

```bash
vaultx --help
```

Start from the command help and user guide installed by the formula for your version.

## Troubleshooting

### Command not found after install

```bash
which vaultx
brew --prefix
exec $SHELL
```

### Check current formula metadata

```bash
brew info vaultx
```

### Reinstall if binary is missing or corrupted

```bash
brew reinstall vaultx
```
