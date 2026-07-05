# Local AI Coding Stack

Private documentation and helper scripts for a local AI coding workflow on CachyOS Linux. The stack uses llama.cpp with CUDA for local GGUF models, Aider for local and OpenRouter-assisted coding, Codex for repo work, and OpenCode as an optional OpenRouter-only coding agent.

## Hardware

- OS: CachyOS Linux
- Shell: fish
- GPU: RTX 4070 Super-class NVIDIA GPU
- VRAM: 12 GB
- RAM: about 32 GB
- Local endpoint: `http://127.0.0.1:8080/v1`
- llama.cpp source: `~/ai/llama.cpp`
- llama.cpp server: `~/ai/llama.cpp/build/bin/llama-server`
- llama.cpp CLI: `~/ai/llama.cpp/build/bin/llama-cli`

## Local Models

- Primary coding model: `~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf`
- Reasoning fallback: `~/ai/models/deepseek-r1-qwen-32b/DeepSeek-R1-Distill-Qwen-32B-Q2_K.gguf`
- General fallback: `~/ai/models/qwen3-14b/Qwen3-14B-Q5_K_M.gguf`

The `qwen36` profile uses the Qwen3.6-35B-A3B MTP quant with speculative draft-MTP settings, 128K context, q8_0 KV cache, and llama.cpp fit targeting for the 12 GB GPU. The legacy `coder`, `fast`, and `big` aliases now route to the Qwen3.6 profiles.

## Optimized Profiles

| Profile | Model | Context | KV cache | Batch | uBatch | Role |
| --- | --- | ---: | --- | ---: | ---: | --- |
| `coder`, `qwen36` | Qwen3.6-35B-A3B-MTP | 131072 | q8_0 | auto-fit | auto-fit | Default daily coding |
| `fast`, `coder-fast`, `qwen36-fast` | Qwen3.6-35B-A3B-MTP | 32768 | q8_0 | auto-fit | auto-fit | Quick Qwen3.6 work |
| `big`, `coder-big`, `qwen36-big` | Qwen3.6-35B-A3B-MTP | 131072 | q8_0 | auto-fit | auto-fit | Larger Qwen3.6 context |
| `deepseek` | DeepSeek-R1-Distill-Qwen-32B | 8192 | q4_0 | 256 | 64 | Reasoning/debugging fallback |
| `qwen14` | Qwen3-14B | 8192 | q8_0 | 512 | 128 | General fallback |

## Aider Local

`aider-local` points Aider at the local llama.cpp server:

```fish
set -x OPENAI_API_BASE "http://127.0.0.1:8080/v1"
set -x OPENAI_API_KEY "sk-local"
aider --model openai/local --no-show-model-warnings
```

`dev-ai` switches the local model profile, waits for the API, and launches Aider.

## OpenCode Through OpenRouter

OpenCode is configured as a cloud-routed coding agent through OpenRouter only. The repo includes `scripts/opencode-openrouter` and `scripts/setup-opencode-openrouter`, but it does not store keys.

Set the key outside the repo in fish:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

Then run:

```fish
opencode-openrouter
```

Inside OpenCode:

```text
/connect
/models
```

## Daily Commands

```fish
cd /path/to/project
dev-ai coder file.py
dev-ai big file.py
dev-ai qwen36 file.py
dev-ai qwen36-big file.py
dev-ai deepseek file.py
dev-ai qwen14 file.py
aider-openrouter file.py
opencode-openrouter
dev-ai stop
dev-ai status
```

## Safety Notes

- Do not commit real API keys.
- Do not commit `.env`.
- Do not commit GGUF model files.
- Do not delete `~/ai/models`, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`.
- Do not force `--n-gpu-layers 999`; it caused CUDA OOM before.
- Keep `local-llm.service` disabled at login so it does not automatically consume VRAM.

## What Not To Commit

Excluded by `.gitignore`:

- `.env`, key, token, and secret files
- `*.gguf`
- `models/` and `ai/models/`
- virtualenvs, node modules, caches
- generated local reports and logs
- local OpenCode auth files such as `~/.local/share/opencode/auth.json`
- `~/.config`

## Restore Scripts Into `~/bin`

From this repo:

```fish
cd ~/ai/local-ai-stack
cp scripts/* ~/bin/
chmod +x ~/bin/llm-switch ~/bin/dev-ai ~/bin/aider-local ~/bin/aider-openrouter ~/bin/cleanup-local-ai ~/bin/check-local-ai-setup ~/bin/llm-logs ~/bin/llm-status ~/bin/llm-stop ~/bin/llm-test ~/bin/opencode-openrouter ~/bin/setup-opencode-openrouter
```

## Future ChatGPT/Codex Sessions

Upload or paste:

- `NEXT-CHAT-CONTEXT.md`
- `docs/05-NEXT-CHAT-CONTEXT.md`
- `README-local-ai-coding-stack.md`
- optionally `~/local-ai-setup-report.txt`

These files contain the machine context, model paths, safe defaults, commands, and remaining optional work.
