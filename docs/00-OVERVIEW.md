# 📍 Overview

This is the personal reference for my local AI coding stack on CachyOS
Linux: a 12 GB VRAM box running `llama-server` against local GGUF models,
with Aider as the primary coding agent, Codex for structured repo work,
and OpenRouter as the cloud fallback.

The repo exists so a future me (or a new chat session) can rebuild the
stack from scratch without rediscovering the model paths, profile
settings, and known gotchas.

## File map

```text
~/ai/local-ai-stack/
├── README.md                              # the only entry point — start here
├── CHANGELOG.md                           # version history
├── VERSION                                # current version (single line)
├── LICENSE                                # MIT
├── .env.example                           # template for env vars; never commit .env
├── .gitignore                             # strict: keys, models, reports, venvs stay out
├── assets/
│   └── local-ai-stack-hero.png            # decorative hero image
├── benchmarks/
│   ├── local-ai-final-benchmark.csv       # synthetic Qwen3.6 probes
│   ├── gmail-sorter-local-llm-summary-2026-07-05.csv  # the real workload
│   └── legacy-local-fit-checks-2026-07-04.csv         # historical fit checks
├── docs/                                  # everything else, in reading order
│   ├── 00-OVERVIEW.md                     # this file
│   ├── 01-INSTALL.md                      # full install from scratch
│   ├── 02-MODELS-AND-PROFILES.md          # hardware, GGUF paths, 5 profiles
│   ├── 03-COMMANDS.md                     # daily command cheatsheet
│   ├── 04-TROUBLESHOOTING.md              # OOM, API down, Aider not seeing files
│   ├── 05-OPENROUTER-AND-OPENCODE.md      # cloud path (optional second agent)
│   ├── 06-PLANNER-MODEL-SHORTLIST.md      # Gemma 4 / Mistral / Phi-4 research
│   ├── 07-DECISION-LOG.md                 # the Q&A trail that shaped the stack
│   ├── 08-CLEANUP-LOG-2026-07-05.md       # one-time cleanup snapshot
│   ├── 09-BENCHMARKS-AND-WORKLOADS.md     # the real benchmark writeup
│   └── 10-CONTINUATION-HANDOFF.md         # the ONLY handoff file — paste this
└── scripts/                               # fish scripts, install into ~/bin/
    ├── install.sh                         # one-shot installer
    ├── dev-ai                            # profile → llm-switch + aider-local
    ├── llm-switch                        # restart local-llm with chosen profile
    ├── llm-stop, llm-status, llm-logs, llm-test
    ├── aider-local, aider-openrouter
    ├── opencode-openrouter, setup-opencode-openrouter
    ├── check-local-ai-setup              # writes ~/local-ai-setup-report.txt
    ├── cleanup-local-ai                  # --dry-run / --apply
    ├── bench-ai-final                    # benchmark runner
    └── bench-local-models                # earlier benchmark runner (kept for history)
```

## Reading order

If you are rebuilding the stack from scratch:

1. `README.md` — what this is
2. `docs/01-INSTALL.md` — full install
3. `docs/02-MODELS-AND-PROFILES.md` — what each model slot is
4. `docs/03-COMMANDS.md` — how to drive it day to day
5. `docs/04-TROUBLESHOOTING.md` — when things go wrong

If you are continuing an existing setup or starting a new chat session:

- `docs/10-CONTINUATION-HANDOFF.md` — paste this and you're done.

If you want to understand *why* the stack looks the way it does:

- `docs/07-DECISION-LOG.md` — the questions and answers
- `docs/06-PLANNER-MODEL-SHORTLIST.md` — the planner research
- `docs/09-BENCHMARKS-AND-WORKLOADS.md` — the numbers behind the choices
- `docs/08-CLEANUP-LOG-2026-07-05.md` — what was removed and why
