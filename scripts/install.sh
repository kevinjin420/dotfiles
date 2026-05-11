#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

ln -sf "$DOTFILES_DIR/dots/zshrc"            "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/dots/p10k.zsh"         "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/dots/gitconfig"        "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/dots/always_forget.md" "$HOME/always-forget.md"

if [[ "$OSTYPE" != "darwin"* ]]; then
    mkdir -p "$HOME/.config/fcitx5/conf" "$HOME/.local/share/fcitx5/rime"
    for f in config profile; do
        [ ! -f "$HOME/.config/fcitx5/$f" ] && cp "$DOTFILES_DIR/config/fcitx5/$f" "$HOME/.config/fcitx5/$f"
    done
    [ ! -f "$HOME/.config/fcitx5/conf/rime.conf" ] && cp "$DOTFILES_DIR/config/fcitx5/conf/rime.conf" "$HOME/.config/fcitx5/conf/rime.conf"
    [ ! -f "$HOME/.local/share/fcitx5/rime/default.custom.yaml" ] && cp "$DOTFILES_DIR/local/share/fcitx5/rime/default.custom.yaml" "$HOME/.local/share/fcitx5/rime/default.custom.yaml"
fi
