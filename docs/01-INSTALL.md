# 🛠️ Install

Full install from a clean CachyOS box with a 12 GB NVIDIA GPU.

## 0. Prerequisites

Confirmed working on:

- CachyOS Linux (Arch-based, fish default)
- fish shell
- RTX 4070 Super-class NVIDIA GPU, 12 GB VRAM, ~32 GB RAM
- NVIDIA driver + CUDA toolkit installed (`nvidia-smi` works)

System packages the stack assumes exist:

```fish
# CachyOS / Arch
sudo pacman -S --needed git base-devel cmake curl jq
# Aider (Python) and pipx as you prefer
sudo pacman -S --needed python aider
```

You also need network access to:

- GitHub (this repo)
- Hugging Face (GGUF model downloads)
- OpenRouter (only if you want the cloud path)

## 1. Build llama.cpp with CUDA

```fish
git clone https://github.com/ggml-org/llama.cpp ~/ai/llama.cpp
cd ~/ai/llama.cpp
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release -j
```

Sanity check:

```fish
ls -lh ~/ai/llama.cpp/build/bin/llama-server ~/ai/llama.cpp/build/bin/llama-cli
~/ai/llama.cpp/build/bin/llama-cli --version
```

## 2. Download the GGUF models

Create the four model directories under `~/ai/models/`. Download the GGUFs
from their Hugging Face sources; do not commit them to this repo.

| Slot | Path | Source |
| --- | --- | --- |
| 🛠️ Implementer | `~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf` | Official Qwen3.6-35B-A3B-MTP repo, UD-Q2_K_XL quant |
| 🧠 Reasoning fallback | `~/ai/models/deepseek-r1-qwen-32b/DeepSeek-R1-Distill-Qwen-32B-Q2_K.gguf` | Official DeepSeek-R1-Distill-Qwen-32B repo, Q2_K quant |
| 🏗️ Planner | `~/ai/models/gemma4-26b-moe/gemma-4-26B-A4B-it-Q4_K_M.gguf` | Google Gemma 4 26B A4B MoE, Q4_K_M |
| 🧯 Planner-safe | `~/ai/models/gemma4-12b/gemma-4-12B-it-Q4_K_M.gguf` | Google Gemma 4 12B Instruct, Q4_K_M |

The 26B MoE quant is about 16.8 GB on disk. It will fit on a 12 GB GPU at
8K context only with `q4_0` KV cache; benchmark before relying on it.

## 3. Clone this repo

```fish
git clone https://github.com/Rad-ops/local-ai-coding-stack.git ~/ai/local-ai-stack
cd ~/ai/local-ai-stack
```

## 4. Install the helper scripts

```fish
bash ~/ai/local-ai-stack/scripts/install.sh
```

That copies everything in `scripts/` into `~/bin/` and chmods it. Re-run
it any time you pull a new version of the repo.

## 5. Create the systemd user service

Write `~/.config/systemd/user/local-llm.service` with a template that
reads its config from `~/.config/local-llm/current-model.env` (which
`llm-switch` writes). The template lives in this repo at
`scripts/local-llm.service.example` if present, or generate it from
scratch using the working unit on the original box. The service **must
be disabled at login** so it does not auto-claim VRAM:

```fish
systemctl --user daemon-reload
systemctl --user disable local-llm
systemctl --user is-enabled local-llm   # expect: disabled
```

## 6. (Optional) Set up OpenRouter

Only needed for the cloud escape hatch.

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

Verify without printing the value:

```fish
set -q OPENROUTER_API_KEY; and echo set; or echo missing
```

## 7. Smoke test

```fish
llm-switch qwen36-fast
# wait for "Ready." — about 5–10 seconds
llm-test
# expect: a short Python function and explanation
dev-ai stop
```

If `llm-test` returns a function, the local stack is working.

## 8. Audit the install

```fish
check-local-ai-setup
cat ~/local-ai-setup-report.txt
```

The report is gitignored on purpose — it contains local paths, runtime
state, and machine-specific details that do not belong in the repo.
