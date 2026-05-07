#!/bin/bash
set -e

sudo -v

USER_HOME="$HOME"

run_as_user() {
    "$@"
}

sudo apt-get install -y software-properties-common neovim python3-neovim

NVIM_VERSION=$(nvim --version 2>/dev/null | grep -oP '(?<=NVIM v)\d+\.\d+' | head -1)
NVIM_MINOR=$(echo "$NVIM_VERSION" | cut -d. -f2)

if [ -z "$NVIM_VERSION" ] || [ "${NVIM_MINOR:-0}" -lt 10 ]; then
    echo "Default repo neovim too old ($NVIM_VERSION), trying PPA..."
    sudo add-apt-repository -y ppa:neovim-ppa/stable && \
        sudo apt-get update -qq && \
        sudo apt-get install -y neovim || \
        echo "WARNING: PPA unavailable for this Ubuntu release -- neovim $NVIM_VERSION installed from default repos"
fi

# Backup existing config
for dir in \
    "$USER_HOME/.config/nvim" \
    "$USER_HOME/.local/share/nvim" \
    "$USER_HOME/.local/state/nvim" \
    "$USER_HOME/.cache/nvim"; do
    [ -d "$dir" ] && run_as_user mv "$dir" "${dir}.bak_$(date +%s)"
done

run_as_user git clone https://github.com/LazyVim/starter "$USER_HOME/.config/nvim"
rm -rf "$USER_HOME/.config/nvim/.git"

echo "Completed -- run nvim to finish LazyVim plugin installation"
