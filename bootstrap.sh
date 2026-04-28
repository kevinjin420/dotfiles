#!/bin/bash
set -e

# ANSI Color Codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting bootstrap process...${NC}"

# Detect OS and install Ansible
if [ -f /etc/debian_version ]; then
    echo -e "${GREEN}Detected Debian/Ubuntu-based system${NC}"
    sudo apt update
    sudo apt install -y ansible git python3
elif [ -f /etc/arch-release ]; then
    echo -e "${GREEN}Detected Arch-based system${NC}"
    sudo pacman -Sy --noconfirm ansible git python
elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
    echo -e "${GREEN}Detected RedHat/Fedora-based system${NC}"
    sudo dnf install -y ansible-core git python3
else
    echo "Unsupported distribution. Please install Ansible manually."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Running Ansible playbook...${NC}"
ansible-playbook -i "localhost," -c local "$DOTFILES_DIR/ansible/local.yml" --ask-become-pass

echo -e "${GREEN}Setup complete!${NC}"
