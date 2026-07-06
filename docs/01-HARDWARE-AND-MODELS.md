# Hardware And Models

## Hardware

- OS: CachyOS Linux
- Shell: fish
- GPU: RTX 4070 Super-class NVIDIA GPU
- VRAM: 12 GB
- RAM: about 32 GB

## Runtime

- llama.cpp source: `~/ai/llama.cpp`
- llama.cpp server: `~/ai/llama.cpp/build/bin/llama-server`
- llama.cpp CLI: `~/ai/llama.cpp/build/bin/llama-cli`
- Local API: `http://127.0.0.1:8080/v1`
- User service: `~/.config/systemd/user/local-llm.service`

## Models

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

## Approximate VRAM Use

The final benchmark showed total GPU memory use around 10.6 to 10.9 GiB while the local model server was active. `llama-server` itself used roughly 9.5 to 9.9 GiB depending on profile.

## Why Qwen3.6 Is Default

Qwen3.6-35B-A3B-MTP is the default on this machine because it fits the 12 GB GPU with the selected dynamic quant, supports speculative MTP decoding, and provides the best current local coding/review profile. The Qwen3.6 choices are intentionally limited to `coder`/`qwen36` and `fast`/`qwen36-fast`.

## Third Fallback Plan

Use Gemma 4 26B MoE Instruct as the first third-slot test so the stack has a non-Qwen/non-DeepSeek model focused on planning, architecture, and multi-step reasoning. Gemma 4 is not only 12B: the family also includes a 26B MoE and 31B dense model. Because the 26B option is MoE, try it before the 12B fallback, starting at `gemma-4-26B-A4B-it-Q4_K_M.gguf`, 8K context, q4_0 KV cache, batch 256, and ubatch 64. The GGUF is installed; the model still needs a local fit benchmark before daily planner use.
