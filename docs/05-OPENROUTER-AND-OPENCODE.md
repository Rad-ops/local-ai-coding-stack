# ☁️ OpenRouter and OpenCode

The cloud escape hatch. Use it when:

- The local GPU is busy with a long-running workload
- I want a different hosted model (Mistral Medium 3.5, Claude, etc.)
- I am testing a model before deciding to download a local quant

Aider-Local is still the default. This path is optional.

## Key storage

Do not store the OpenRouter key in this repo. Store it in fish:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

Check without printing:

```fish
set -q OPENROUTER_API_KEY; and echo set; or echo missing
```

The repo includes `.env.example` only. Do not commit `.env`.

## Aider through OpenRouter

```fish
aider-openrouter file.py
```

Default model: `google/gemma-4-31b-it`. Override for one session:

```fish
OPENROUTER_AIDER_MODEL="anthropic/claude-sonnet-4-5" aider-openrouter file.py
```

Or persist in fish:

```fish
set -Ux OPENROUTER_AIDER_MODEL "anthropic/claude-sonnet-4-5"
```

## OpenCode (optional second CLI agent)

OpenCode is a second CLI coding agent outside Aider and Codex. It is
useful when you want a different workflow for code navigation and
edits, especially with hosted models.

**Status: not benchmarked.** Wrappers and docs are ready; the binary
may need to be installed manually.

```fish
setup-opencode-openrouter    # checks if opencode is installed
opencode-openrouter          # launches it pointed at OpenRouter
```

Inside OpenCode:

```text
/connect
/models
```

Select OpenRouter, then choose the model you want. OpenCode should
show OpenRouter as the connected provider; `/models` should list
OpenRouter models, not local llama.cpp models.

If `opencode` is not installed, `setup-opencode-openrouter` prints
install instructions and exits cleanly — it does not install anything
on its own.

## Why this path exists

The local stack is great for privacy, no API cost, and low latency.
The cloud path is great for model variety and not having to manage
VRAM. Both are first-class; the daily default is local.

## Aider vs OpenCode vs Codex

- **Aider** — primary coding agent. Edits files directly. Works
  against both the local llama.cpp endpoint and OpenRouter.
- **OpenCode** — optional second CLI agent. Configured here for
  OpenRouter only. Not wired to local llama.cpp.
- **Codex** — structured repo maintenance, docs, multi-file edits,
  and chat-driven script cleanup. Talks to local models and to
  OpenRouter.

## What not to commit

Already covered by `.gitignore`, but worth restating:

- `.env` — can unlock paid APIs.
- `~/.local/share/opencode/auth.json` — OpenCode login/session state.
- `~/.config` — entire machine config tree; document the exact
  setting instead of committing the directory.
- `~/ai/models` — huge upstream downloads, not source.
