# Changelog

## 0.2.1 - 2026-07-05

### 📊 Benchmarks And Real Workloads

- Added the Gmail Sorter local-review benchmark extracted from the live Qwen3.6 Trash rescue run: 6,531 reviewed rows, 10,309,912 prompt tokens, 846,873 generated tokens, 549.96 average prompt tok/sec, 90.92 average generation tok/sec, and 85.03% weighted draft-token acceptance.
- Added `benchmarks/gmail-sorter-local-llm-summary-2026-07-05.csv` so the real mailbox workload sits beside the synthetic benchmark notes.
- Added `benchmarks/legacy-local-fit-checks-2026-07-04.csv` to preserve the early model-fit checks instead of losing the path that led to the current stack.
- Added `docs/11-BENCHMARKS-AND-WORKLOADS.md` with a readable explanation of what each benchmark means, what was measured, and what still needs a fair test.

### 🧑‍🔧 Documentation Polish

- Cross-linked the companion Gmail Sorter repo because it is the first serious workload that proved the local stack was useful outside synthetic prompts.
- Rewrote the commit/exclusion guidance so it explains why keys, models, local reports, logs, OpenCode auth, and whole-machine config trees stay out of Git.
- Updated next-chat context with the public repo state, the Gmail Sorter benchmark, and the remaining planner/deepseek benchmark gaps.

### 🧹 Repo Hygiene

- Kept generated benchmark summaries small and human-readable, while leaving private prompts, per-message results, logs, and mailbox metadata out of Git.

## 0.2.0 - 2026-07-05

### ✨ GitHub Makeover

- Added a generated README hero image at `assets/local-ai-stack-hero.png`.
- Added emoji section markers, clearer model-role tables, and direct links to decision/cleanup docs.
- Added Mermaid diagrams for planner → implementer → reasoning fallback flow.

### 🧠 Model Stack Decisions

- Made Qwen3.6-35B-A3B-MTP the primary local implementer because the old Qwen3/Qwen14 direction was no longer bleeding edge enough for this stack.
- Limited Qwen3.6 to two active profiles: `qwen36` for full-context work and `qwen36-fast` for quick work.
- Confirmed the DeepSeek fallback moved to DeepSeek-R1-Distill-Qwen-32B, replacing the earlier smaller fallback direction.
- Chose Gemma 4 as the third-slot planner family because the user wanted a non-Qwen/non-DeepSeek model for planning, reasoning, and architecture.
- Confirmed Gemma 4 is not only a 12B instruction model: the family includes 12B, 26B A4B MoE, and 31B dense variants.
- Set `planner` / `gemma4-26b` to the official `gemma-4-26B-A4B-it-Q4_K_M.gguf` filename.
- Set `planner-safe` / `gemma4-12b` to the official `gemma-4-12B-it-Q4_K_M.gguf` filename.
- Installed `gemma-4-26B-A4B-it-Q4_K_M.gguf` and `gemma-4-12B-it-Q4_K_M.gguf`; both still need local fit benchmarks.
- Updated `aider-openrouter` to default to `google/gemma-4-31b-it` through OpenRouter, overrideable with `OPENROUTER_AIDER_MODEL`.

### 🧹 Cleanup

- Removed stale Qwen 14B and `coder-big` workflow references from helper scripts and docs.
- Added `docs/09-DECISION-LOG.md` with the questions asked and decisions made.
- Added `docs/10-CLEANUP-LOG-2026-07-05.md` documenting local cleanup policy and removed artifacts.
- Kept `local-llm.service` disabled by default so models only run when explicitly started.

## 0.1.0 - 2026-07-05

- Added the first local AI coding stack docs for the CachyOS/fish/RTX 4070 Super-class setup.
- Added `.env.example` and `.gitignore` so keys, model files, caches, virtualenvs, and generated reports had a safe home outside Git from day one.
- Added helper commands for the local llama.cpp workflow: `dev-ai`, `llm-switch`, `llm-stop`, `llm-status`, `llm-logs`, and `llm-test`.
- Added Aider wrappers for local and OpenRouter-backed coding sessions.
- Added OpenCode/OpenRouter setup wrappers and notes so Codex, Aider, and OpenCode could be tested side by side.
- Added setup checking and cleanup scripts for local machine hygiene.
- Added the first benchmark CSV, `benchmarks/local-ai-final-benchmark.csv`, with coder/deepseek/qwen14 speed and fit checks that later informed the move to Qwen3.6 and DeepSeek 32B.
- Added setup-report and next-chat handoff files so the stack could be rebuilt or continued without relying on memory.
