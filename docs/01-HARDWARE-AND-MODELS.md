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
~/ai/models/qwen3-coder-30b-a3b/Qwen3-Coder-30B-A3B-Instruct-UD-Q4_K_XL.gguf
```

Upgraded agent/coding model:

```text
~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf
```

Reasoning fallback:

```text
~/ai/models/deepseek-r1-qwen-14b/DeepSeek-R1-Distill-Qwen-14B-Q5_K_M.gguf
```

General fallback:

```text
~/ai/models/qwen3-14b/Qwen3-14B-Q5_K_M.gguf
```

## Approximate VRAM Use

The final benchmark showed total GPU memory use around 10.6 to 10.9 GiB while the local model server was active. `llama-server` itself used roughly 9.5 to 9.9 GiB depending on profile.

## Why Qwen3-Coder Is Default

Qwen3-Coder-30B-A3B is the best default on this machine because it is coding-focused, benchmarked successfully through the local API, and produced the best throughput/quality balance while fitting on 12 GB VRAM with llama.cpp CUDA auto-fit.
