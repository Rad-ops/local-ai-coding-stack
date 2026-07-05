# Guide How To Use

Run commands from a fish shell.

## Local Aider Through llama.cpp

```fish
cd ~/projects/llm-test-project
dev-ai coder test.py
```

```fish
dev-ai big test.py
```

```fish
dev-ai deepseek test.py
```

```fish
dev-ai qwen14 test.py
```

```fish
dev-ai status
```

```fish
dev-ai stop
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
