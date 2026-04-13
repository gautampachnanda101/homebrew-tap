# Promptx Guide

Local-first prompt intelligence CLI with encrypted memory and cross-tool context handoff.

## Overview

Promptx helps you capture, organize, and retrieve AI coding interactions across multiple tools (GitHub Copilot, Claude, VS Code, and more). All data is encrypted locally, never sent to external servers.

### What Promptx Does

- **Captures** AI interactions automatically linked to git commits
- **Stores** encrypted memories of chats, code changes, and decisions
- **Retrieves** context via fuzzy search and semantic queries
- **Handoffs** context between tools (GitHub Copilot → Claude → Your IDE)
- **Learns** from executor outcomes to improve future decisions
- **Integrates** with GitHub Copilot via VS Code extension and MCP

### Key Features

✅ **Local-first architecture** - No cloud upload required  
✅ **256-bit encryption** - Your memories stay private  
✅ **Cross-tool handoff** - Seamless context switching  
✅ **Evidence-based execution** - Grounded reasoning, no hallucinations  
✅ **VS Code extension** - Native `@promptx` chat participant  
✅ **Git integration** - Auto-links commits to conversations  
✅ **MCP server** - Integrate with any IDE or AI tool  
✅ **Fuzzy & semantic search** - Find what you need instantly  

## Installation

### macOS and Linux (Homebrew)

```bash
brew tap gautampachnanda101/tap
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

### All Platforms (Direct Download)

Download release archives from the [Homebrew Tap releases page](https://github.com/gautampachnanda101/homebrew-tap/releases).

Each archive includes:
- `promptx` binary (`promptx.exe` on Windows)
- `PROMPTX_USER_GUIDE.md` documentation

Verify installation:
```bash
promptx --version
```

### VS Code Extension

After installing Promptx, install the bundled VS Code extension:

**macOS/Linux:**
```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

**Windows:**
```powershell
code --install-extension "$env:USERPROFILE\scoop\apps\promptx\current\promptx-vscode-*.vsix"
```

**Direct download path:**
Extract the release archive and run:
```bash
code --install-extension promptx-vscode-*.vsix
```

## First-Time Setup

### Initialize Your Vault

```bash
promptx setup
```

This command:
- Creates a secure vault to store encrypted memories
- Sets up a passkey for encryption/decryption
- Enables global MCP registration for IDE settings files
- Configures background memory auto-capture (`memory-watch`)

### Set Environment Variables (Optional)

For non-interactive use (CI/CD, scripts):

```bash
export PROMPTX_PASSKEY="your-secure-passkey"
export PROMPTX_HOME="/path/to/storage"     # Custom storage location
export PROMPTX_DATA_DIR="/path/to/data"    # Custom data directory
```

### Verify Setup

```bash
promptx machine verify
promptx doctor
```

These commands run comprehensive health checks.

## Daily Workflows

### Quick Start: Auto-Memory Capture

```bash
# 1. Start memory watch (capture all interactions)
promptx memory-watch --repo . --interval 5 --force-store

# 2. Work normally - interactions are auto-captured

# 3. Query your memories
promptx memory-query "architecture decision" --repo . --limit 5
```

### Generate Prompts

Ask Promptx to generate prompts using local AI:

```bash
promptx generate "build a fast Go CLI tool"
promptx generate "debug memory leaks in Rust"
promptx search "golang cli"
```

### Query Your Memory

Find information from past interactions:

```bash
# Full-text search
promptx search "connection timeout" --repo . --limit 10

# Fuzzy search with NLP similarity
promptx fuzzy-search "database" --repo . --limit 5

# Natural language questions
promptx ask "what changed in mcp tools?" --repo . --limit 6
```

### Evidence-Based Execution

Get grounded answers backed by your codebase context:

```bash
promptx executor "what changed in mcp tools?" --repo . --limit 8 --min-score 0.25
```

Flags:
- `--limit` – Maximum history items to consider
- `--min-score` – Minimum confidence threshold (0-1)
- `--repo` – Repository path for context

### Memory Management

#### Write a Decision

```bash
promptx memory-write "Decision: use hex over uuid for IDs" \
  --repo . \
  --type decision \
  --tags architecture,database \
  --force-store
```

