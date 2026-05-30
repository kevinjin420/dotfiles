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
  - git
  - curl
  - kitty
  - tmux
- sets zsh as default shell
- installs Oh-My-Zsh + plugins
  - autosuggestions
  - syntax-highlighting
  - powerlevel10k
- sets up LazyVim (skipped if `~/.config/nvim` already exists)
- installs fonts
- symlinks dotfiles
- installs udev rules for embedded dev boards (Linux only)

### `headless.yml`
Same as `local.yml` but without Kitty

For servers or raspis. Tmux incl. 

### `kde.yml`
KDE Plasma setup. Applies kwin settings, installs my own desktop-status-bar plasmoid, sets the AritimDark color scheme, and deploys plasma applet config

Requires `kwriteconfig6`, aka only plasma 6 wayland compatible

### `macos-aerospace.yml` ← macOS flagship
Full macOS window management setup:
- **Aerospace** — tiling WM with named workspaces
  - `alt-#` to switch workspace, `alt-shift-#` to move window
- **AltTab fork** ([kevinjin420/alt-tab-macos](https://github.com/kevinjin420/alt-tab-macos)) — per-workspace alt-tab, downloaded from pre-built GitHub releases
- **Rectangle** — window snapping

### `macos.yml`
Minimal macOS extras: instant-space-switcher + Rectangle. No tiling WM.

### `macos-iss.yml`
Dead-end path — kept for reference. instant-space-switcher with native macOS Spaces. Window-move-to-space is broken on macOS 26+ (private API removed).

### `rime.yml`
Sets up fcitx5 + Rime Chinese input method. Installs Qt/GTK frontends for the detected distro.

### `agent.yml`
Symlinks `CLAUDE.md` to `~/.claude/CLAUDE.md` and `universal.md` to `~/.cursor/rules/universal.md` for AI coding assistant config.

---

## udev rules

Tracked in `udev/rules.d/` and symlinked into `/etc/udev/rules.d/` by `local.yml` on Linux.

| File | Device |
|------|--------|
| `49-stlinkv1.rules` | STM32VL discovery (ST-Link v1) |
| `49-stlinkv2-1.rules` | STM32 Nucleo (ST-Link v2-1) |
| `49-stlinkv2.rules` | STM32 discovery (ST-Link v2) |
| `49-stlinkv3.rules` | ST-Link v3 |
| `50-programmer_usb.rules` | FTDI FT2232 programmer, custom vendor 33aa |
| `50-stm32_dfu.rules` | STM32 DFU mode |
| `52-digilent-usb.rules` | Digilent FPGA/USB |
| `99-jlink.rules` | SEGGER J-Link + CMSIS-DAP |
| `99-SaleaeLogic.rules` | Saleae Logic analyzers |

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
