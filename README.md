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
  - `ctrl-alt-←/→` snap focused window to left/right half, `ctrl-alt-↑` tile (maximize if alone), `ctrl-alt-↓` untile back to floating
  - Chrome + VSCode auto-tile; everything else (terminals, chat) floats with normal drag-drop
- **AltTab fork** ([kevinjin420/alt-tab-macos](https://github.com/kevinjin420/alt-tab-macos)) — per-workspace alt-tab, downloaded from pre-built GitHub releases

Snapping uses Aerospace's native tiling so positions survive workspace switches. No Rectangle (see `macos-aerospace-rectangle.yml`).

### `macos-aerospace-rectangle.yml`
Legacy variant of the flagship: same Aerospace + AltTab fork, but every window floats and snapping is done by **Rectangle** instead of native tiling (config: `config/aerospace/aerospace-rectangle.toml`). Kept for reference — Rectangle-snapped floating windows get re-centered when Aerospace hides/restores them across workspace switches, which is why the flagship moved to native tiling.

### `macos.yml`
Minimal macOS extras: instant-space-switcher + Rectangle. No tiling WM.

### `macos-iss.yml` — native Spaces
Native macOS Spaces as virtual desktops, no tiling WM. Positions never drift (macOS owns the Spaces) and Rectangle snapping is conflict-free.
- **instant-space-switcher** — removes the Space-switch animation
- **Rectangle** — left/right half snapping
- **Hammerspoon** — `ctrl-shift-#` moves the focused window to Desktop N via a SIP-free synthetic "grab + switch Space" gesture, replacing the move-to-space private API that broke on macOS 15+

Manual per-machine setup (not automatable):
- Keyboard → Shortcuts → Mission Control: set **Switch to Desktop 1–9** to **Option+1–9** (`alt-#`)
- Mission Control: turn **off** "Automatically rearrange Spaces", and pre-create 9 desktops

Caveats: desktops are positional (fullscreening an app inserts a Space and shifts the numbering); the move gesture flickers the cursor, follows the window to the destination, and only works on windows with a grabbable title bar.

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
| `config/fastfetch/config.jsonc` | `~/.config/fastfetch/config.jsonc` |
| `config/fastfetch/kuromi.txt` | `~/.config/fastfetch/kuromi.txt` |
