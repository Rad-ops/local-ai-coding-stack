# ⚡ README Local AI Coding Stack

<p align="center">
  <img src="assets/local-ai-stack-hero.png" alt="Local AI coding stack workstation with model-routing lanes" width="100%">
</p>

**Version:** `0.2.1` (`20260705`)

This repo is the organized reference project for a private local AI coding stack on CachyOS Linux. It records the installed local models, optimized llama.cpp settings, helper scripts, Aider workflow, OpenRouter cloud fallback, and OpenCode setup notes.

The paired application repo is [Gmail Sorter](https://github.com/Rad-ops/gmail-sorter). That project is where the local Qwen3.6 profile got its first long practical workout.

## 🧭 Architecture

The local path is:

```text
GGUF model -> llama.cpp CUDA server -> OpenAI-compatible API -> Aider
```

The cloud path is:

```text
OpenRouter API key in fish env -> Aider/OpenCode -> OpenRouter model
```

Codex is used separately for structured repo edits and project maintenance.

## 📁 Folder Layout

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

## 🧩 Model Descriptions

`Qwen3.6-35B-A3B-MTP` is the default local coding model. The Qwen profile set is limited to two active profiles: `coder`/`qwen36` for full-context daily work and `fast`/`qwen36-fast` for quicker smaller-context work.

`DeepSeek-R1-Distill-Qwen-32B` is the reasoning/debugging fallback. It uses the Q2_K GGUF on this 12 GB VRAM setup.

`Gemma 4 26B MoE Instruct` is the installed third model for planning, architecture, and multi-step reasoning. It should review designs and risks before Qwen3.6 or DeepSeek implement. It still needs a local fit benchmark before becoming the daily planner default. If the 26B MoE profile is too tight, use `planner-safe` for Gemma 4 12B.

## 📊 Current Benchmark Notes

| Profile | Model | Context | Gen t/s | Prompt t/s | Notes |
| --- | --- | ---: | ---: | ---: | --- |
| `qwen36` | Qwen3.6-35B-A3B-MTP | 131072 | 70.10-92.69 | 138.60-178.35 | Measured across code, explanation, QA, and JSON classification probes |
| `qwen36` | Qwen3.6-35B-A3B-MTP | 131072 | 90.92 avg on Gmail Sorter review | 549.96 avg on Gmail Sorter review | 6,531 bounded mailbox review calls from the local service journal |
| `deepseek` | DeepSeek-R1-Distill-Qwen-32B | 8192 | not run | not run | Installed after the benchmark; not started to avoid interrupting active Qwen work |
| `planner`, `gemma4-26b` | Gemma 4 26B MoE Instruct | 8192 | installed | benchmark pending | Preferred planner/architect target |
| `planner-safe`, `gemma4-12b` | Gemma 4 12B Instruct | 8192 | installed | benchmark pending | Safer planner fallback |

## 🔀 Local vs Cloud Routing

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

## 🧰 Aider vs OpenCode vs Codex

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
- Benchmark the Gemma planner profiles and DeepSeek 32B fallback with the same care as the Qwen3.6 Gmail Sorter run.
- Test OpenCode once installed and connected.
- Add a small restore script that copies `scripts/` into `~/bin` with confirmation.
- Download and benchmark the Gemma 4 26B MoE planner GGUF, then fall back to Gemma 4 12B if needed.
