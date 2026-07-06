# 📊 Benchmarks and Real Workloads

*Updated: 2026-07-05*

This page keeps the speed numbers in one place and explains what they
came from. The raw private Gmail reports are not committed; the useful
timing summaries are.

## Current Qwen3.6 benchmark suite

These are the clean benchmark rows from
[`benchmarks/local-ai-final-benchmark.csv`](../benchmarks/local-ai-final-benchmark.csv).
They were run after the Qwen3.6 profile became the main local coding
profile.

| Test | Profile | Context | KV cache | Gen tok/s | Prompt tok/s | Draft accept | Notes |
| --- | --- | ---: | --- | ---: | ---: | ---: | --- |
| Python coding | `qwen36` | 131072 | q8_0 | 84.96 | 151.74 | 90.6% | Live llama.cpp benchmark |
| C++ coding | `qwen36` | 131072 | q8_0 | 92.69 | 165.49 | 94.7% | Live llama.cpp benchmark |
| Explain concept | `qwen36` | 131072 | q8_0 | 74.49 | 138.60 | 68.3% | Live llama.cpp benchmark |
| Factual QA | `qwen36` | 131072 | q8_0 | 70.10 | 144.42 | 64.6% | Live llama.cpp benchmark |
| JSON classification | `qwen36` | 131072 | q8_0 | 73.48 | 178.35 | 100.0% | Closest synthetic match to Gmail Sorter-style classification |

The short version: Qwen3.6 was fast enough to use interactively and
also held up under structured classification prompts.

## Gmail Sorter local review run

The [Gmail Sorter](https://github.com/Rad-ops/gmail-sorter) project used
this stack for local Trash-rescue review through `llm-switch qwen36` and
the local llama.cpp OpenAI-compatible endpoint. The timing summary is
kept; private per-message prompts, message IDs, senders, and model
outputs are not.

| Window | Prompt rows | Prompt tokens | Prompt tok/s avg | Prompt tok/s range | Eval rows | Eval tokens | Eval tok/s avg | Eval tok/s range | Draft acceptance |
| --- | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- | --- |
| 2026-07-05 08:35–16:31 EDT | 6,531 | 10,309,912 | 549.96 | 418.73–740.58 | 6,531 | 846,873 | 90.92 | 19.59–111.19 | 85.03% weighted |

Source: `journalctl --user -u local-llm.service` timing lines from the
Gmail Sorter review window. The summary is saved as
[`benchmarks/gmail-sorter-local-llm-summary-2026-07-05.csv`](../benchmarks/gmail-sorter-local-llm-summary-2026-07-05.csv).

The Gmail workload matters more than the synthetic benchmark because
it was the actual shape of the job: thousands of short, structured
reviews with reused prompt graphs and bounded body excerpts.

## Older fit checks

The July 4 fit checks are kept as history in
[`benchmarks/legacy-local-fit-checks-2026-07-04.csv`](../benchmarks/legacy-local-fit-checks-2026-07-04.csv).
They explain why old names such as `qwen14` and `coder-big` show up in
early notes, but they are not active recommendations anymore.

| Historical target | What happened |
| --- | --- |
| `coder` / early coding model | Worked at 4K–16K contexts, roughly 33.86–54.35 gen tok/s depending on profile. |
| early `deepseek` | Worked, but the later stack moved to DeepSeek-R1-Distill-Qwen-32B for the reasoning fallback role. |
| `qwen14` | Fit checks ran, but reply validation failed in one smoke test and the model was later removed from disk. |

## What still needs a real benchmark

| Profile | Status |
| --- | --- |
| `deepseek` | Installed, but the 32B fallback still needs a proper fit and quality run. |
| `planner` / `gemma4-26b` | Installed; needs a careful VRAM and architecture-review benchmark. |
| `planner-safe` / `gemma4-12b` | Installed; should be tested as the reliable fallback if 26B MoE is too tight. |
