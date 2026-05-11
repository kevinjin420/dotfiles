#!/bin/bash
set -euxo pipefail

DOTFILES_DIR="$HOME/dotfiles"

if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
    mkdir -p "$FONT_DIR"
    cp "$DOTFILES_DIR"/fonts/*.ttf "$FONT_DIR/"
else
    sudo -v
    sudo mkdir -p /usr/share/fonts
    sudo cp "$DOTFILES_DIR"/fonts/*.ttf /usr/share/fonts/
    sudo fc-cache -f
fi
