#!/bin/bash
set -euxo pipefail

USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)
DOTFILES_DIR="$USER_HOME/dotfiles"

sudo mkdir -p /usr/share/fonts
sudo cp "$DOTFILES_DIR"/fonts/*.ttf /usr/share/fonts/
sudo fc-cache -f