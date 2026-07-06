# OpenRouter And OpenCode

## Why OpenCode Was Added

OpenCode is a second CLI coding agent outside Codex and Aider. It provides another workflow for code navigation and edits, especially when using hosted models through OpenRouter.

## How It Differs From Aider And Codex

Aider is the primary local coding agent. It is already proven with the local llama.cpp endpoint and can also use OpenRouter through `aider-openrouter`.

OpenCode is configured here for OpenRouter only. It is not wired to the local llama.cpp endpoint in this repo.

Codex is used for structured repo maintenance, documentation, scripts, and controlled multi-file edits.

## Key Storage

Do not store the OpenRouter key in this repo. Store it in fish:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

Check it without printing the value:

```fish
set -q OPENROUTER_API_KEY; and echo set; or echo missing
```

The repo includes `.env.example` only. Do not commit `.env`.

## Run OpenCode

```fish
setup-opencode-openrouter
opencode-openrouter
```

Inside OpenCode:

```text
/connect
/models
```

Select OpenRouter and then choose the model you want.

## Verify OpenRouter Use

OpenCode should show OpenRouter as the connected provider after `/connect`. Running `/models` should list OpenRouter models, not local llama.cpp models.

## Avoid Committing Keys

The repo keeps provider keys and local login state out of Git because those files belong to the machine, not the project. `.env` can unlock paid APIs, OpenCode auth files can contain local session state, and GGUF files are huge upstream downloads that make the repo unusable for normal cloning. Also avoid adding:

```text
~/.local/share/opencode/auth.json
~/.config
~/ai/models
```
