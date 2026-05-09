#!/usr/bin/env bash

# Helper script to run Ansible playbooks
# from the mrover-ros2 codebase

set -euo pipefail

if [ "$#" -le 0 ]; then
    echo "Usage: $0 <playbook> <args>"
    exit 1
fi

readonly ROOT_PATH="$HOME/dotfiles"
ANSIBLE_CONFIG="${ROOT_PATH}/ansible/ansible.cfg" ansible-playbook -i "localhost," -c local --ask-become-pass "${ROOT_PATH}/ansible/$1"
