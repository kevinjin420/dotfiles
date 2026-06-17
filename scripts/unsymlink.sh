#!/usr/bin/env bash
# Replaces symlinked dotfiles with real copies so local edits don't affect the repo.
set -euo pipefail

detach() {
  local path="$1"

  if [[ ! -L "$path" ]]; then
    echo "skip: $path is not a symlink"
    return
  fi

  local target
  target="$(readlink "$path")"

  if [[ ! -f "$target" ]]; then
    echo "error: symlink target '$target' not found, skipping $path" >&2
    return 1
  fi

  cp "$target" "$path.detached"
  rm "$path"
  mv "$path.detached" "$path"
  echo "detached: $path (was -> $target)"
}

detach "$HOME/.zshrc"
detach "$HOME/.gitconfig"

git config --global user.name "kevin.jin"
git config --global user.email "kevin.jin@bytedance.com"
echo "git identity: kevin.jin <kevin.jin@bytedance.com>"
