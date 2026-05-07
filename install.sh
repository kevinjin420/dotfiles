#!/bin/bash

USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)
DOTFILES_DIR="$USER_HOME/dotfiles"

ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/p10k.zsh" ~/.p10k.zsh
ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/always_forget.md" ~/always-forget.md

mkdir -p ~/.config/kitty
ln -sf "$DOTFILES_DIR/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf

mkdir -p ~/.config/fcitx5/conf ~/.local/share/fcitx5/rime
for f in config profile; do
  [ ! -f ~/.config/fcitx5/$f ] && cp "$DOTFILES_DIR/config/fcitx5/$f" ~/.config/fcitx5/$f
done
[ ! -f ~/.config/fcitx5/conf/rime.conf ] && cp "$DOTFILES_DIR/config/fcitx5/conf/rime.conf" ~/.config/fcitx5/conf/rime.conf
[ ! -f ~/.local/share/fcitx5/rime/default.custom.yaml ] && cp "$DOTFILES_DIR/local/share/fcitx5/rime/default.custom.yaml" ~/.local/share/fcitx5/rime/default.custom.yaml
