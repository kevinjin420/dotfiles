#!/bin/bash
set -e

sudo -v

USER_HOME="$HOME"

run_as_user() {
    "$@"
}

# Install zsh and fzf
sudo apt-get update -qq
sudo apt-get install -y zsh fzf

# Set zsh as default shell
ZSH_BIN=$(which zsh)
if ! grep -qxF "$ZSH_BIN" /etc/shells; then
    echo "$ZSH_BIN" | sudo tee -a /etc/shells
fi
sudo chsh -s "$ZSH_BIN" "$USER"

# Install oh-my-zsh if not present
if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
    run_as_user sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$USER_HOME/.oh-my-zsh/custom"

# Install plugins and theme
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    run_as_user git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    run_as_user git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && \
    run_as_user git clone --depth=1 https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"

echo "Completed"
