#!/bin/bash

USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)
DOTFILES_DIR="$USER_HOME/dotfiles"

ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/p10k.zsh" ~/.p10k.zsh

mkdir -p ~/.config/kitty
ln -sf "$DOTFILES_DIR/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
