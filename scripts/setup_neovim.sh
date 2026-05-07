#!/bin/bash
set -e

sudo -v

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
    "$HOME/.config/nvim" \
    "$HOME/.local/share/nvim" \
    "$HOME/.local/state/nvim" \
    "$HOME/.cache/nvim"; do
    [ -d "$dir" ] && mv "$dir" "${dir}.bak_$(date +%s)"
done

git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

echo "Completed -- run nvim to finish LazyVim plugin installation"
