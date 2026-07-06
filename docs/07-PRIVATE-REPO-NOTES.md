# GitHub Repo Notes

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

Created as a private GitHub repo first, then made public after the local cleanup pass removed generated reports, model binaries, local auth, and machine-specific files. The public URL is:

```text
https://github.com/Rad-ops/local-ai-coding-stack
```

## Push Status

Current documentation and scripts are pushed to `origin/main`.

## What Was Committed

- Markdown documentation
- Safe helper scripts
- Benchmark CSV
- `.gitignore`
- `.env.example`
- Example setup report placeholder

## What Was Intentionally Excluded

- OpenRouter keys, `.env`, and token files stay local because they can open paid accounts or personal services.
- GGUF model files and `~/ai/models` stay local because they are large upstream artifacts, not source code.
- `~/.config` stays out because it is a whole-machine configuration tree. When a setting matters, document the exact setting instead of committing the directory.
- `~/.local/share/opencode/auth.json` stays local because it is OpenCode login/session state.
- Caches, virtualenvs, reports, and logs stay out because they are rebuildable and often contain local paths, prompts, timings, or machine-only details.

## Push Future Updates

To create a private fork from a fresh checkout if needed:

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
