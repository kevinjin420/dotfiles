#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/always_forget.md" "$HOME/always-forget.md"

mkdir -p "$HOME/.config"/kitty
ln -sf "$DOTFILES_DIR/config/kitty/kitty.conf" "$HOME/.config"/kitty/kitty.conf

mkdir -p "$HOME/.config"/fcitx5/conf "$HOME/.local"/share/fcitx5/rime
for f in config profile; do
  [ ! -f "$HOME/.config"/fcitx5/$f ] && cp "$DOTFILES_DIR/config/fcitx5/$f" "$HOME/.config"/fcitx5/$f
done
[ ! -f "$HOME/.config"/fcitx5/conf/rime.conf ] && cp "$DOTFILES_DIR/config/fcitx5/conf/rime.conf" "$HOME/.config"/fcitx5/conf/rime.conf
[ ! -f "$HOME/.local"/share/fcitx5/rime/default.custom.yaml ] && cp "$DOTFILES_DIR/local/share/fcitx5/rime/default.custom.yaml" "$HOME/.local"/share/fcitx5/rime/default.custom.yaml
