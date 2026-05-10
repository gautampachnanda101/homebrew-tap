# promptx

Local-first prompt intelligence CLI with encrypted memory, AI cost analytics, and cross-tool context handoff.

## Installation

### macOS and Linux (Homebrew)

```bash
brew tap gautampachnanda101/tap
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

### VS Code Extension

Install the bundled VS Code extension after installing Promptx:

**macOS/Linux:**

```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

**Windows:**

```powershell
code --install-extension "$env:USERPROFILE\scoop\apps\promptx\current\promptx-vscode-*.vsix"
```

Verify installation:

```bash
promptx --version
```

## First-Time Setup

```bash
promptx setup
```

This creates an encrypted vault, sets up your passkey, registers MCP globally, and configures background memory capture.

Verify:

```bash
promptx doctor
promptx machine verify
```

## Web UI

The fastest way to explore your AI interaction history is the browser dashboard:

```bash
promptx serve   # start the server
promptx ui      # open http://127.0.0.1:17171/ui/ in your browser
```

### Dashboard Tabs

**Insights** — analytics across your full history:

- Interaction count, estimated cost, average tokens, cache hits
- Model distribution chart — which models you use and in what proportion
- Assistant breakdown with per-assistant token and cost data
- Satisfaction and pivot tracking
- Daily/weekly activity chart
- Live model pricing fetched from OpenRouter (falls back to built-in table)
- Filter by assistant, model, or date range

**Timeline** — paginated interaction history with full-text search, filters by assistant/model/emotion/date, and per-row detail view.

**Memory** — search your encrypted memory store with fuzzy and semantic matching.

**Handoff** — build and copy a context pack to transfer your session to another tool:

- Scope to the current repo or all repos
- Set source tool, target tool, and row limit
- Copy the pack to paste into any AI assistant

**Graph** — visualise relationships between commits, interactions, and memory nodes.

**Debug** — raw view of daemon and internal tool interactions (memory-watch, promptx-watcher, etc.).

## Daily Workflows

### Auto-Memory Capture

```bash
# Start background capture for the current repo
promptx memory-watch --repo . --interval 5 --force-store

# Work normally — interactions are captured automatically

# Query what was captured
promptx memory-query "architecture decision" --repo . --limit 5
```

### Search Your History

```bash
# Full-text search
promptx search "connection timeout" --repo . --limit 10

# Fuzzy similarity search
promptx fuzzy-search "database" --repo . --limit 5

# Natural language question
promptx ask "what changed in mcp tools?" --repo . --limit 6
```

### Evidence-Based Execution

Get grounded answers backed by your interaction history:

```bash
promptx executor "what changed in mcp tools?" --repo . --limit 8 --min-score 0.25
```

### Cross-Tool Handoff

Transfer context between tools via CLI:

```bash
promptx switch    # snapshot current state and create handoff pack
promptx resume    # restore context in another tool
```

Or use the **Handoff tab** in the web UI for a guided flow with scope controls and copy buttons.

### Write a Decision to Memory

```bash
promptx memory-write "Decision: use hex over uuid for IDs" \
  --repo . \
  --type decision \
  --tags architecture,database \
  --force-store
```

### View Git Commits with Chat Context

```bash
promptx commits --repo . --limit 20 --pretty --group-by-assistant
```

## VS Code Extension

### Features

- **`@promptx` chat participant** in GitHub Copilot Chat
- **Promptx Insights sidebar** with memory and session graphs
- **Timeline view** — git commits annotated with AI chat activity
- **Memory panel** — recent memories with relative timestamps and tooltips
- **Commands**: Generate, Query, Resume/Handoff, Show Insights
- **Chat commands**: `/timeline`, `/record start`, `/record stop`
- **Status bar** showing active session state

### Chat Participant Usage

```text
@promptx What changed in the build system?
@promptx /timeline
@promptx /record start
```

### Timeline Activity Colours

| Colour | Meaning |
| ------ | ------- |
| 🟢 Green | High activity (5+ chats) |
| 🟡 Yellow | Medium activity (2–4 chats) |
| 🔵 Blue | Low activity (1 chat) |
| ⚪ White | No linked chats |

## MCP Integration

Run Promptx as an MCP server for any MCP-compatible tool:

```bash
promptx mcp          # JSON-RPC server over stdio
promptx mcp-guard    # auto-restart on failure
```

### Available MCP Tools

| Tool | Purpose |
| ---- | ------- |
| `promptx_memory_query` | Query encrypted memory |
| `promptx_memory_write` | Write new memories |
| `promptx_search` | Full-text search |
| `promptx_executor` | Evidence-based execution |
| `promptx_capabilities` | List supported features |

## Command Reference

| Command | Purpose |
| ------- | ------- |
| `setup` | Initialise vault and passkey |
| `serve` | Start localhost HTTP API + web UI |
| `ui` | Open web dashboard in browser |
| `memory-watch` | Auto-capture interactions continuously |
| `memory-query` | Search encrypted memories |
| `memory-write` | Add a memory item |
| `search` | Full-text search history |
| `fuzzy-search` | Semantic similarity search |
| `ask` | Natural-language question over history |
| `executor` | Evidence-based execution |
| `commits` | Show commits with chat history |
| `graph` | Visualise chat-memory relationships |
| `switch` | Snapshot state and create handoff pack |
| `resume` | Restore context from handoff pack |
| `mcp` | Run MCP-compatible server |
| `mcp-guard` | Keep MCP server running |
| `doctor` | Comprehensive health check |
| `machine verify` | Verify system configuration |
| `logs` | Show recent interactions |
| `info` | Show environment and status |

## Troubleshooting

### Command Not Found After Install

```bash
which promptx
brew --prefix
exec $SHELL
```

### VS Code Extension Not Installing

```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

### Health Check

```bash
promptx doctor
promptx machine verify
promptx info
```

## Resources

- 📦 **Releases**: [homebrew-tap/releases](https://github.com/gautampachnanda101/homebrew-tap/releases)
- 🐛 **Issues**: [homebrew-tap/issues](https://github.com/gautampachnanda101/homebrew-tap/issues)
