#!/bin/bash

USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)

if [ -d "$USER_HOME/.oh-my-zsh" ]; then
    ZSH_CUSTOM="$USER_HOME/.oh-my-zsh/custom"
elif [ -d /usr/share/oh-my-zsh ]; then
    ZSH_CUSTOM="/usr/share/oh-my-zsh/custom"
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
