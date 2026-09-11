# promptx

Local-first prompt intelligence for AI coding assistants. Captures your
assistant + git activity, stores it encrypted on your machine, and injects the
relevant slice back into any assistant's prompt.

## First commands

```bash
brew tap gautampachnanda101/tap
brew install promptx
promptx version
promptx setup
promptx memory-watch --repo . --interval 30
promptx doctor
```

## Install

```bash
brew install gautampachnanda101/tap/promptx
# without Homebrew:
curl -fsSL https://gautampachnanda101.github.io/homebrew-tap/install.sh | sh
# Windows:
scoop bucket add promptx https://github.com/gautampachnanda101/scoop-bucket
scoop install promptx
```

Update: `promptx update` (delegates to `brew upgrade` / `scoop update`, otherwise
self-replaces a plain binary after verifying its SHA-256). `promptx update
--check` reports only. The CLI prints a one-line "update available" nudge;
silence it with `PROMPTX_NO_UPDATE_CHECK=1`.

## First run

```bash
promptx setup                 # encrypted vault; passkey in the OS keychain; registers MCP for detected editors
promptx extension install     # bundled IDE extension into every detected editor (Open VSX)
promptx memory-watch --repo . # background capture
promptx doctor                # verify; also flags CLI vs extension version skew
```

## Context packs (skills / plugins)

One Markdown file injected into every prompt. `kind: convention | workflow`
frontmatter decides placement. `promptx plugin` is a permanent alias for
`promptx skill` that defaults new packs to `convention`.

```bash
promptx skill search review
promptx skill install code-review-checklist          # from the shared registry
promptx skill install myorg/rules@v2 --kind convention   # any GitHub repo, pinned
promptx skill enable code-review-checklist            # applied to every generate/ask, no flags
promptx skill list                                    # * marks enabled
promptx skill update --all
promptx generate "add retry logic to the HTTP client"
```

Private packs: set `GH_TOKEN` / `GITHUB_TOKEN`. Own catalog: set
`PROMPTX_REGISTRY_URL`. `--all-assistants [--dry-run]` installs `SKILL.md` into
`.claude/skills`, `.github/skills`, … in the current repo.

## Service

```bash
brew services start promptx   # promptx serve on http://localhost:17171, restarts on login/upgrade
promptx mcp                    # stdio MCP server (registered by `promptx setup`)
```

## Web UI

`promptx serve` also hosts a browser dashboard embedded in the binary. With the
service running:

```bash
promptx ui                     # opens http://127.0.0.1:17171/ui/
```

Unlock with your vault passkey (or Touch ID / Face ID after `promptx setup
--biometric`); the session lasts 8 hours. Tabs: **graph** (knowledge graph from
the project knowledge graph, with in-place build), **insights** (tokens, cost,
cache hits, model/tool/satisfaction breakdowns with live model pricing),
**timeline** (decrypted interaction history with a per-row detail drawer),
**memory** (encrypted entries with full-text, type and tag filters), **handoff**
(build or retrieve a cross-tool resume pack), and **debug** (background-daemon
interactions). All data stays on your machine. `promptx ui --help` lists the
tabs; the full walkthrough is in `promptx docs` → *Web UI*.

The nav-bar repo picker scopes the graph, timeline, insights and activity to one
repo ("⊙ All repos" clears it). The graph tab's **Enrich** button (needs an LLM
backend — `promptx llm status`) names every cluster, extracts concepts, and
explains surprising links; `promptx graph-index --semantic` (alias
`promptx graphify`) does the same from the CLI. `promptx graph-index`
auto-provisions its `uv`/`graphifyy` runtime.

## Environment

| Variable | Purpose |
|----------|---------|
| `PROMPTX_HOME` | root for vault, packs, caches (default `~/.promptx`) |
| `PROMPTX_PASSKEY` | non-interactive passkey (prefer the keychain; visible in `ps`) |
| `GH_TOKEN` / `GITHUB_TOKEN` | private pack fetch + GitHub API rate limits |
| `PROMPTX_REGISTRY_URL` | replace the default context-pack registry |
| `PROMPTX_LLM_ENDPOINT` | OpenAI-compatible endpoint (Ollama, LM Studio, …) |
| `PROMPTX_LLM_MODEL` | model id (see `promptx llm models`) |
| `PROMPTX_PASSKEY_COMMAND` | command whose stdout is the vault passkey (`op`, `bw`, `keepassxc-cli`, `pass`, …) |
| `PROMPTX_REPO_ROOTS` | extra dirs (`:`/`,`-sep) scanned for git repos in the web UI picker |
| `PROMPTX_NO_UPDATE_CHECK` | disable the passive update nudge |

Non-secret settings (`llm.endpoint`, `llm.model`, `listen`, `graph.autoinstall`,
`repo_roots`, storage dirs) can also live in `~/.promptx/config.yaml` —
`promptx config set/show/get`. Env vars override the file; the vault passkey and
API keys never go in it.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `passkey not resolved` on every command | `promptx setup` (keychain), or `PROMPTX_PASSKEY` for CI. `promptx doctor` shows the sources it tried. |
| Editor not detected by `promptx extension install` | put the editor CLI on `PATH` (`code`, `cursor`, `codium`, `windsurf`, `kiro`) or pass `--path <vsix>`. |
| Private pack returns "not found" | export `GH_TOKEN` / `GITHUB_TOKEN` with repo read scope. |
| Extension odd after `brew upgrade` | version skew — `promptx doctor` flags it; run `promptx extension install` or `promptx update`. |
| `promptx update` says "cannot write" | not a brew/scoop install and the binary dir isn't writable — reinstall via brew, or relocate the binary. |
| `brew services` won't start promptx | `promptx stop` (clears a stale pid), then `brew services restart promptx`. |

`promptx doctor` first. Full guide: `promptx docs`, or the User Guide on the tap
site at <https://gautampachnanda101.github.io/homebrew-tap/>.

## Issues

All source is private — file on the tap and pick **promptx** in the Tool
dropdown: <https://github.com/gautampachnanda101/homebrew-tap/issues/new/choose>.
Include `promptx version` and `promptx doctor` output.
