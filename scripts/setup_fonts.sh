#!/bin/bash
set -euxo pipefail

sudo -v

DOTFILES_DIR="$HOME/dotfiles"

sudo mkdir -p /usr/share/fonts
sudo cp "$DOTFILES_DIR"/fonts/*.ttf /usr/share/fonts/
sudo fc-cache -f