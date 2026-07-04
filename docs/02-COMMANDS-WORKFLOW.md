# Commands Workflow

## Local Coding

```fish
cd ~/projects/llm-test-project
dev-ai coder test.py
```

Use `dev-ai coder` for daily coding. It switches the local service to the optimized Qwen3-Coder profile, waits for `http://127.0.0.1:8080/v1/models`, and launches Aider.

## Larger Context

```fish
dev-ai big test.py
```

This uses `coder-big` with 16384 context, q4_0 KV cache, batch 256, and ubatch 64.

## Fallbacks

```fish
dev-ai deepseek test.py
```

Use for reasoning/debugging fallback.

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
