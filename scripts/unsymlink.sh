#!/usr/bin/env bash
# Replaces symlinked dotfiles with real copies so local edits don't affect the repo.
set -euo pipefail

decouple() {
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

  cp "$target" "$path.decoupled"
  rm "$path"
  mv "$path.decoupled" "$path"
  echo "decoupled: $path (was -> $target)"
}

decouple "$HOME/.zshrc"
decouple "$HOME/.gitconfig"
