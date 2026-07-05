# Commands Workflow

## Local Coding

```fish
cd ~/projects/llm-test-project
dev-ai coder test.py
```

Use `dev-ai coder` for daily coding. It is a compatibility alias for the optimized Qwen3.6 profile, waits for `http://127.0.0.1:8080/v1/models`, and launches Aider.

## Larger Context

```fish
dev-ai big test.py
```

This uses the Qwen3.6 large-context profile through the legacy `big` alias.

## Qwen3.6

```fish
dev-ai qwen36 test.py
dev-ai qwen36-big test.py
```

Use `qwen36` for the upgraded Qwen3.6-35B-A3B-MTP local model. Use `qwen36-fast` for quicker smaller-context work.

## Fallbacks

```fish
dev-ai deepseek test.py
```

Use for DeepSeek-R1-Distill-Qwen-32B reasoning/debugging fallback.

```fish
dev-ai qwen14 test.py
```

Use as a general fallback.

## Service Commands

```fish
dev-ai status
dev-ai stop
dev-ai logs
```

`dev-ai stop` should be run when finished to free VRAM.

## Aider Commands

Inside Aider:

```text
/add file.py
/undo
/exit
```

## OpenRouter Commands

```fish
aider-openrouter test.py
opencode-openrouter
```

Inside OpenCode:

```text
/connect
/models
```
