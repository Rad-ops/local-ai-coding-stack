# Private Repo Notes

## Repo Name

```text
local-ai-coding-stack
```

## GitHub Remote URL

https://github.com/Rad-ops/local-ai-coding-stack

HTTPS remote:

```text
https://github.com/Rad-ops/local-ai-coding-stack.git
```

## Privacy

Created as a private GitHub repo and pushed to origin/main.

## Push Status

Initial commit pushed to `origin/main`.

## What Was Committed

- Markdown documentation
- Safe helper scripts
- Benchmark CSV
- `.gitignore`
- `.env.example`
- Example setup report placeholder

## What Was Intentionally Excluded

- OpenRouter keys
- `.env`
- GGUF model files
- `~/ai/models`
- `~/.config`
- `~/.local/share/opencode/auth.json`
- caches
- virtualenvs
- generated local reports
- logs

## Push Future Updates

To create the repo from a fresh checkout if needed:

```fish
gh auth login -h github.com
cd ~/ai/local-ai-stack
gh repo create local-ai-coding-stack --private --source=. --remote=origin --push
```

If the repo already exists:

```fish
cd ~/ai/local-ai-stack
git remote add origin https://github.com/Rad-ops/local-ai-coding-stack.git
git push -u origin main
```

For later updates:

```fish
cd ~/ai/local-ai-stack
git status --short
git add .
git commit -m "Update local AI coding stack"
git push
```
