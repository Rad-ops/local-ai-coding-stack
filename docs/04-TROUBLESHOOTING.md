# 🩹 Troubleshooting

## Shell is fish

All helper scripts use fish syntax. Set persistent env vars with:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

Avoid Bash heredocs (`<<EOF … EOF`) in user-facing instructions; the
fish parser treats them differently. Use an editor or a small file
writer instead.

## CUDA out-of-memory

Do not use `--n-gpu-layers 999`. The profiles let llama.cpp auto-fit
the working set to 12 GB VRAM.

If you still hit OOM:

```fish
dev-ai stop
nvidia-smi
dev-ai qwen36-fast file.py   # smaller context instead of qwen36
```

If the 26B MoE planner OOMs:

```fish
dev-ai planner-safe file.py  # falls back to Gemma 4 12B
```

## API not responding

```fish
curl -fsS http://127.0.0.1:8080/v1/models
```

If it fails:

```fish
llm-status
llm-logs
```

Most often: the previous `llm-switch` is still loading, or the
service crashed. `llm-logs` shows the most recent llama.cpp output.

## Aider does not see the file

Start from the project root and pass the file explicitly:

```fish
cd ~/projects/llm-test-project
dev-ai coder test.py
```

Inside Aider:

```text
/add test.py
/ls
```

## Service autostart

`local-llm.service` must stay **disabled** at login so the GPU is not
auto-claimed. Verify:

```fish
systemctl --user is-enabled local-llm
```

Expect:

```text
disabled
```

If it shows `enabled`:

```fish
systemctl --user disable local-llm
```

## OpenRouter key

The key must never be committed. Check it is set without printing it:

```fish
set -q OPENROUTER_API_KEY; and echo set; or echo missing
```

If missing:

```fish
set -Ux OPENROUTER_API_KEY "paste_key_here"
```

## Audit the install

```fish
check-local-ai-setup
cat ~/local-ai-setup-report.txt
```

The report is gitignored because it contains local paths, runtime
state, and machine-specific details.

## Cleanup

```fish
cleanup-local-ai --dry-run     # preview
cleanup-local-ai --apply       # stop+disable service, remove stale items
```

`cleanup-local-ai` will never touch `~/ai/models`, `~/ai/llama.cpp`,
`~/ai/local-ai-stack`, or any `*.gguf` file.
