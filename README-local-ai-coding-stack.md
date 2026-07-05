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

`Qwen3-14B` is retained as a general fallback.

## Current Benchmark Notes

| Profile | Model | Context | Gen t/s | Prompt t/s | Notes |
| --- | --- | ---: | ---: | ---: | --- |
| `qwen36` | Qwen3.6-35B-A3B-MTP | 131072 | 70.10-92.69 | 138.60-178.35 | Measured across code, explanation, QA, and JSON classification probes |
| `deepseek` | DeepSeek-R1-Distill-Qwen-32B | 8192 | not run | not run | Installed after the benchmark; not started to avoid interrupting active Qwen work |
| `qwen14` | Qwen3-14B | 8192 | historical fallback | historical fallback | Retained as third fallback |

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

The cleanup script must not delete active model directories, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`. It may remove stale reports, temporary incomplete downloads, and an old broken `~/ai/aider-venv`. Manual model replacement can remove obsolete model directories after profiles and docs are updated.

## Future Improvement Ideas

- Add OpenRouter model-specific launchers for Aider.
- Add a better benchmark suite for prompt processing, edit quality, and long-context behavior.
- Test OpenCode once installed and connected.
- Add a small restore script that copies `scripts/` into `~/bin` with confirmation.
- Add more profiles if new GGUF models are installed.
