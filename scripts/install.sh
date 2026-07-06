#!/usr/bin/env fish
# install.sh — copy every helper script from this repo into ~/bin/ and chmod it.
# Idempotent: safe to re-run after every `git pull`.

set SRC (dirname (status filename))
set DST "$HOME/bin"

if not test -d "$DST"
    mkdir -p "$DST"
end

set files dev-ai \
          llm-switch \
          llm-stop \
          llm-status \
          llm-logs \
          llm-test \
          aider-local \
          aider-openrouter \
          opencode-openrouter \
          setup-opencode-openrouter \
          check-local-ai-setup \
          cleanup-local-ai \
          bench-ai-final \
          bench-local-models

echo "Installing helper scripts from $SRC to $DST"
echo ""

for f in $files
    if not test -f "$SRC/$f"
        echo "  SKIP   $f  (not in $SRC)"
        continue
    end
    cp -f "$SRC/$f" "$DST/$f"
    chmod +x "$DST/$f"
    echo "  ok     $DST/$f"
end

echo ""
echo "Done. Scripts are now on PATH from $DST."
echo "Next: run 'check-local-ai-setup' to audit the install."
