#!/usr/bin/env bash
set -euo pipefail

FOLDERS="bash tmux ghostty nvim git rofi"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
LOCAL_BIN="$HOME/.local/bin"

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
# Install binaries to userspace (idempotent)
# ------------------------------------------------------------
install_binaries() {
    mkdir -p "$LOCAL_BIN"

    # --- neovim (AppImage -> ~/.nvim/) ---
    if [ ! -f "$HOME/.nvim/AppRun" ] || [ "$(stat -c%s "$HOME/.nvim/AppRun" 2>/dev/null)" -lt 1048576 ]; then
        echo "Installing neovim..."
        mkdir -p "$HOME/.nvim"
        NVIM_URL=$(curl -sL https://api.github.com/repos/neovim/neovim/releases/latest \
            | grep -oP '"browser_download_url": "\K[^"]*linux-x86_64\.appimage' | head -1)
        curl -sL "$NVIM_URL" -o "$HOME/.nvim/AppRun"
        if [ "$(stat -c%s "$HOME/.nvim/AppRun")" -lt 1048576 ]; then
            echo "Error: neovim download failed (file too small)."
            rm -f "$HOME/.nvim/AppRun"
            return 1
        fi
        chmod +x "$HOME/.nvim/AppRun"
        ln -sf "$HOME/.nvim/AppRun" "$LOCAL_BIN/nvim"
        echo "neovim installed."
    else
        echo "neovim already installed, skipping."
    fi

    # --- zoxide ---
    if ! command -v zoxide > /dev/null 2>&1; then
        echo "Installing zoxide..."
        _tmpdir=$(mktemp -d)
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh -o "$_tmpdir/zoxide-install.sh"
        sh "$_tmpdir/zoxide-install.sh"
        rm -rf "$_tmpdir"
        echo "zoxide installed."
    else
        echo "zoxide already installed, skipping."
    fi

    # --- fzf ---
    if [ ! -d "$HOME/.fzf" ]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --all
        echo "fzf installed."
    else
        echo "fzf already installed, skipping."
    fi

    # --- bat ---
    if ! command -v bat > /dev/null 2>&1; then
        echo "Installing bat..."
        BAT_URL=$(curl -sL https://api.github.com/repos/sharkdp/bat/releases/latest \
            | grep -oP '"browser_download_url": "\K[^"]*x86_64-unknown-linux-musl[^"]*\.tar\.gz' | head -1)
        _tmpdir=$(mktemp -d)
        curl -sL "$BAT_URL" | tar -xzf - -C "$_tmpdir"
        find "$_tmpdir" -name 'bat' -type f -exec cp {} "$LOCAL_BIN/bat" \;
        chmod +x "$LOCAL_BIN/bat"
        rm -rf "$_tmpdir"
        echo "bat installed."
    else
        echo "bat already installed, skipping."
    fi

    # --- eza ---
    if ! command -v eza > /dev/null 2>&1; then
        echo "Installing eza..."
        EZA_URL=$(curl -sL https://api.github.com/repos/eza-community/eza/releases/latest \
            | grep -oP '"browser_download_url": "\K[^"]*x86_64-unknown-linux-musl[^"]*\.tar\.gz' | head -1)
        _tmpdir=$(mktemp -d)
        curl -sL "$EZA_URL" | tar -xzf - -C "$_tmpdir"
        find "$_tmpdir" -name 'eza' -type f -exec cp {} "$LOCAL_BIN/eza" \;
        chmod +x "$LOCAL_BIN/eza"
        rm -rf "$_tmpdir"
        echo "eza installed."
    else
        echo "eza already installed, skipping."
    fi

    # --- difftastic ---
    if ! command -v difft > /dev/null 2>&1; then
        echo "Installing difftastic..."
        DIFFT_URL=$(curl -sL https://api.github.com/repos/Wilfred/difftastic/releases/latest \
            | grep -oP '"browser_download_url": "\K[^"]*x86_64-unknown-linux-musl[^"]*\.tar\.gz' | head -1)
        _tmpdir=$(mktemp -d)
        curl -sL "$DIFFT_URL" | tar -xzf - -C "$_tmpdir"
        find "$_tmpdir" -name 'difft' -type f -exec cp {} "$LOCAL_BIN/difft" \;
        chmod +x "$LOCAL_BIN/difft"
        rm -rf "$_tmpdir"
        echo "difftastic installed."
    else
        echo "difftastic already installed, skipping."
    fi
}

install_binaries

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

