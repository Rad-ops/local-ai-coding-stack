# 🔁 Continuation Handoff

**Upload or paste this file (and only this file) into a new
ChatGPT / Codex / OpenCode session to continue the project.**

Everything a fresh session needs to drive the local AI coding stack is
below. It is intentionally self-contained — you do not need to upload
the README or the other docs.

## Machine

- **OS:** CachyOS Linux
- **Shell:** fish
- **GPU:** RTX 4070 Super-class NVIDIA GPU
- **VRAM:** 12 GB
- **RAM:** ~32 GB
- **Working dir:** `~/ai/local-ai-stack`
- **Local API:** `http://127.0.0.1:8080/v1`
- **llama.cpp:** `~/ai/llama.cpp`, server binary
  `~/ai/llama.cpp/build/bin/llama-server`
- **Helper scripts:** installed in `~/bin/` from `scripts/`
- **Systemd user service:** `~/.config/systemd/user/local-llm.service`
  (must stay **disabled** at login)
- **GitHub repo:** <https://github.com/Rad-ops/local-ai-coding-stack>
- **Companion real workload:** <https://github.com/Rad-ops/gmail-sorter>

## Local models (paths)

```text
~/ai/models/qwen3.6-35b-a3b-mtp/Qwen3.6-35B-A3B-MTP-UD-Q2_K_XL.gguf
~/ai/models/deepseek-r1-qwen-32b/DeepSeek-R1-Distill-Qwen-32B-Q2_K.gguf
~/ai/models/gemma4-26b-moe/gemma-4-26B-A4B-it-Q4_K_M.gguf
~/ai/models/gemma4-12b/gemma-4-12B-it-Q4_K_M.gguf
```

## Best profiles

| Profile alias(es) | Model | Context | KV | Batch / uBatch | Sampler | Role |
| --- | --- | ---: | --- | ---: | --- | --- |
| `coder`, `qwen36` | Qwen3.6-35B-A3B-MTP | 131072 | q8_0 | 512 / 128 | temp 0.6, top_p 0.95, draft-MTP | Default daily coding |
| `fast`, `coder-fast`, `qwen36-fast` | Qwen3.6-35B-A3B-MTP | 32768 | q8_0 | 512 / 128 | temp 0.6, top_p 0.95, draft-MTP | Quick smaller-context work |
| `deepseek` | DeepSeek-R1-Distill-Qwen-32B | 8192 | q4_0 | 256 / 64 | temp 0.6, top_p 0.95 | Reasoning fallback (not benchmarked yet) |
| `planner`, `gemma4`, `gemma4-26b` | Gemma 4 26B MoE | 8192 | q4_0 | 256 / 64 | temp 0.6, top_p 0.95 | Planner (not benchmarked yet) |
| `planner-safe`, `gemma4-12b` | Gemma 4 12B | 8192 | q4_0 | 256 / 64 | temp 0.6, top_p 0.95 | Planner fallback (not benchmarked yet) |

## Headline benchmark

Gmail Sorter Trash-rescue local review, 2026-07-05 08:35–16:31 EDT,
profile `qwen36`:

- 6,531 reviewed rows
- 10,309,912 prompt tokens at **549.96** avg prompt tok/s
  (range 418.73–740.58)
- 846,873 generated tokens at **90.92** avg gen tok/s
  (range 19.59–111.19)
- **85.03%** weighted draft-token acceptance
- Source: `journalctl --user -u local-llm.service` timing lines

This is the one real workload that proved the local stack is useful
beyond synthetic prompts. See `benchmarks/gmail-sorter-local-llm-summary-2026-07-05.csv`.

## Main commands

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

## OpenRouter / OpenCode

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"   # once
aider-openrouter file.py                       # default: google/gemma-4-31b-it
OPENROUTER_AIDER_MODEL=... aider-openrouter file.py   # override
opencode-openrouter                            # optional second agent
```

`opencode` may still need to be installed manually; the wrapper and
docs are ready.

## Known gotchas

- Shell is **fish**, not bash. Avoid Bash heredocs in user-facing
  instructions; use editors or direct file writes instead.
- Do not hardcode API keys. Keep them in fish universal variables
  (`set -Ux`).
- Do not commit `.env`, keys, tokens, model files, caches, venvs,
  generated reports, or `~/.local/share/opencode/auth.json`.
- Keep `local-llm.service` disabled at login; start it only via
  `llm-switch` or `dev-ai <profile>`.
- Stop GPU usage with `dev-ai stop` (or `llm-stop`) when finished.
- Do not force `--n-gpu-layers 999`; it caused CUDA OOM on 12 GB VRAM.
- Do not delete `~/ai/models`, `~/ai/llama.cpp`, or `~/ai/local-ai-stack`.

## Optional remaining work

- Benchmark the DeepSeek 32B fallback without interrupting the live
  Qwen service.
- Benchmark `planner` / `gemma4-26b` and `planner-safe` / `gemma4-12b`
  with the same care as the Qwen3.6 run.
- Install and test OpenCode against a wider set of OpenRouter models.
- Add OpenRouter model-specific launchers for Aider if needed.
