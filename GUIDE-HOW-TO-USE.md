# Guide How To Use

Run commands from a fish shell.

## Local Aider Through llama.cpp

```fish
cd ~/projects/llm-test-project
dev-ai coder test.py
```

```fish
dev-ai qwen36-fast test.py
```

```fish
dev-ai deepseek test.py
```

```fish
dev-ai planner test.py
```

```fish
dev-ai planner-safe test.py
```

Use `planner` only for architecture, planning, risk review, and test strategy. It starts the Gemma 4 26B MoE profile when that GGUF is installed. Use `planner-safe` if the 26B MoE profile does not fit or is unstable.

Direct start without Aider:

```fish
llm-switch planner
```

Check server state:

```fish
llm-status
```

```fish
dev-ai status
```

```fish
dev-ai stop
```

Stop the local model after planning or coding so VRAM is free:

```fish
llm-stop
```

```fish
dev-ai logs
```

Direct local Aider launcher:

```fish
aider-local test.py
```

## Aider Through OpenRouter

```fish
aider-openrouter test.py
```

This requires:

```fish
set -q OPENROUTER_API_KEY; and echo set; or echo missing
```

If missing:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

## OpenCode Through OpenRouter

Check setup:

```fish
setup-opencode-openrouter
```

Launch:

```fish
opencode-openrouter
```

Inside OpenCode:

```text
/connect
/models
```

## Aider Commands

Inside Aider:

```text
/add file.py
/undo
/exit
```

## Audit And Cleanup

```fish
check-local-ai-setup
```

```fish
cat ~/local-ai-setup-report.txt
```

```fish
cleanup-local-ai --dry-run
```

```fish
cleanup-local-ai --apply
```

`cleanup-local-ai --apply` stops and disables `local-llm`, removes only allowed stale files, and must not delete active model directories.
