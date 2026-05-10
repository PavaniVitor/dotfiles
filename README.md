# dotfiles

### prerequisites

- stow (`sudo pacman -S stow`)
- curl, git

### usage

```
make          # install everything (binaries + stow)
make binaries # install nvim, zoxide, fzf, bat, eza, difftastic
make nvim     # install neovim only
make stow     # create symlinks via stow
```

Binaries are installed to `~/.local/bin`. Neovim config uses `NVIM_APPNAME=pavani`.

### portable setup

On another user's machine, run `make nvim` to install your config alongside theirs. Their default neovim config is not affected.

To use your config over SSH:
```
NVIM_APPNAME=pavani nvim
```
Or add to your `~/.ssh/config`:
```
Host some-host
    SetEnv NVIM_APPNAME=pavani
```
