# ⌨️ Commands

The single canonical cheatsheet for the helper scripts. Every command
assumes `scripts/install.sh` has been run (so the scripts are in
`~/bin/` and on `$PATH`).

## Profile → command

| I want to… | Run |
| --- | --- |
| Use the default Qwen3.6 profile (128K context) | `dev-ai coder file.py` |
| Use the same Qwen3.6 profile, by its real name | `dev-ai qwen36 file.py` |
| Use the quick Qwen3.6 profile (32K context) | `dev-ai qwen36-fast file.py` |
| Switch to the DeepSeek reasoning fallback | `dev-ai deepseek file.py` |
| Switch to the Gemma 4 26B planner | `dev-ai planner file.py` |
| Switch to the Gemma 4 12B planner-safe | `dev-ai planner-safe file.py` |

Each `dev-ai <profile> [files...]` calls `llm-switch <profile>`,
waits for `http://127.0.0.1:8080/v1/models` to respond, and launches
`aider --model openai/local` with the given files.

`coder` and `qwen36` are the same profile. `fast`, `coder-fast`, and
`qwen36-fast` are the same profile. The aliases are kept for
backwards-compatibility and brevity.

## Server-only control (no Aider)

```fish
llm-switch planner           # start a profile, wait for API, print GPU stats
llm-status                   # service, current config, GPU, /v1/models
llm-stop                     # systemctl --user stop local-llm
llm-logs                     # journalctl --user -u local-llm -f
llm-test                     # curl a tiny Python function request
```

Aliases:

```fish
dev-ai status                # same as llm-status
dev-ai stop                  # same as llm-stop
dev-ai logs                  # same as llm-logs
```

## Cloud escape hatch (OpenRouter)

```fish
# Set once, persists in fish universal variables
set -Ux OPENROUTER_API_KEY "paste_key_here"

# Aider through OpenRouter (default model: google/gemma-4-31b-it)
aider-openrouter file.py
# Override the model for one session
OPENROUTER_AIDER_MODEL="anthropic/claude-sonnet-4-5" aider-openrouter file.py

# OpenCode (optional second CLI agent) through OpenRouter
opencode-openrouter
# Inside OpenCode: /connect, then /models
```

If `OPENROUTER_API_KEY` is missing, `aider-openrouter` and
`opencode-openrouter` exit with a clear error.

## Aider in-REPL

```text
/add file.py
/drop file.py
/undo
/ls
/diff
/commit
/exit
```

## Audit & cleanup

```fish
check-local-ai-setup                  # writes ~/local-ai-setup-report.txt
cat ~/local-ai-setup-report.txt       # read the report (gitignored)

cleanup-local-ai --dry-run            # show what would be removed
cleanup-local-ai --apply              # stop+disable local-llm, remove stale items
```

`cleanup-local-ai` will never touch:

- `~/ai/models`
- `~/ai/llama.cpp`
- `~/ai/local-ai-stack`
- Any `*.gguf` file

## Benchmarking

```fish
bench-local-models                    # quick per-model fit checks
bench-ai-final                        # the longer end-to-end benchmark
```

Both write their results to `~/local-ai-benchmark-results.csv` and
`~/local-ai-final-benchmark.csv` (gitignored). They are kept for
reproducing the numbers in `docs/09-BENCHMARKS-AND-WORKLOADS.md`.
