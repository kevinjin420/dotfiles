#!/bin/bash

USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)
DOTFILES_DIR="$USER_HOME/dotfiles"

mkdir -p "$USER_HOME/Documents/wallpapers"
ln -sf "$DOTFILES_DIR/wallpapers/"* "$USER_HOME/Documents/wallpapers/"
