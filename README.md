# dotfiles

This is my personal dotfiles repository, complete with ansible scripts with support for:
- macOS
- Arch, 
- Debian/Ubuntu
- Fedora

## Bootstrap

Fresh machine setup:
- installs Ansible, git
- clones this repo
- runs base playbook automatically

```sh
curl -fsSL https://dotfiles.kevinjin.dev | bash
```

To run a specific playbook manually:

```sh
./ansible.sh <playbook.yml>
# e.g. ./ansible.sh kde.yml
```

---

## Playbooks

### `local.yml`
Main setup
- Installs packages
  - zsh
  - fzf
  - neovim
  - git
  - curl
  - kitty
  - tmux
- sets zsh as default shell
- installs Oh-My-Zsh + plugins
  - autosuggestions
  - syntax-highlighting
  - powerlevel10k
- sets up LazyVim
- installs fonts
- symlinks dotfiles.

### `headless.yml`
Same as `local.yml` but without Kitty — for servers or raspis. Tmux incl. 

### `kde.yml`
KDE Plasma setup. Applies kwin settings, installs my own desktop-status-bar plasmoid, sets the AritimDark color scheme, and deploys plasma applet config
Requires `kwriteconfig6`, aka only plasma 6 wayland compatible

### `macos.yml`
macOS extras. Still WIP and tuning

### `macos-aerospace.yml`
Alternative macOS window management using Aerospace (tiling WM) + a custom alt-tab fork for per-workspace alt-tab. Builds and installs AltTab from source.

### `macos-iss.yml`
Lighter macOS desktop switching using instant-space-switcher + Rectangle. No tiling WM.

### `rime.yml`
Sets up fcitx5 + Rime Chinese input method. Installs Qt/GTK frontends for the detected distro.

### `agent.yml`
Symlinks `CLAUDE.md` to `~/.claude/CLAUDE.md` and `universal.md` to `~/.cursor/rules/universal.md` for AI coding assistant config.

---

## What's symlinked

| File | Target |
|------|--------|
| `dots/zshrc` | `~/.zshrc` |
| `dots/p10k.zsh` | `~/.p10k.zsh` |
| `dots/gitconfig` | `~/.gitconfig` |
| `dots/always_forget.md` | `~/always-forget.md` |
| `config/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
