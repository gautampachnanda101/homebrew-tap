# 🚀 Promptx User Guide

> A local-first CLI for prompt optimization, encrypted memory, assistant handoff, and MCP-powered IDE workflows.

This guide is the production user guide shipped with Promptx releases.

## ✨ Why Promptx

Promptx helps you keep AI engineering work fast, auditable, and local.

- 🔐 Encrypted local memory with biometric-gated, passkey-derived protection (Secure Enclave on macOS)
- 🔎 Fast retrieval across prompts, responses, and repo history
- 🔁 Cross-assistant handoff between Copilot, Claude Code, Cursor, Kiro, and more
- 🧠 Unified surfaces: CLI, bridge, MCP, and VS Code extension

## 📦 Install

### macOS and Linux (Homebrew)

```bash
brew tap gautampachnanda101/homebrew-tap
brew update
brew install promptx
```

Upgrade:

```bash
brew upgrade promptx
```

### Windows (Scoop)

```powershell
scoop bucket add promptx https://github.com/gautampachnanda101/scoop-bucket
scoop install promptx
```

Upgrade:

```powershell
scoop update promptx
```

### Verify install

```bash
promptx --version
promptx help
```

## ⚡ 90-Second Quick Start

Initialize → Configure IDEs + Skills → Validate → Generate → Query

```bash
promptx setup --biometric   # Initialize vault — biometric-gated keychain (recommended)
promptx setup ide           # Auto-discover IDEs, assistants, and bootstrap skills
promptx doctor              # Validate environment
promptx generate "Design a staged rollback strategy for API migrations"
promptx memory-query "rollback strategy" --repo . --limit 5
```

> **macOS**: `--biometric` stores the passkey in the Secure Enclave-backed keychain, gated by Touch ID / Face ID. This is the recommended setup. Omit the flag on Linux or Windows.

## 🧠 Command Overview

| Command | What it does |
| --- | --- |
| promptx generate | Generates/refines prompts from local context |
| promptx ask | Answers questions from encrypted local memory |
| promptx fuzzy-search | Finds semantically similar past interactions |
| promptx memory-query | Retrieves stored memory entries by query |
| promptx memory-write | Stores explicit memory notes/decisions |
| promptx insights | Shows usage, tokens, models, and spend estimates |
| promptx commits | Correlates commit history with assistant activity |
| promptx resume | Builds cross-assistant handoff context |
| promptx code-index | Indexes repo source files for code-aware context |
| promptx context-pack | Renders memory + code context for any AI tool |
| promptx mcp | Starts Promptx MCP server for tool clients |
| promptx assistants | Shows assistant support parity matrix |
| promptx serve | Runs the local API + web UI server |
| promptx ui | Opens the web UI in your browser |

## 📁 Core Commands

### promptx setup

Run initial machine setup and MCP registration.

```bash
promptx setup
```

What setup does:

- initializes local Promptx runtime wiring
- prepares MCP/global integration surfaces
- enables memory capture defaults for active workflows

### promptx setup ide

Configure Promptx for all installed IDEs and bootstrap machine-level skills.

```bash
promptx setup ide
```

What `setup ide` does:

- Auto-detects installed IDEs (VS Code, Cursor, Windsurf, Kiro, Zed, JetBrains family)
- Identifies available chat assistants (Copilot, Claude Code, Continue, Aider, Kiro, etc.)
- Configures MCP for each IDE so Promptx tools are discoverable
- Bootstraps machine-level skills: `token-saving`, `handoff-style`, `code-review`, `architecture`
- Validates the setup and guides next steps

After `setup ide`, skills are available globally at `~/.promptx/skills/`:

```bash
# Use a bootstrapped skill
promptx ask "what changed in architecture?" --skills architecture --repo . --limit 5

# View a skill
cat ~/.promptx/skills/token-saving.md

# Create a custom skill
promptx skill init my-custom-skill --global
```

### Context packs (skills / plugins)

A context pack is one Markdown file injected into every prompt. Its
`kind: convention | workflow` frontmatter decides placement — conventions become
guardrails, workflows become reusable steps. `promptx plugin` is a permanent
alias for `promptx skill` that defaults new packs to `convention`.

