#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

mkdir -p "$HOME/Documents/wallpapers"
ln -sf "$DOTFILES_DIR/wallpapers/"* "$HOME/Documents/wallpapers/"
