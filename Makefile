.PHONY: all binaries nvim zoxide fzf bat eza difftastic stow git-status

FOLDERS = bash tmux ghostty nvim git rofi
LOCAL_BIN := $(HOME)/.local/bin

all: git-status binaries stow

# ------------------------------------------------------------
# Git status warning
# ------------------------------------------------------------
git-status:
	@if ! git diff --quiet 2>/dev/null || \
	    ! git diff --cached --quiet 2>/dev/null || \
	    [ -n "$$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then \
		echo "--- Warning: uncommitted changes ---"; \
		git status --short; \
		echo "  Symlinks will point to these uncommitted files."; \
		echo "  Commit when ready to persist your changes."; \
		echo ""; \
	fi
	@git fetch > /dev/null 2>&1 || true
	@if git rev-parse --abbrev-ref '@{u}' > /dev/null 2>&1; then \
		LOCAL=$$(git rev-parse @) && \
		REMOTE=$$(git rev-parse '@{u}') && \
		if [ "$$LOCAL" != "$$REMOTE" ]; then \
			echo "--- Warning: out of sync with remote ---"; \
			echo "  Run 'git pull' or 'git push' when ready."; \
			echo ""; \
		fi; \
	fi

# ------------------------------------------------------------
# Binaries
# ------------------------------------------------------------
binaries: nvim zoxide fzf bat eza difftastic

nvim:
	@if [ -f $(HOME)/.nvim/root/usr/bin/nvim ]; then \
		echo "neovim already installed, skipping."; \
	else \
		echo "[install] neovim"; \
		mkdir -p $(HOME)/.nvim; \
		URL=$$(curl -sL https://api.github.com/repos/neovim/neovim/releases/latest \
			| grep -oP '"browser_download_url": "\K[^"]*linux-x86_64\.appimage' | head -1); \
		curl -sL "$$URL" -o $(HOME)/.nvim/nvim.appimage; \
		if [ "$$(stat -c%s $(HOME)/.nvim/nvim.appimage)" -lt 1048576 ]; then \
			echo "Error: neovim download failed."; \
			rm -f $(HOME)/.nvim/nvim.appimage; \
			exit 1; \
		fi; \
		chmod +x $(HOME)/.nvim/nvim.appimage; \
		cd $(HOME)/.nvim && ./nvim.appimage --appimage-extract; \
		rm -f $(HOME)/.nvim/nvim.appimage; \
		mv $(HOME)/.nvim/squashfs-root $(HOME)/.nvim/root; \
		ln -sf $(HOME)/.nvim/root/usr/bin/nvim $(LOCAL_BIN)/nvim; \
		echo "  done."; \
	fi

zoxide:
	@if command -v zoxide > /dev/null 2>&1; then \
		echo "zoxide already installed, skipping."; \
	else \
		echo "[install] zoxide"; \
		_tmpdir=$$(mktemp -d); \
		curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh -o "$$_tmpdir/zoxide-install.sh"; \
		sh "$$_tmpdir/zoxide-install.sh"; \
		rm -rf "$$_tmpdir"; \
		echo "  done."; \
	fi

fzf:
	@if [ -d $(HOME)/.fzf ]; then \
		echo "fzf already installed, skipping."; \
	else \
		echo "[install] fzf"; \
		git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/.fzf; \
		$(HOME)/.fzf/install --all; \
		echo "  done."; \
	fi

bat:
	@if command -v bat > /dev/null 2>&1; then \
		echo "bat already installed, skipping."; \
	else \
		echo "[install] bat"; \
		URL=$$(curl -sL https://api.github.com/repos/sharkdp/bat/releases/latest \
			| grep -oP '"browser_download_url": "\K[^"]*x86_64-unknown-linux-musl[^"]*\.tar\.gz' | head -1); \
		_tmpdir=$$(mktemp -d); \
		curl -sL "$$URL" | tar -xzf - -C "$$_tmpdir"; \
		find "$$_tmpdir" -name 'bat' -type f -exec cp {} $(LOCAL_BIN)/bat \;; \
		chmod +x $(LOCAL_BIN)/bat; \
		rm -rf "$$_tmpdir"; \
		echo "  done."; \
	fi

eza:
	@if command -v eza > /dev/null 2>&1; then \
		echo "eza already installed, skipping."; \
	else \
		echo "[install] eza"; \
		URL=$$(curl -sL https://api.github.com/repos/eza-community/eza/releases/latest \
			| grep -oP '"browser_download_url": "\K[^"]*x86_64-unknown-linux-musl[^"]*\.tar\.gz' | head -1); \
		_tmpdir=$$(mktemp -d); \
		curl -sL "$$URL" | tar -xzf - -C "$$_tmpdir"; \
		find "$$_tmpdir" -name 'eza' -type f -exec cp {} $(LOCAL_BIN)/eza \;; \
		chmod +x $(LOCAL_BIN)/eza; \
		rm -rf "$$_tmpdir"; \
		echo "  done."; \
	fi

difftastic:
	@if command -v difft > /dev/null 2>&1; then \
		echo "difftastic already installed, skipping."; \
	else \
		echo "[install] difftastic"; \
		URL=$$(curl -sL https://api.github.com/repos/Wilfred/difftastic/releases/latest \
			| grep -oP '"browser_download_url": "\K[^"]*x86_64-unknown-linux-musl[^"]*\.tar\.gz' | head -1); \
		_tmpdir=$$(mktemp -d); \
		curl -sL "$$URL" | tar -xzf - -C "$$_tmpdir"; \
		find "$$_tmpdir" -name 'difft' -type f -exec cp {} $(LOCAL_BIN)/difft \;; \
		chmod +x $(LOCAL_BIN)/difft; \
		rm -rf "$$_tmpdir"; \
		echo "  done."; \
	fi

# ------------------------------------------------------------
# Stow symlinks
# ------------------------------------------------------------
stow:
	@BACKUP_DIR="$(HOME)/.dotfiles-backup/$$(date +%Y%m%d-%H%M%S)"; \
	for folder in $(FOLDERS); do \
		if stow --target="$(HOME)" --dir="$(CURDIR)" "$$folder" 2>/dev/null; then \
			continue; \
		fi; \
		CONFLICTS=$$(stow --target="$(HOME)" --dir="$(CURDIR)" "$$folder" 2>&1 \
			| grep -oP 'existing target is neither a link nor a directory: \K.*' || true); \
		if [ -z "$$CONFLICTS" ]; then \
			stow --target="$(HOME)" --dir="$(CURDIR)" "$$folder"; \
			continue; \
		fi; \
		echo "[conflict] backing up existing files for '$$folder':"; \
		mkdir -p "$$BACKUP_DIR"; \
		for file in $$CONFLICTS; do \
			dest="$(HOME)/$$file"; \
			if [ -f "$$dest" ] && [ ! -L "$$dest" ]; then \
				echo "  $$file -> $$BACKUP_DIR/"; \
				mv "$$dest" "$$BACKUP_DIR/"; \
			fi; \
		done; \
		stow --target="$(HOME)" --dir="$(CURDIR)" "$$folder"; \
	done; \
	if [ -d "$$BACKUP_DIR" ]; then \
		echo ""; \
		echo "Backed up conflicting files to: $$BACKUP_DIR"; \
		echo "Review and remove when no longer needed."; \
	fi
	@echo ""
	@echo "Done. Symlinks point to current repo state."
	@echo "Commit changes to persist them."
