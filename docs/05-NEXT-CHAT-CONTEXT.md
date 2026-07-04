# Next Chat Context

This project is a private local AI coding stack for CachyOS Linux with fish shell, an RTX 4070 Super-class NVIDIA GPU with 12 GB VRAM, about 32 GB RAM, llama.cpp built with CUDA, Aider for local coding, and OpenCode planned/configured for OpenRouter.

Local API:

```text
http://127.0.0.1:8080/v1
```

Project folder:

```text
~/ai/local-ai-stack
```

Models:

```text
~/ai/models/qwen3-coder-30b-a3b/Qwen3-Coder-30B-A3B-Instruct-UD-Q4_K_XL.gguf
~/ai/models/deepseek-r1-qwen-14b/DeepSeek-R1-Distill-Qwen-14B-Q5_K_M.gguf
~/ai/models/qwen3-14b/Qwen3-14B-Q5_K_M.gguf
```

llama.cpp:

```text
~/ai/llama.cpp
~/ai/llama.cpp/build/bin/llama-server
~/ai/llama.cpp/build/bin/llama-cli
```

Best profiles:

- `coder`: Qwen3-Coder, ctx 8192, q8_0, batch 512, ubatch 128
- `coder-big`: Qwen3-Coder, ctx 16384, q4_0, batch 256, ubatch 64
- `deepseek`: DeepSeek-R1-Distill-Qwen-14B, ctx 8192, q8_0, batch 512, ubatch 128
- `qwen14`: Qwen3-14B, ctx 8192, q8_0, batch 512, ubatch 128

Main commands:

```fish
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

Safety:

- Do not delete `.gguf` files.
- Do not delete `~/ai/models`, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`.
- Do not hardcode keys.
- Do not commit `.env`.
- Do not force `--n-gpu-layers 999`.
- Keep `local-llm.service` disabled at login.

Optional remaining work:

- Re-authenticate GitHub CLI if needed and push the private repo.
- Install OpenCode if it is still missing.
- Test OpenCode with OpenRouter.
- Add better benchmark scripts.
