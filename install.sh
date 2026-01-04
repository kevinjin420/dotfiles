#!/bin/bash
DOTFILES_DIR="$HOME/dotfiles"

mkdir -p ~/.config/kitty
ln -sf "$DOTFILES_DIR/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
