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

General fallback:

```text
~/ai/models/qwen3-14b/Qwen3-14B-Q5_K_M.gguf
```

## Approximate VRAM Use

The final benchmark showed total GPU memory use around 10.6 to 10.9 GiB while the local model server was active. `llama-server` itself used roughly 9.5 to 9.9 GiB depending on profile.

## Why Qwen3.6 Is Default

Qwen3.6-35B-A3B-MTP is the default on this machine because it fits the 12 GB GPU with the selected dynamic quant, supports speculative MTP decoding, and provides the best current local coding/review profile. The legacy `coder`, `fast`, and `big` aliases route to Qwen3.6 profiles.
