# Continuation Handoff

Updated: 2026-07-05

## What Is Done

- Public repo: `https://github.com/Rad-ops/local-ai-coding-stack`
- Companion repo: `https://github.com/Rad-ops/gmail-sorter`
- Current version target: `0.2.1`
- Added the Gmail Sorter Qwen3.6 workload benchmark from the live Trash rescue run.
- Added legacy July 4 fit-check benchmarks so the model-selection history is not lost.
- Humanized the ignore/privacy guidance to explain why secrets, local auth, generated reports, logs, and model binaries stay local.
- Cross-linked both projects in the README and next-chat handoff files.

## Benchmark Numbers To Preserve

Gmail Sorter local review window:

- Time: 2026-07-05 08:35-16:31 EDT
- Profile: `qwen36`
- Model: `Qwen3.6-35B-A3B-MTP`
- Prompt rows: 6,531
- Prompt tokens: 10,309,912
- Prompt tok/sec average: 549.96
- Prompt tok/sec range: 418.73-740.58
- Eval rows: 6,531
- Eval tokens: 846,873
- Eval tok/sec average: 90.92
- Eval tok/sec range: 19.59-111.19
- Draft acceptance weighted: 85.03%

## Still Worth Doing Later

- Benchmark DeepSeek 32B without interrupting a live Qwen service.
- Benchmark `planner` / `gemma4-26b` and `planner-safe` / `gemma4-12b`.
- Add a small benchmark runner script once the manual benchmark format settles.
