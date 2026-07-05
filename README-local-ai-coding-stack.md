# README Local AI Coding Stack

This repo is the organized reference project for a private local AI coding stack on CachyOS Linux. It records the installed local models, optimized llama.cpp settings, helper scripts, Aider workflow, OpenRouter cloud fallback, and OpenCode setup notes.

## Architecture

The local path is:

```text
GGUF model -> llama.cpp CUDA server -> OpenAI-compatible API -> Aider
```

The cloud path is:

```text
OpenRouter API key in fish env -> Aider/OpenCode -> OpenRouter model
```

Codex is used separately for structured repo edits and project maintenance.

## Folder Layout

```text
~/ai/local-ai-stack/
├── README.md
├── README-local-ai-coding-stack.md
├── GUIDE-HOW-TO-USE.md
├── NEXT-CHAT-CONTEXT.md
├── .gitignore
├── .env.example
├── benchmarks/
├── docs/
├── scripts/
└── reports/
```

`scripts/` contains restorable copies of the helper commands. `docs/` contains detailed operational notes. `reports/` contains only an example report; generated local reports stay outside git.

## Model Descriptions

`Qwen3.6-35B-A3B-MTP` is the default local coding model. The legacy `coder`, `fast`, and `big` aliases route to the Qwen3.6 profiles.

`DeepSeek-R1-Distill-Qwen-32B` is the reasoning/debugging fallback. It uses the Q2_K GGUF on this 12 GB VRAM setup.

`Qwen3-14B` is retained as a general fallback. The final benchmark showed it loaded and generated tokens, but the reply check did not pass, so it is the third option.

## Benchmark Table

| Profile | Context | Cache | Batch | uBatch | API OK | Reply OK | Gen t/s | llama VRAM |
| --- | ---: | --- | ---: | ---: | --- | --- | ---: | --- |
| `coder-fast` | 4096 | q8_0 | 512 | 128 | yes | yes | 40.50 | 9698 MiB |
| `coder` | 8192 | q8_0 | 512 | 128 | yes | yes | 41.87 | 9578 MiB |
| `coder-big` | 16384 | q4_0 | 256 | 64 | yes | yes | 33.86 | 9704 MiB |
| `deepseek` | 8192 | q8_0 | 512 | 128 | yes | yes | 18.81 | 9594 MiB |
| `qwen14` | 8192 | q8_0 | 512 | 128 | yes | no | 20.02 | 9530 MiB |

## Local vs Cloud Routing

Use local routing for privacy, no API cost, and low-latency coding:

```fish
dev-ai coder file.py
```

Use cloud routing when you need a different hosted model or the local GPU should stay free:

```fish
aider-openrouter file.py
opencode-openrouter
```

Cloud routing requires `OPENROUTER_API_KEY` to be set outside the repo.

## Aider vs OpenCode vs Codex

Aider is the primary local coding agent. It edits files directly and works well with the local OpenAI-compatible llama.cpp endpoint.

OpenCode is an optional second CLI coding agent. In this repo it is configured only for OpenRouter, not the local llama.cpp endpoint.

Codex is useful for broader repo maintenance, documentation, script cleanup, and structured multi-file changes.

## Safe Cleanup Procedure

Preview cleanup:

```fish
cleanup-local-ai --dry-run
```

Apply cleanup:

```fish
cleanup-local-ai --apply
```

The cleanup script must never delete GGUF files, `~/ai/models`, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`. It may remove stale reports, temporary incomplete downloads, and an old broken `~/ai/aider-venv`.

## Future Improvement Ideas

- Add OpenRouter model-specific launchers for Aider.
- Add a better benchmark suite for prompt processing, edit quality, and long-context behavior.
- Test OpenCode once installed and connected.
- Add a small restore script that copies `scripts/` into `~/bin` with confirmation.
- Add more profiles if new GGUF models are installed.
