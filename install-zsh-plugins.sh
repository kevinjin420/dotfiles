#!/bin/bash

if [ -d "$HOME/.oh-my-zsh" ]; then
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
elif [ -d /usr/share/oh-my-zsh ]; then
    ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
    mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"
    echo "Using custom directory: $ZSH_CUSTOM"
    echo "Add 'export ZSH_CUSTOM=\"$ZSH_CUSTOM\"' to your zshrc before sourcing oh-my-zsh"
else
    echo "oh-my-zsh not found"
    exit 1
fi

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"

echo "Done"
