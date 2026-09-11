# kb-genie

Local-first knowledge-base builder with pluggable embedding backends and a browser chat interface.

## First commands

```bash
brew tap gautampachnanda101/tap
brew install kb-genie
kb-genie help
kb-genie doctor
kb-genie start
```

The local chat UI is available at <http://localhost:3000> after `kb-genie start`.

## Installation

```bash
brew tap gautampachnanda101/tap
brew install kb-genie
```

Upgrade and verify:

```bash
brew upgrade kb-genie
kb-genie help
```

## Common workflow

```bash
kb-genie doctor
kb-genie start
open http://localhost:3000
```

Use `kb-genie <command> --help` for the options available in the installed version.

## Troubleshooting

```bash
kb-genie status
kb-genie logs
```

## Help

Use `kb-genie <command> --help` for the installed command set. Report tap packaging issues through the [public issue tracker](https://github.com/gautampachnanda101/homebrew-tap/issues).