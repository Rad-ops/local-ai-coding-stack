# Next Chat Context

This file is meant to be uploaded or pasted into a future ChatGPT/Codex chat so the assistant can continue the project without rediscovering the stack from scratch.

## Project Summary

The machine is a CachyOS Linux desktop using fish shell, an RTX 4070 Super-class NVIDIA GPU with 12 GB VRAM, about 32 GB RAM, llama.cpp built with CUDA, and Aider as the primary local coding agent. The local API endpoint is `http://127.0.0.1:8080/v1`.

The project folder is:

```text
~/ai/local-ai-stack
```

The repo documents helper scripts, local GGUF model paths, benchmark results, optimized llama.cpp profiles, Aider workflows, and OpenCode/OpenRouter setup.

## Confirmed Local Models

Primary coding model:

```text
~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf
```

Reasoning fallback:

```text
~/ai/models/deepseek-r1-qwen-32b/DeepSeek-R1-Distill-Qwen-32B-Q2_K.gguf
```

Planner/architect model:

```text
~/ai/models/gemma4-26b-moe/gemma-4-26B-A4B-it-Q4_K_M.gguf
~/ai/models/gemma4-12b/gemma-4-12B-it-Q4_K_M.gguf
```

Do not delete active `.gguf` files unless intentionally cleaning obsolete model directories. Do not delete `~/ai/models`, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`.

## llama.cpp Paths

```text
~/ai/llama.cpp
~/ai/llama.cpp/build/bin/llama-server
~/ai/llama.cpp/build/bin/llama-cli
```

The user service is:

```text
~/.config/systemd/user/local-llm.service
```

It should stay disabled at login.

## Best Profiles

`coder` / `qwen36`: Qwen3.6-35B-A3B-MTP, ctx 131072, q8_0 KV, fit-target 1536, draft-MTP. Default daily model.

`fast` / `qwen36-fast`: Qwen3.6-35B-A3B-MTP, ctx 32768, q8_0 KV, fit-target 1536, draft-MTP. Quick profile.

`deepseek`: DeepSeek-R1-Distill-Qwen-32B, ctx 8192, q4_0 KV, batch 256, ubatch 64. Reasoning fallback.

`planner` / `gemma4-26b`: Gemma 4 26B MoE Instruct, ctx 8192, q4_0 KV, batch 256, ubatch 64. Preferred third model for architecture/planning/reasoning. Installed; local fit benchmark pending.

`planner-safe` / `gemma4-12b`: Gemma 4 12B Instruct, ctx 8192, q4_0 KV, batch 256, ubatch 64. Safer fallback if the 26B MoE quant does not fit.

Do not force `--n-gpu-layers 999`; it caused CUDA OOM before.

## Benchmark Results

```csv
timestamp,profile,model,test,ctx,cache,batch,ubatch,api_ok,gen_tps,prompt_tps,draft_accept,notes
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,code_python,131072,q8_0,512,128,yes,84.96,151.74,90.6%,live llama.cpp benchmark
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,code_cpp,131072,q8_0,512,128,yes,92.69,165.49,94.7%,live llama.cpp benchmark
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,json_classify,131072,q8_0,512,128,yes,73.48,178.35,100.0%,live llama.cpp benchmark
2026-07-05T11:00:00-04:00,deepseek,DeepSeek-R1-Distill-Qwen-32B,installed,8192,q4_0,256,64,not_run,,,,installed but not benchmarked to avoid interrupting active qwen36 service
```

## Main Commands

```fish
cd /path/to/project
dev-ai coder file.py
dev-ai qwen36-fast file.py
dev-ai deepseek file.py
dev-ai planner file.py
dev-ai planner-safe file.py
aider-openrouter file.py
opencode-openrouter
dev-ai stop
dev-ai status
check-local-ai-setup
```

## OpenRouter And OpenCode

OpenRouter key must stay outside the repo:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

OpenCode is configured with:

```fish
opencode-openrouter
setup-opencode-openrouter
```

As of this handoff, `opencode` may still need to be installed manually. The wrapper and docs are ready.

## Known Gotchas

- The shell is fish.
- Avoid Bash heredocs in user-facing instructions.
- Do not hardcode API keys.
- Keep `local-llm.service` disabled at login.
- Stop GPU usage with `dev-ai stop`.
- Do not commit `.env`, keys, tokens, model files, caches, venvs, or local auth files.

## Optional Remaining Work

- Re-authenticate GitHub CLI if private repo push failed.
- Install and test OpenCode.
- Add OpenRouter model-specific wrappers.
- Improve benchmarking.
- Optionally test OpenCode against more OpenRouter models.
