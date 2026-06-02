#!/bin/bash
set -euo pipefail

read -rp "Email: " email

ssh-keygen -t ed25519 -C "${email}" -f ~/.ssh/id_ed25519

echo
cat ~/.ssh/id_ed25519.pub
