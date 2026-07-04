# Troubleshooting

## fish Shell

All user-facing scripts are fish-compatible and begin with:

```fish
#!/usr/bin/env fish
```

Set environment variables with fish syntax:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

## Avoid Bash Heredocs

Avoid Bash heredocs in instructions and scripts meant for this user environment. Use an editor, direct file edits, or a small file writer when necessary.

## CUDA OOM

Do not use:

```fish
--n-gpu-layers 999
```

The service intentionally lets llama.cpp auto-fit. If VRAM is tight:

```fish
dev-ai stop
nvidia-smi
dev-ai coder test.py
```

Use fewer files or switch from `big` to `coder`.

## API Check

```fish
curl -fsS http://127.0.0.1:8080/v1/models
```

## Logs

```fish
dev-ai logs
```

## Aider Not Seeing Files

Start from the project root and pass explicit files:

```fish
cd ~/projects/llm-test-project
dev-ai coder test.py
```

Inside Aider:

```text
/add file.py
```

## Service Autostart

Expected:

```fish
systemctl --user is-enabled local-llm
```

```text
disabled
```

## OpenRouter Safety

Do not hardcode keys. Do not commit `.env`. Keep keys in fish universal variables or another local secret store.