```bash
promptx skill search review                       # browse the shared registry
promptx skill install code-review-checklist       # from the registry by name
promptx skill install myorg/rules@v2 --kind convention   # any GitHub repo, pinned
promptx skill enable code-review-checklist        # apply to every generate/ask, no flags
promptx skill list                                # * marks enabled
promptx skill update --all                        # re-fetch tracked packs
promptx skill remove code-review-checklist
```

- Provenance (source, ref, sha256, kind) is recorded in `~/.promptx/skills.lock.json`.
- Private packs: set `GH_TOKEN` / `GITHUB_TOKEN`.
- Custom catalog: set `PROMPTX_REGISTRY_URL`.
- `--all-assistants [--dry-run]` installs into `.claude/skills`, `.github/skills`, … in the current repo.

### Staying up to date

```bash
promptx update            # brew/scoop delegate; a plain binary self-replaces after SHA-256 verification
promptx update --check    # report only
```

The CLI prints a one-line "update available" nudge after commands; disable it
with `PROMPTX_NO_UPDATE_CHECK=1`.

### promptx generate

Generate a refined prompt from your task.

```bash
promptx generate "draft a migration plan for event processing"
```

### promptx ask

Ask memory-aware questions over local encrypted history.

```bash
promptx ask "what changed in mcp tools recently?" --repo . --limit 6
```

### promptx insights

Inspect recent interactions, token usage, and cost estimates.

When you pass filters (for example `--assistant claude-code`), Promptx automatically scans a wider recent window first, then applies filters, so high-volume assistants do not crowd out matching rows.

```bash
promptx insights --limit 100
promptx insights --verbose --assistant claude-code
promptx insights --since 2026-04-01T00:00:00Z --until 2026-04-24T23:59:59Z --assistant claude-code
```

### promptx commits

Inspect commit-plus-chat history.

```bash
promptx commits --repo . --limit 20 --pretty --group-by-assistant
promptx commits --repo . --request "show chats-only history and export markdown report"
```

### promptx code-index

Index your repository's source files into a local FTS5 code store. Run this once (or after significant changes) to enable code-aware context injection.

```bash
promptx code-index --repo .
promptx code-index --repo . --max-file-size 256   # allow larger files
```

Supports: Go (via `go/ast`), TypeScript, JavaScript, Python, Ruby, Rust.
Skips: `node_modules`, `vendor`, `.git`, `dist`, `build`, and hidden directories.

### promptx context-pack (with code)

After indexing, inject relevant code chunks alongside memory context:

```bash
# Memory only (existing behavior — unchanged)
promptx context-pack --repo . --query "auth flow" --format markdown

# Memory + BM25-ranked code chunks
promptx context-pack --repo . --query "auth flow" --include-code --code-limit 5

# Write a .cursorrules file with both sources
promptx context-pack --repo . --format cursorrules --include-code --output .cursorrules
```

Code chunks are ranked by BM25 (SQLite FTS5) — no embeddings, no latency on LLM calls.

### @promptx /code (VS Code)

Search indexed code directly from the VS Code chat panel:

```text
@promptx /code auth middleware
@promptx /code FuzzySearch implementation
```

Returns the top-ranked function/type declarations with source, ready to paste into any prompt or ask follow-up questions against.

## ⚙️ Frequently Used Flags

| Flag | Meaning |
| --- | --- |
| --repo . | Scope command to the current repository |
| --limit N | Control result window size |
| --skills NAME | Apply skill packs for generation/analysis |
| --json | Return machine-readable output |
| --verbose | Include richer diagnostic details |

## 📚 Workflow Recipes

### 1) Incident Handoff Pack

```bash
promptx memory-query "payment timeout root cause" --repo . --limit 10
promptx commits --repo . --request "show chats-only history and export markdown report"
promptx resume --from github-copilot --to claude-code --repo . --limit 20
```

Use this when ownership shifts between engineers or assistants.

### 2) Architecture Decision Trail

```bash
promptx memory-write "Decision: keep partitioned indexes for query latency" --repo . --type decision --tags architecture,perf
promptx ask "what changed in indexing strategy?" --repo . --limit 6
```

Use this to keep ADR-style context searchable.

### 3) Release Readiness Snapshot

