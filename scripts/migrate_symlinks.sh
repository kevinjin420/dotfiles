#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

ln -sf "$DOTFILES_DIR/dots/zshrc"           "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/dots/p10k.zsh"        "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/dots/gitconfig"       "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/dots/always_forget.md" "$HOME/always-forget.md"

echo "Symlinks updated"
