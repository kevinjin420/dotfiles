#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo "Run with sudo: sudo ./setup_neovim.sh" >&2
    exit 1
fi

REAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

run_as_user() {
    sudo -u "$REAL_USER" "$@"
}

apt-get install -y software-properties-common
add-apt-repository -y ppa:neovim-ppa/stable
apt-get update -qq
apt-get install -y neovim python3-neovim

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
