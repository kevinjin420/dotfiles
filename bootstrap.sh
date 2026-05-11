#!/bin/bash
set -euxo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

DOTFILES_REPO="https://github.com/kevinjin420/dotfiles"
DOTFILES_DIR="${HOME}/.dotfiles"

echo -e "${BLUE}Bootstrapping${NC}"

# Install Ansible and git if not already present
if ! command -v ansible-playbook &>/dev/null; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "${GREEN}Detected macOS${NC}"
        if ! command -v brew &>/dev/null; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install ansible git
    elif [ -f /etc/debian_version ]; then
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
fi

# Clone dotfiles if not already present
if [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo -e "${BLUE}Cloning dotfiles...${NC}"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

echo -e "${BLUE}Running Ansible playbook...${NC}"
ansible-playbook -i "localhost," -c local "$DOTFILES_DIR/ansible/local.yml" --ask-become-pass

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${BLUE}Running macOS playbook...${NC}"
    ansible-playbook -i "localhost," -c local "$DOTFILES_DIR/ansible/macos.yml"
fi

if command -v kwriteconfig6 &>/dev/null; then
    echo -e "${BLUE}Running KDE playbook...${NC}"
    ansible-playbook -i "localhost," -c local "$DOTFILES_DIR/ansible/kde.yml"
fi

echo -e "${GREEN}Setup complete!${NC}"
