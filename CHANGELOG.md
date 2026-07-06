# Changelog

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

- Added the initial local AI coding stack documentation, helper scripts, benchmark notes, and OpenRouter/OpenCode setup notes.