#### View Recent Memories

```bash
promptx memory-query "backend architecture" --repo . --limit 5
```

#### Continuous Background Capture

```bash
# Watch files and capture automatically
promptx memory-watch --repo . \
  --interval 5 \
  --watch-git \
  --watch-chats \
  --flush-interval 15 \
  --flush-batch 20 \
  --force-store
```

### Git Integration

#### View Commits with Chat Context

```bash
promptx commits --repo . --limit 20 --pretty --group-by-assistant
```

#### Show Repository Graph

Visualize relationships between commits, chats, and code changes:

```bash
promptx graph --repo . --window 200 --json
```

## VS Code Extension

### What It Provides

- **`@promptx` chat participant** in GitHub Copilot Chat
- **Promptx Insights sidebar** with memory and session graphs
- **Promptx Timeline view** showing git commits with AI chat activity
- **Promptx Memory panel** with relative timestamps and tooltips
- **Commands**: Generate, Query, Resume/Handoff, Show Insights
- **Chat commands**: `/timeline`, `/record start`, `/record stop`
- **Status bar** showing active Promptx session state

### Install Extension

After `brew install promptx`:

```bash
code --install-extension $(brew --prefix)/share/promptx/promptx-vscode-*.vsix
```

### Using the Chat Participant

In GitHub Copilot Chat, use:

```
@promptx What changed in the build system?
@promptx /timeline
@promptx /record start
```

### Timeline View

Shows git commits annotated with AI chat activity:

- 🟢 **Green** – High activity (5+ chats)
- 🟡 **Yellow** – Medium activity (2-4 chats)
- 🔵 **Blue** – Low activity (1 chat)
- ⚪ **White** – No linked chats

**Open Timeline:**
- Sidebar: `Promptx: Show Timeline` command
- Chat: `@promptx /timeline`

### Recording Control

Control memory capture from chat:

```
@promptx /record start   # Begin recording
@promptx /record stop    # Stop recording
```

These manage the `memory-watch` daemon.

## MCP Integration

### Run as MCP Server

Integrate Promptx into any MCP-compatible tool:

```bash
promptx mcp
```

This starts a JSON-RPC server over stdio for tools like Claude, Cline, or custom integrations.

### MCP Tools Available

- `promptx_memory_query` – Query encrypted memory
- `promptx_memory_write` – Write new memories
- `promptx_search` – Full-text search
- `promptx_executor` – Evidence-based execution
- `promptx_capabilities` – List supported features

### Keep MCP Running

For persistent MCP connections:

```bash
promptx mcp-guard
```

Auto-restarts the MCP server on failure.

## Advanced Workflows

### Multi-Repository Setup

Monitor multiple repos:

```bash
promptx memory-watch --repo ~/work/project-a --interval 5 --force-store
promptx memory-watch --repo ~/work/project-b --interval 5 --force-store
```

Query across repos:

```bash
promptx memory-query "authentication" --repo ~/work/project-a --limit 5
```

### CI/CD Integration

Capture interactions in automated workflows:

```bash
promptx memory-watch --repo . --once --ingest-existing --force-store
promptx executor "build failures" --repo . --min-score 0.5
```

Flags:
- `--once` – Run capture once, don't loop
- `--ingest-existing` – Include historical logs
- `--force-store` – Save without confirmation

### Cross-Tool Handoff

Seamlessly transfer context between tools:

```bash
# Record current state and create handoff pack
promptx switch

# Later, resume in another tool
promptx resume
```

### Learning from Outcomes

Analyze executor performance:

```bash
promptx benchmark-executor "what changed in api?" \
  --repo . \
  --limit 20 \
  --iterations 5
```

Shows:
- P50, P95, P99 latencies
- Grounded evidence rate
- Candidate volume and ranking

### View Recent Interactions

```bash
# Recent decrypted logs
promptx logs --limit 50

# Interactive logger for a single turn
promptx quicklog

# Verify installation and health
promptx doctor
```

## Command Reference

### Getting Started

