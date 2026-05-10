# promptx Tap Guide

## Purpose

`promptx` is a local-first prompt intelligence CLI that supports encrypted memory workflows and cross-tool context handoff for AI coding assistants.

## Install

```bash
brew tap gautampachnanda101/tap
brew install promptx
```

Verify:

```bash
promptx version
```

## Basic Usage

```bash
# Initialize promptx
promptx setup

# Run health checks
promptx doctor

# Verify machine setup
promptx machine verify
```

## Troubleshooting

### Command not found after install

```bash
which promptx
brew --prefix
exec $SHELL
```

### VS Code extension not installed

The formula includes a VSIX package under Homebrew share paths.

```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

If `code` is unavailable, install the extension manually from the VSIX file in your editor.

### Setup issues

```bash
promptx doctor
promptx machine verify
```

Use these diagnostics first to identify local environment issues.
