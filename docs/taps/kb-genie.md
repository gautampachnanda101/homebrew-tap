# kb-genie

Turn documentation sites, repositories and files into a knowledge base that
runs on your own machine. kb-genie gives you two connected apps:

- **Chat** — ask questions in plain language and get answers that cite their
  sources, with a note to check anything important.
- **The Knowledge Hub** — a wiki compiled from your sources. Every page has
  **Teach me** (flash cards built from the page's sections, with a topic map
  and related topics) and **Quiz me** (questions checked against the page),
  plus search across everything you ingested.

Each links to the other: a chat answer links to the wiki page it came from,
and every wiki page can continue in chat.

It runs on local models through Ollama or LM Studio, and needs no API keys.
If you want, Quiz and Teach can use a larger Ollama cloud model instead.

## Install

```bash
brew tap gautampachnanda101/tap
brew install kb-genie
```

You also need [Docker Desktop](https://www.docker.com/products/docker-desktop/)
and [Ollama](https://ollama.com) (or LM Studio).

## First run

```bash
kb-genie doctor    # checks Docker, your model backend, models and memory
kb-genie start     # pick knowledge bases to build, pull models, start everything
```

The first run downloads models and crawls the docs you picked, which takes
roughly ten minutes. When it finishes it prints where to open each app:

| | Knowledge Hub | Chat |
| --- | --- | --- |
| Clean names | `http://knowledge-hub.127-0-0-1.sslip.io:8888` | `http://knowledge-chat.127-0-0-1.sslip.io:8888` |
| If your network blocks sslip.io | `http://knowledge-hub.localhost:8888` | `http://knowledge-chat.localhost:8888` |
| Direct | `http://127.0.0.1:8080` | `http://127.0.0.1:3000` |

The `.localhost` names never need DNS, so they work on company networks that
block sslip.io.

## Everyday use

```bash
kb-genie namespace examples                  # bundled knowledge bases you can add
kb-genie namespace add <name> --from <yaml>  # add one, or your own config
kb-genie namespace ingest <name>             # crawl and index it
kb-genie wiki compile <name> --bg            # build or catch up its wiki
kb-genie status                              # health and sizes
```

## Upgrading

```bash
brew upgrade kb-genie
kb-genie setup-webui --all    # give chat and the wiki the new version
```

`kb-genie pipe-status` shows which version each knowledge base's chat is
running.

## Choosing a model for Quiz and Teach

Small local models answer chat well but sometimes can't write a grounded
quiz question or lesson. `kb-genie doctor` measures your machine and
recommends a tier: the default small model, your base model, or a larger
one — including an Ollama cloud model, which needs no local memory. It can
also list every model your backend offers so you can choose any of them. On
a low-memory machine you can switch Quiz and Teach off, and chat and the wiki
keep working.

## Help

```bash
kb-genie help                 # every command
kb-genie <command> --help     # options for one command
kb-genie docs user-guide      # the full guide, offline
kb-genie docs config <field>  # look up a config field
```

Common fixes:

- **The clean URLs don't open** — use the `.localhost` names or the direct
  ports above.
- **Chat answers have no sources** — pick your knowledge base's model in the
  chat's model menu, or run `kb-genie setup-webui --all`.
- **Teach me or Quiz me says the chat stack isn't running** — run
  `kb-genie start`.
- **Something looks wrong** — `kb-genie status`, then `kb-genie logs`.

Report packaging issues on the [tap's issue tracker](https://github.com/gautampachnanda101/homebrew-tap/issues).
