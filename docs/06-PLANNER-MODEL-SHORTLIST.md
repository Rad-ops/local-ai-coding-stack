# 🏗️ Planner Model Shortlist

*Updated: 2026-07-05*

The third local model is for **planning, architecture, and multi-step
reasoning** — not for implementation. Qwen3.6 and DeepSeek remain the
implementer and the reasoning/debugging models.

Gemma 4 is not just a 12B model. The current family includes
Gemma 4 12B (dense), Gemma 4 26B A4B (MoE), and Gemma 4 31B (dense).
The 26B MoE is the preferred first test: larger than 12B without being
fully dense at inference time, since it activates only ~3.8B parameters
per token. The 31B dense model is a cloud / future-hardware option.

```mermaid
flowchart TD
  A[Architecture question] --> B[planner / gemma4-26b]
  B --> C[Plan, risks, test strategy]
  C --> D[qwen36 implements]
  D --> E[deepseek cross-checks hard reasoning]
  E --> F[Codex edits and verifies repo]
  B -->|VRAM too tight| G[planner-safe / gemma4-12b]
```

## Ranked candidates

| Rank | Model | Role | Notes |
| ---: | --- | --- | --- |
| 1 | **Gemma 4 26B MoE Instruct** | Preferred local planner target | April 2026 MoE model, built for advanced reasoning and agentic workflows. The official GGUF Q4_K_M is about 16.8 GB; benchmark at 8K context before relying on it. |
| 2 | Gemma 4 12B Instruct | Safer local planner fallback | June 2026 model, easier to fit locally than the 26B MoE. |
| 3 | Gemma 4 31B Dense | Cloud or future-hardware planner | Best dense Gemma 4 quality target, but too large for 12 GB VRAM. |
| 4 | Mistral Small 4 | Cloud or future-hardware planner | March 2026 open model unifying instruct, reasoning, and coding, 256K context, but 119B total parameters is unrealistic on 12 GB. |
| 5 | Mistral Medium 3.5 | Cloud architect | April 2026 frontier-class model optimized for agentic and coding use cases; use through API/OpenRouter, not local 12 GB. |
| 6 | Phi-4-reasoning-plus | Older local reasoning fallback | 14B MIT-licensed model explicitly trained for reasoning, planning, and code. April 2025 — kept as compatibility fallback, not bleeding edge. |

## Current decision

Try **Gemma 4 26B MoE** first as `planner` / `gemma4-26b`.

Installed path:

```text
~/ai/models/gemma4-26b-moe/gemma-4-26B-A4B-it-Q4_K_M.gguf
```

Fallback path:

```text
~/ai/models/gemma4-12b/gemma-4-12B-it-Q4_K_M.gguf
```

Start conservative:

```text
ctx      8192
KV cache q4_0
batch    256
ubatch   64
temp     0.6
top_p    0.95
```

## Operating flow

Use the planner only when it adds value:

```fish
dev-ai planner file.py
```

If the 26B MoE profile does not fit:

```fish
dev-ai planner-safe file.py
```

For a server-only start (no Aider):

```fish
llm-switch planner
```

Stop when planning is done:

```fish
dev-ai stop
```

or:

```fish
llm-stop
```

## Sources

- Gemma 4 announcement: <https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/>
- Gemma 4 12B announcement: <https://blog.google/innovation-and-ai/technology/developers-tools/introducing-gemma-4-12B/>
- Mistral model overview: <https://docs.mistral.ai/models/overview>
- Mistral Small 4: <https://docs.mistral.ai/models/model-cards/mistral-small-4-0-26-03>
- Mistral Medium 3.5: <https://docs.mistral.ai/models/model-cards/mistral-medium-3-5-26-04>
- Phi-4-reasoning-plus: <https://huggingface.co/microsoft/Phi-4-reasoning-plus>