| Command | Purpose |
|---------|---------|
| `setup` | Initialize vault and passkey |
| `passkey-change` | Change vault encryption key |
| `machine verify` | Verify system configuration |
| `doctor` | Comprehensive health check |
| `info` | Show environment and status |

### Daily Workflows

| Command | Purpose |
|---------|---------|
| `memory-watch` | Auto-capture interactions continuously |
| `memory-query` | Search encrypted memories |
| `memory-write` | Add a new memory item |
| `search` | Full-text search history |
| `fuzzy-search` | Semantic similarity search |
| `ask` | Ask natural-language questions |
| `generate` | Generate prompts with local LLM |
| `commits` | Show commits with chat history |
| `graph` | Visualize chat-memory relationships |

### Evidence & Analysis

| Command | Purpose |
|---------|---------|
| `executor` | Evidence-based execution |
| `benchmark-executor` | Performance analysis |
| `self-learn` | Learning profile from outcomes |
| `context-pack` | Export memory as context |

### Integrations & Advanced

| Command | Purpose |
|---------|---------|
| `mcp` | Run MCP-compatible server |
| `mcp-guard` | Keep MCP server running |
| `bridge` | JSONL stdin/stdout bridge |
| `serve` | Run localhost HTTP API |
| `log` | Log interaction with telemetry |
| `logs` | Show recent interactions |
| `commit` | Log git deltas to chat |

## Configuration

### Backend Selection

Choose memory backend:

```bash
export PROMPTX_MEMORY_BACKEND=sqlite-v2-token  # Default (token-aware)
export PROMPTX_MEMORY_BACKEND=vector-stub      # Semantic vectors
```

### Storage Location

Override default storage:

```bash
export PROMPTX_HOME=/custom/path                # Main storage
export PROMPTX_DATA_DIR=/custom/data            # Data directory
```

### Passkey Storage

Configure passkey provider:

```bash
export PROMPTX_PASSKEY="your-key"              # Environment variable
# Or use OS keychain (automatically preferred)
```

## Troubleshooting

### Command Not Found

If `promptx` is not recognized:

```bash
# Check installation
which promptx

# Reload shell
exec $SHELL

# Check Homebrew path
brew --prefix promptx
```

### Health Check

Run comprehensive diagnostics:

```bash
promptx doctor
promptx machine verify
promptx info
```

### Memory Issues

Check memory backend status:

```bash
promptx memory-query "" --repo . --limit 1
```

### MCP Issues

Verify MCP setup:

```bash
promptx mcp status
promptx capabilities
```

## Examples

### Example 1: Developer Daily Standup

```bash
# Start capturing
promptx memory-watch --repo . --interval 5 --force-store

# Work on features...

# Generate a standup summary
promptx executor "what did I accomplish today?" --repo . --limit 20
```

### Example 2: Onboarding a Team Member

```bash
# Export project context
promptx context-pack --repo . --window 100 > onboarding-context.md

# Share with new team member
# They import via MCP or paste into chat
```

### Example 3: Cross-Tool Handoff

```bash
# In GitHub Copilot Chat
@promptx generate "refactor auth module"
promptx switch  # Create handoff pack

# Later in Claude
promptx resume  # Restore context
# Continue where you left off
```

### Example 4: Debugging with Memory

```bash
# Find past decisions about error handling
promptx memory-query "error handling strategy" --repo . --limit 5

# Ask evidence-based question
promptx executor "how do we currently handle timeouts?" --repo . --limit 10
```

## Next Steps

- 📖 **Full User Guide**: Check `PROMPTX_USER_GUIDE.md` shipped with binary
- 💬 **Ask Questions**: Use `promptx ask` to query your memories
- 🔗 **VS Code Setup**: Install the extension for IDE integration
- 🤖 **MCP Server**: Run `promptx mcp` to connect with other tools
- 📚 **Learn More**: Visit [GitHub repository](https://github.com/gautampachnanda101/prompt-detective)

## Support

- 📦 **GitHub Repository**: https://github.com/gautampachnanda101/homebrew-tap
- 🐛 **Report Issues**: https://github.com/gautampachnanda101/homebrew-tap/issues
- 💬 **Discussions**: https://github.com/gautampachnanda101/homebrew-tap/discussions
