#!/usr/bin/env bash
set -euo pipefail

FOLDERS="bash tmux ghostty nvim git rofi"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# ------------------------------------------------------------
# Check 1: Ensure working tree is clean (no modified, staged, or untracked files)
# ------------------------------------------------------------
if ! git -C "$SCRIPT_DIR" diff --quiet || \
   ! git -C "$SCRIPT_DIR" diff --cached --quiet || \
   [ -n "$(git -C "$SCRIPT_DIR" ls-files --others --exclude-standard)" ]; then
    echo "Error: The repository contains uncommitted changes."
    echo "Commit, stash, or restore before running this script."
    exit 1
fi

# ------------------------------------------------------------
# Check 2: Ensure repository is up-to-date with remote
# ------------------------------------------------------------
git -C "$SCRIPT_DIR" fetch > /dev/null 2>&1 || true

# If no upstream, skip remote check
if git -C "$SCRIPT_DIR" rev-parse --abbrev-ref @{u} > /dev/null 2>&1; then
    LOCAL=$(git -C "$SCRIPT_DIR" rev-parse @)
    REMOTE=$(git -C "$SCRIPT_DIR" rev-parse @{u})
    BASE=$(git -C "$SCRIPT_DIR" merge-base @ @{u})

    if [ "$LOCAL" != "$REMOTE" ]; then
        if [ "$LOCAL" = "$BASE" ]; then
            echo "Error: Local branch is behind the remote. Run: git pull"
            exit 1
        elif [ "$REMOTE" = "$BASE" ]; then
            echo "Error: Local branch is ahead of the remote. Run: git push"
            exit 1
        else
            echo "Error: Local and remote branches have diverged."
            exit 1
        fi
    fi
fi

# ------------------------------------------------------------
# Apply stow --adopt
# ------------------------------------------------------------
for folder in $FOLDERS; do
    stow --adopt --target="$HOME" --dir="$SCRIPT_DIR" "$folder"
done

# ------------------------------------------------------------
# Restore repo to clean state
# ------------------------------------------------------------
git -C "$SCRIPT_DIR" restore .

exit 0

