# Next Chat Context

This project is a public local AI coding stack for CachyOS Linux with fish shell, an RTX 4070 Super-class NVIDIA GPU with 12 GB VRAM, about 32 GB RAM, llama.cpp built with CUDA, Aider for local coding, and OpenCode configured for OpenRouter.

Local API:

```text
http://127.0.0.1:8080/v1
```

Project folder:

```text
~/ai/local-ai-stack
```

GitHub repo:

```text
https://github.com/Rad-ops/local-ai-coding-stack
```

Companion real workload:

```text
https://github.com/Rad-ops/gmail-sorter
```

Models:

```text
~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf
~/ai/models/deepseek-r1-qwen-32b/DeepSeek-R1-Distill-Qwen-32B-Q2_K.gguf
~/ai/models/gemma4-26b-moe/gemma-4-26B-A4B-it-Q4_K_M.gguf
~/ai/models/gemma4-12b/gemma-4-12B-it-Q4_K_M.gguf
```

llama.cpp:

```text
~/ai/llama.cpp
~/ai/llama.cpp/build/bin/llama-server
~/ai/llama.cpp/build/bin/llama-cli
```

Best profiles:

- `coder`, `qwen36`: Qwen3.6-35B-A3B-MTP, ctx 131072, q8_0, fit-target 1536, draft-MTP
- `fast`, `qwen36-fast`: Qwen3.6-35B-A3B-MTP, ctx 32768, q8_0, fit-target 1536, draft-MTP
- `deepseek`: DeepSeek-R1-Distill-Qwen-32B, ctx 8192, q4_0, batch 256, ubatch 64
- `planner`, `gemma4-26b`: Gemma 4 26B MoE Instruct, ctx 8192, q4_0, batch 256, ubatch 64, installed, benchmark pending
- `planner-safe`, `gemma4-12b`: Gemma 4 12B Instruct, ctx 8192, q4_0, batch 256, ubatch 64, installed, benchmark pending

Real workload benchmark:

- Gmail Sorter Trash rescue local review, 2026-07-05 08:35-16:31 EDT
- Qwen3.6 reviewed 6,531 bounded rows
- 10,309,912 prompt tokens at 549.96 average prompt tok/sec
- 846,873 generated tokens at 90.92 average generation tok/sec
- 85.03% weighted draft-token acceptance

Main commands:

```fish
dev-ai coder file.py
dev-ai deepseek file.py
dev-ai planner file.py
dev-ai planner-safe file.py
aider-openrouter file.py
opencode-openrouter
dev-ai stop
dev-ai status
check-local-ai-setup
```

Safety:

- Do not delete active `.gguf` files unless intentionally cleaning obsolete model directories.
- Do not delete `~/ai/models`, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`.
- Do not hardcode keys.
- Do not commit `.env`.
- Do not force `--n-gpu-layers 999`.
- Keep `local-llm.service` disabled at login.

Optional remaining work:

- Install OpenCode if it is still missing.
- Test OpenCode with OpenRouter.
- Benchmark DeepSeek 32B and Gemma planner profiles with the same care as Qwen3.6.
