# 🧩 Models and Profiles

## Hardware

- **OS:** CachyOS Linux
- **Shell:** fish
- **GPU:** RTX 4070 Super-class NVIDIA GPU
- **VRAM:** 12 GB
- **RAM:** ~32 GB

## Runtime

- **llama.cpp source:** `~/ai/llama.cpp`
- **llama.cpp server:** `~/ai/llama.cpp/build/bin/llama-server`
- **llama.cpp CLI:** `~/ai/llama.cpp/build/bin/llama-cli`
- **Local API:** `http://127.0.0.1:8080/v1`
- **Systemd user service:** `~/.config/systemd/user/local-llm.service` (disabled at login)
- **Runtime config (written by `llm-switch`):** `~/.config/local-llm/current-model.env`

## Models and their roles

### 🛠️ Implementer — Qwen3.6-35B-A3B-MTP

```text
~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf
```

The default daily coding model. Chosen because:

- The UD-Q2_K_XL dynamic quant fits 12 GB VRAM at 128K context with
  q8_0 KV cache.
- Speculative MTP decoding (draft-MTP) gives a real speedup on code
  generation.
- The Qwen3.6 family is the current bleeding-edge Qwen path; the older
  Qwen3 / Qwen14 direction was retired.

### 🧠 Reasoning fallback — DeepSeek-R1-Distill-Qwen-32B

```text
~/ai/models/deepseek-r1-qwen-32b/DeepSeek-R1-Distill-Qwen-32B-Q2_K.gguf
```

Hard-reasoning and debugging fallback. Chosen because the previous
smaller DeepSeek target was not strong enough for the "hard reasoning
check" role; the 32B distill is.

Not benchmarked locally yet — the Q2_K quant was installed after the
Qwen3.6 Gmail Sorter run and the active service has not been interrupted
to benchmark it. See [`docs/09-BENCHMARKS-AND-WORKLOADS.md`](09-BENCHMARKS-AND-WORKLOADS.md).

### 🏗️ Planner — Gemma 4 26B A4B MoE Instruct

```text
~/ai/models/gemma4-26b-moe/gemma-4-26B-A4B-it-Q4_K_M.gguf
```

Architecture, decomposition, risk review, test strategy. Chosen because
the third local slot should add diversity (non-Qwen, non-DeepSeek) and
focus on planning, not implementation.

Gemma 4 is a family, not just a 12B model — see
[`docs/06-PLANNER-MODEL-SHORTLIST.md`](06-PLANNER-MODEL-SHORTLIST.md) for
the full research table. The 26B MoE is the preferred first test because
it is larger than 12B but activates only ~3.8B parameters per token.
However, the full quantized weights still need ~16.8 GB on disk and
will only fit 12 GB VRAM at 8K context with q4_0 KV cache. Benchmark
locally before relying on it as the daily planner.

### 🧯 Planner fallback — Gemma 4 12B Instruct

```text
~/ai/models/gemma4-12b/gemma-4-12B-it-Q4_K_M.gguf
```

Use this if the 26B MoE profile is too tight on 12 GB VRAM or unstable.
Also installed but unbenchmarked.

## Profile table

| Profile alias(es) | Model | Context | KV cache | Batch | uBatch | Sampler | Notes |
| --- | --- | ---: | --- | ---: | ---: | --- | --- |
| `coder`, `qwen36` | Qwen3.6-35B-A3B-MTP | 131072 | q8_0 | 512 | 128 | temp 0.6, top_p 0.95 | Default daily coding; draft-MTP speculative decoding |
| `fast`, `coder-fast`, `qwen36-fast` | Qwen3.6-35B-A3B-MTP | 32768 | q8_0 | 512 | 128 | temp 0.6, top_p 0.95 | Quick smaller-context work; draft-MTP |
| `deepseek` | DeepSeek-R1-Distill-Qwen-32B | 8192 | q4_0 | 256 | 64 | temp 0.6, top_p 0.95 | Reasoning / debugging fallback |
| `planner`, `gemma4`, `gemma4-26b` | Gemma 4 26B MoE Instruct | 8192 | q4_0 | 256 | 64 | temp 0.6, top_p 0.95 | Architecture / planning (benchmark pending) |
| `planner-safe`, `gemma4-12b` | Gemma 4 12B Instruct | 8192 | q4_0 | 256 | 64 | temp 0.6, top_p 0.95 | Safer planner fallback if 26B MoE does not fit |

The settings live in `scripts/llm-switch`. Each `case` block sets the
model path, context, batch sizes, cache type, sampler, and speculative-
decoding parameters. The script then writes them to
`~/.config/local-llm/current-model.env` and restarts the
`local-llm.service`.

The service reads the env file at startup, so the only correct way to
change profiles is via `llm-switch` (or `dev-ai <profile>`).

## Approximate VRAM use

The final Qwen3.6 fit check showed total GPU memory use around
10.6–10.9 GiB while the local model server was active. `llama-server`
itself used roughly 9.5–9.9 GiB depending on profile.

## Why the strict KV cache choices

- **`q8_0` for Qwen3.6** — gives best speed/quality tradeoff at 128K
  context. Lower quant types (q4_0) lose too much quality on long
  prompts at this size.
- **`q4_0` for DeepSeek and Gemma** — both are used at ≤8K context for
  planning/reasoning, not long code reviews, so the quality hit is
  acceptable in exchange for fitting in VRAM.

## Why not `--n-gpu-layers 999`

Setting `--n-gpu-layers 999` (offload everything) caused CUDA OOM on
this 12 GB box. The profiles instead let llama.cpp auto-fit, which
keeps the working set inside VRAM.
