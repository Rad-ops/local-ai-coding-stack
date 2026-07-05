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

General fallback:

```text
~/ai/models/qwen3-14b/Qwen3-14B-Q5_K_M.gguf
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

`big` / `qwen36-big`: Qwen3.6-35B-A3B-MTP, ctx 131072, q8_0 KV, fit-target 1536, draft-MTP. Large-context profile.

`deepseek`: DeepSeek-R1-Distill-Qwen-32B, ctx 8192, q4_0 KV, batch 256, ubatch 64. Reasoning fallback.

`qwen14`: Qwen3-14B, ctx 8192, q8_0 KV, batch 512, ubatch 128. General fallback.

Do not force `--n-gpu-layers 999`; it caused CUDA OOM before.

## Benchmark Results

```csv
timestamp,profile,model,ctx,cache,batch,ubatch,api_ok,reply_ok,gen_tps,llama_vram_mib,total_vram_mib,ram_used
2026-07-04T14:00:46-04:00,coder-fast,coder,4096,q8_0,512,128,yes,yes,40.50,9698MiB,10920,5.8Gi/30Gi
2026-07-04T14:01:07-04:00,coder-default,coder,8192,q8_0,512,128,yes,yes,41.87,9578MiB,10713,5.8Gi/30Gi
2026-07-04T14:01:31-04:00,coder-big,coder,16384,q4_0,256,64,yes,yes,33.86,9704MiB,10877,5.8Gi/30Gi
2026-07-04T14:02:16-04:00,deepseek-default,deepseek,8192,q8_0,512,128,yes,yes,18.81,9594MiB,10704,5.5Gi/30Gi
2026-07-04T14:03:00-04:00,qwen14-default,qwen14,8192,q8_0,512,128,yes,no,20.02,9530MiB,10625,5.6Gi/30Gi
```

## Main Commands

```fish
cd /path/to/project
dev-ai coder file.py
dev-ai big file.py
dev-ai deepseek file.py
dev-ai qwen14 file.py
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