```bash
promptx insights --limit 100
promptx graph --repo . --window 200 --json
promptx executor "summarize risk clusters before release" --repo . --limit 8 --min-score 0.25
```

Use this before RC/release tagging for a fast confidence signal.

## 🌐 Web UI

Promptx ships a browser-based dashboard embedded directly in the binary — no separate install or server needed.

### Start the UI

```bash
promptx serve &   # starts the local API server on 127.0.0.1:17171
promptx ui        # opens http://127.0.0.1:17171/ui/ in your browser
```

`promptx serve` must be running (it usually is — see [Run as a persistent background service](#run-as-a-persistent-background-service)).

### Authenticate

The UI is protected by your vault passkey. Enter it in the lock screen on first open. The session lasts 8 hours — no repeated prompts during normal use.

### Tabs

| Tab | What it shows |
| --- | --- |
| **graph** | Interactive knowledge graph built from `graphify-out/graph.json`. Explore communities, god nodes, and surprising connections. Use the query bar to do BFS neighbourhood searches ("how does auth flow work?"). Switch repos with the pill picker at the top of the stats panel. |
| **insights** | Token usage over 30 days, tool/model distribution, satisfaction signal, daily activity charts. |
| **timeline** | Full interaction history grouped by day with item count. Click any row to open a detail drawer showing the complete prompt, response, satisfaction score, emotion, pivot/achievement flags, token split, tools used, and latency. |
| **memory** | Encrypted memory entries with full-text search, type filter (decision/architecture/bug/context/note), and tag filter. Click a card to read full content, tags, citations, and metadata. |

### Knowledge graph — scanning a new repo

The graph tab visualizes your codebase as a network of nodes (symbols, files, concepts) and edges (dependencies, calls, references). To add a repo:

#### Step 1 — generate the graph

Open the repo in Claude Code and run the `/graphify` skill:

```
/graphify
```

This analyzes the codebase and writes `graphify-out/graph.json` in the repo root. It also creates `graphify-out/communities.json` and `graphify-out/surprises.json` for the insight panels.

#### Step 2 — register the repo with Promptx

If you have not already tracked this repo, add it to the memory-watch spec:

```bash
promptx memory-watch --repo /path/to/your-repo
```

This registers the repo so the graph tab can discover it. You only need to do this once per repo. The graph tab reads `graphify-out/graph.json` directly from the registered path — there is no separate indexing step.

#### Step 3 — explore in the UI

Open `http://127.0.0.1:17171/ui/` and switch to the **graph** tab. Select the repo from the picker. The panel on the right shows:

- **Nodes / Edges / Communities** — structural overview
- **God Nodes** — highly-connected symbols worth refactoring or documenting
- **Top communities** — logical clusters the analyzer discovered
- **Surprising connections** — unexpected edges that cross community boundaries

Use the query bar to do a BFS neighbor search (e.g. `"how does auth flow work?"`) — it returns the subgraph centered on the most relevant node.

#### Keeping it current

Re-run `/graphify` in Claude Code whenever the codebase changes significantly, then reload the graph tab. There is no automatic re-indexing — it is a point-in-time snapshot.

The repo picker automatically lists every repo in your `memory-watch` spec that has been indexed. Repos with no graph data are shown in the picker but the graph tab will display an empty state with instructions.

### Chats without commits

Interactions are always stored regardless of git state. If a repo has no commits or is not a git repository, the git fields (branch, head commit) are left empty — the interaction is captured in full.

## 🧩 VS Code Extension

The recommended install is the CLI, which drops the bundled VSIX into every
detected editor:

```bash
promptx extension install
```

Detects VS Code, Cursor, VSCodium, Code Insiders, Windsurf, and Kiro. Re-run it
(or `promptx update`) after each `brew upgrade` / `scoop update` so the extension
version tracks the CLI.

### Registry

Promptx publishes to the **Open VSX Registry** only:
<https://open-vsx.org/extension/gautampachnanda101/promptx-chat-participant>

VSCodium, Windsurf, and Cursor use Open VSX by default, so you can also install
from their Extensions view or:

```bash
codium --install-extension gautampachnanda101.promptx-chat-participant
```

### Install the bundled VSIX directly

`promptx extension install --path <file>` (or the raw editor command) if you need
to pin a specific file:

```bash
# macOS / Linux
VSIX="$(brew --prefix)/share/promptx/promptx-vscode-*.vsix"
for editor in code cursor codium code-insiders windsurf; do
  command -v "$editor" >/dev/null 2>&1 && "$editor" --install-extension "$VSIX" --force
done

# Windows
code --install-extension "$env:USERPROFILE\scoop\apps\promptx\current\promptx-vscode-*.vsix"
```

### Sidebar surfaces

- Memory: recent interactions, tokens, and detail panels
- Insights: assistant/model/tool usage summaries
- Timeline: commit history with linked chat activity
- Multi-repo workspaces: `Promptx: Show Insights`, `Promptx: Show Timeline`, `@promptx /insights`, and `@promptx /timeline` prompt for repository selection and persist that selection per view.

### Extension settings

- `promptx.timelineChatLookback` (default: `2000`, range: `50-10000`) controls how many recent chat interactions are scanned when linking chats to commits in Timeline views.

### Chat participant (`@promptx`)

Use `@promptx` in GitHub Copilot Chat or any VS Code chat surface for quick commands:

**Slash commands:**
- `@promptx /log` — Log a chat turn from any model (prompt, response, tokens)
- `@promptx /timeline` — Show the Timeline view
- `@promptx /record start/stop` — Control memory capture daemon

**Example:**

```
@promptx /log
→ Select assistant (Copilot, Claude Code, etc.)
→ Specify model (gpt-4, claude-sonnet, etc.)
→ Paste prompt + response
→ Enter token counts (optional)
✓ Logged to encrypted memory
```

Or with arguments: `@promptx /log github-copilot gpt-4`

**Machine-level skills**: After `promptx setup ide`, skills are available to all chat participants via MCP. Try:

```
@promptx /ask "what changed in architecture?" --skills architecture --limit 5
```

For editor-specific setup, see docs/vscode-integration.md.

## 🔀 Cross-Tool Handoff (`resume` & `switch`)

Handoff lets you carry your encrypted session context from one AI assistant to another — mid-task, mid-conversation, or when the baton passes between engineers.

### How it works

When you call `resume` or `switch`, promptx:

1. Queries your recent encrypted interactions for the repo
2. Serialises them into a **PROMPTX RESUME PACK** — a portable, plaintext-safe context block
3. Stores the pack encrypted under a session ID you can share or retrieve later
4. You paste or inject the pack into the target assistant as part of the opening prompt

The receiving assistant reads the pack and picks up with full task history — models changed, decisions made, errors hit.

### `resume` — build a handoff pack

Use this when you want to **prepare** a context pack before switching tools:

```bash
promptx resume \
  --from github-copilot \
  --to   claude-code \
  --repo . \
  --limit 20
```

Output includes the `session_id` and the formatted context pack. Copy the pack into the target assistant's first message.

Retrieve the same pack again later (e.g. after restarting the terminal):

```bash
promptx resume --session <session_id>
```

### `switch` — log + handoff in one command

Use this at the end of a work session when you want to **atomically record the final turn and hand off**:

```bash
promptx switch \
  --from  claude-code \
  --to    github-copilot \
  --repo  . \
  --prompt   "Refactored auth middleware to use passkey store" \
  --response "Done. Tests pass. PR ready." \
  --model    claude-sonnet-4-6 \
  --limit    20
```

`switch` logs the interaction first, then calls `resume` — so the context pack always includes the turn you just completed.

### When to use which

| Situation | Command |
| --- | --- |
| Switching assistants mid-session | `resume` |
| End of session — want the last turn included | `switch` |
| Retrieving an earlier context pack by ID | `resume --session <id>` |
| Handing off between engineers | `resume` → share `session_id` → teammate runs `resume --session <id>` |

### In the VS Code extension

Open the **Promptx sidebar** → **Handoff** panel. The multi-step picker walks you through selecting the source and target assistant. The extension calls the bridge `resume` action and displays the formatted context pack inline.

You can also trigger it from the chat participant:

```
@promptx /handoff --from cursor --to claude-code
```

### In MCP tools

Three MCP tools are registered for handoff:

| Tool | Description |
| --- | --- |
| `resume` | Build a cross-tool resume pack for the current repo |
| `resume_get` | Retrieve a previously built pack by session ID |
| `switch` | Log the last turn and build the pack atomically |

**MCP `resume` call (example):**

```json
{
  "name": "resume",
  "arguments": {
    "repo_path": "/path/to/repo",
    "from_tool": "github-copilot",
    "to_tool": "claude-code",
    "limit": 20
  }
}
```

All three tools require a valid passkey. The response always includes `session_id`, `from_tool`, `to_tool`, `repo_path`, and `context_pack`.

### What the context pack contains

```
── PROMPTX RESUME PACK ──────────────────────────────────
Session:  abc123def456
Repo:     /Users/you/myrepo
From:     github-copilot  →  To: claude-code
Captured: 2026-05-06T20:00:00Z  (last 20 interactions)

[turn 1 — github-copilot]
Prompt: Refactor auth middleware to use passkey store
Response: Done — see internal/auth/middleware.go

[turn 2 — github-copilot]
...
─────────────────────────────────────────────────────────
```

Paste this block at the start of your first message to the target assistant.

## 🔁 Continuous Memory (memory-watch)

`memory-watch` is the background loop that captures file changes, git events, and AI chat turns from Claude Code, Cursor, Copilot, Continue, Windsurf, and Aider into encrypted memory automatically.

Decision-like external turns (for example architecture decisions and root-cause notes) are also auto-promoted into durable memory so they can be retrieved later with `promptx memory-query`.

### Start the watcher

```bash
promptx memory-watch --repo .
```

This starts a detached daemon. Check status or stop it:

```bash
promptx memory-watch --status
promptx memory-watch --stop
```

### What gets captured

By default all sources are enabled. Disable selectively with:

| Flag | Source |
| --- | --- |
| --watch-claude-code | Claude Code (and opencode) JSONL sessions under ~/.claude/projects/ |
| --watch-kiro | Kiro session transcripts under ~/.kiro/sessions/ |
| --watch-continue | Continue history under ~/.continue/history/ |
| --watch-cursor | Cursor chat from workspaceStorage SQLite |
| --watch-windsurf | Windsurf chat from workspaceStorage SQLite |
| --watch-copilot | GitHub Copilot Chat from VS Code workspaceStorage |
| --watch-aider | Aider turns from .aider.chat.history.md |
| --watch-chats | Native promptx chat turns for the repo |
| --watch-git | Git branch/HEAD/worktree transitions |

### Backfill Top Tools data

If old interactions were logged without `tools_used`, replay external assistant sources once:

```bash
promptx backfill-tools --repo .
```

Target specific sources:

```bash
promptx backfill-tools --watch-copilot --watch-claude-code
```

Then regenerate insights:

```bash
promptx insights --limit 200 --verbose
```

### Run as a persistent background service

The one-off daemon (`memory-watch`) exits on reboot. To survive restarts, install a platform service.

Run `promptx setup` first — the service reads the passkey from the OS keychain at startup (macOS Keychain via Touch ID or standard entry, GNOME/libsecret on Linux, PowerShell SecureString on Windows). The passkey is never stored in the service unit file.

#### macOS (launchd)

```bash
promptx setup --biometric   # stores passkey in Secure Enclave keychain (recommended)
promptx service install --repo .
promptx service start
```

Writes a LaunchAgent plist to `~/Library/LaunchAgents/io.promptx.memory-watch.plist` and auto-starts on login.

#### Linux (systemd)

```bash
promptx setup
promptx service install --repo .
promptx service start
```

Installs a systemd user unit at `~/.config/systemd/user/promptx-memory-watch.service`.

#### Windows (sc.exe)

```powershell
promptx setup
promptx service install --repo .
promptx service start
```

Manage the service on any platform:

```bash
promptx service status
promptx service stop
promptx service uninstall
```

## 🔌 MCP and Bridge

Start MCP server:

```bash
promptx mcp
```

Initialize global IDE/MCP wiring:

```bash
promptx global init
promptx global validate-vscode
```

Bridge example:

```bash
echo '{"action":"assistant_support"}' | promptx bridge
```

MCP example:

```json
{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"assistant_support","arguments":{}}}
```

For complete MCP tool coverage and no-passkey operations, see docs/mcp-global.md.

## ✂️ Token Compression

Promptx can intercept Claude Code's Bash tool output and replace it with a compressed version before Claude sees it — achieving 60–90% token reduction on verbose commands without losing the signal (test failures, diff heads/tails, error lines).

### Compression mechanics

When `promptx serve` is running and Claude Code hooks are installed, the `PostToolUse` hook fires after every Bash call. If the output exceeds 2 KB, Promptx compresses it and returns `decision: "block"` so Claude receives only the compressed output. Claude never sees the original verbose content.

### Enable compression — all assistants

```bash
promptx serve &                              # start the local hook server (Claude Code only)
promptx hooks install --tool all --repo .    # Claude Code hooks + Cursor + Windsurf rules
```

Or per assistant:

```bash
promptx hooks install --tool claude          # PostToolUse hooks → ~/.claude/settings.json
promptx hooks install --tool cursor  --repo . # .cursor/rules/promptx-context-economy.mdc
promptx hooks install --tool windsurf --repo . # .windsurf/rules/promptx-context-economy.md
```

Use `--force` to overwrite existing rule files.

### Built-in rules

| Rule | Trigger | Behaviour |
| --- | --- | --- |
| go-test | `go test` | Extract PASS/FAIL/ERROR/PANIC lines only |
| go-build | `go build` | Cap at 50 lines |
| git-diff | `git diff` | Head + tail with middle omitted |
| git-log | `git log` | Cap at 20 lines |
| npm-test | `npm/yarn/pnpm test` | Extract test result lines |
| make | `make` | Cap at 60 lines |
| read-file | Read tool ≥ 1 KB | Head 80 + tail 20 lines |
| grep-cap | Grep tool ≥ 500 B | Cap at 40 matches |
| glob-cap | Glob tool ≥ 500 B | Cap at 60 paths |
| ls-cap | LS tool ≥ 500 B | Cap at 50 lines |
| MCP tool | any `mcp__*` ≥ 500 B | Cap at 80 lines |

### Project-level rules

Create `.promptx/filters.toml` in your repo to override or extend:

```toml
[[rules]]
match_command = "cargo test"
max_lines = 30
summarize = true
label = "cargo-test"

[[rules]]
match_command = "docker build"
max_bytes = 8192
label = "docker-build"
```

### Test compression locally

```bash
promptx filter -- go test ./... -v
promptx filter -- git diff HEAD~1
```

### Find your most expensive commands

```bash
promptx discover --repo . --limit 15
```

Shows the top token-consuming sessions and whether a built-in rule already covers them.

### Compression for Glob, LS, and MCP tools

`promptx hooks install --tool claude` also installs PostToolUse hooks for **Glob** (capped at 100 paths), **LS** (capped at 80 lines), and **MCP tools** (capped at 120 lines). These fire automatically alongside the Bash hook.

## 🔭 Context Economy (copilot-optimize)

Chat agents that run inside the editor (rather than through a terminal hook) cannot be intercepted at the tool-output level. `copilot-optimize` handles those by front-loading economy instructions into a workspace instructions file the agent reads on every request.

```bash
promptx copilot-optimize --repo .
promptx copilot-optimize --repo . --large-file-kb 100 --dry-run
```

**What it generates:**

| File | Purpose |
| --- | --- |
| `.github/copilot-instructions.md` | Workspace instructions: read minimum context, prefer line ranges, skip lock files, cap terminal output |
| `.github/copilot-context-exclusions.json` | Noise globs + large-file list; paste into VS Code → Settings → Content Exclusions |

**Flags:**

| Flag | Default | Description |
| --- | --- | --- |
| `--repo` | `.` | Repository root to analyse |
| `--large-file-kb` | `50` | Flag files larger than this many KB |
| `--dry-run` | false | Print output without writing files |
| `--force` | false | Overwrite existing files |

Re-run with `--force` after major repo changes to refresh the large-file list.

## 🔑 Token Saving Skill

Use the **token-saving skill** to systematically capture and track AI interaction tokens across all Promptx surfaces.

### View the skill

```bash
promptx docs user-guide
```

### Log tokens from any model

```bash
# CLI method
promptx log --prompt-tokens 500 --completion-tokens 1200 --assistant github-copilot --model gpt-4

# VS Code Chat method
@promptx /log github-copilot gpt-4-turbo

# MCP method (programmatic)
{"jsonrpc":"2.0","method":"tools/call","params":{"name":"log_interaction","arguments":{"prompt_tokens":500,"completion_tokens":1200}}}
```

### Create and use the skill in your repo

```bash
promptx skill init token-saving --global
promptx ask "summarize token costs by model" --skills token-saving --repo . --limit 5
```

### Query token usage

```bash
promptx insights --verbose --assistant github-copilot
promptx memory-query "high token count" --repo . --limit 10
```

See the Token Compression section in `promptx docs user-guide` for comprehensive workflows and integration examples.

## 🧪 Alpha/RC Features

The following are Alpha/RC and may evolve before GA:

- assistant support parity matrix across CLI, bridge, and MCP
- Insights Assistant Support section with per-assistant surface and auto-capture status

Stability note:

- schema fields and UI placement may evolve across RC builds

## 🤖 Assistant-Specific Setup

### Kiro

Kiro is an AI coding assistant that supports the Model Context Protocol (MCP). Promptx integrates with Kiro via the `promptx` binary running as an MCP server.

#### MCP Configuration

Create `.kiro/mcp.json` in your project root:

```json
{
  "mcpServers": {
    "promptx": {
      "command": "promptx",
      "args": ["mcp"],
      "env": {
        "PROMPTX_PASSKEY": "${PROMPTX_PASSKEY}"
      }
    }
  }
}
```

This registers the `promptx` binary as an MCP server, making all Promptx tools available in Kiro.

Alternatively, register Promptx globally for all Kiro sessions:

```bash
promptx global init
```

#### Recording Kiro Sessions

Start recording from within Kiro using the MCP tool:

```text
call MCP tool: record_start
```

Stop recording:

```text
call MCP tool: record_stop
```

Or use the CLI:

```bash
promptx memory-watch --repo . --assistant kiro
promptx memory-watch --stop
```

#### Viewing Kiro Sessions

```bash
promptx logs --assistant kiro --verbose
promptx insights --assistant kiro --verbose
```

#### Cross-Tool Handoff

Switch context from another assistant to Kiro:

```bash
promptx resume --from github-copilot --to kiro --repo . --limit 20
promptx switch --from claude-code --to kiro --repo . --prompt "..." --response "..." --model auto
```

Switch from Kiro to another assistant:

```bash
promptx resume --from kiro --to claude-code --repo . --limit 20
```

For detailed Kiro integration documentation, see `docs/kiro-integration.md`.

### Claude Code

For Claude Code integration with PostToolUse hooks and JSONL session watching, see `docs/claudecode-integration.md`.

### VS Code / Cursor / Windsurf

For VS Code-compatible editors, install the Promptx extension:

```bash
promptx extension install
```

See the VS Code Extension section above for details.

## 🛡 Security Model

**Recommended (macOS):** `promptx setup --biometric` — passkey stored in the Secure Enclave-backed keychain, unlocked by Touch ID / Face ID. No process can read it without biometric confirmation.

- AES-256-GCM encrypted local storage with passkey-derived keys
- Biometric-gated keychain on macOS (Secure Enclave); OS keychain on Linux and Windows
- Localhost-scoped bridge and service endpoints
- No default cloud sync for interaction memory
- Command-driven, auditable workflows

## 🛠 Troubleshooting

### Core diagnostics

```bash
promptx doctor
promptx info
promptx insights --verbose
promptx logs --verbose
```

### Common fixes

No recent memory in Insights:

```bash
promptx memory-watch --status
promptx memory-watch --repo . --watch-chats --watch-git --force-store
```

MCP tools unavailable in editor:

```bash
promptx global init
promptx global validate-vscode
promptx mcp
```

Passkey prompts keep appearing:

```bash
promptx setup          # re-stores passkey in OS keychain (Touch ID or standard entry)
promptx doctor
```

## 📋 Escalation Checklist

When reporting an issue, include:

- promptx --version
- promptx info
- promptx doctor
- promptx logs --limit 200
- OS + editor version
