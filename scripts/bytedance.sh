#!/usr/bin/env bash
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

detach "$HOME/.gitconfig"

git config --global user.name "kevin.jin"
git config --global user.email "kevin.jin@bytedance.com"

git config --global 'url.gitr.insteadOf' 'git://git.byted.org/'
git config --global 'credential.https://code.byted.org.username' 'kevin.jin'
git config --global 'url.ssh://kevin.jin@git.byted.org:29418.insteadOf' 'https://git.byted.org'
git config --global 'url.git@code.byted.org:.insteadOf' 'https://code.byted.org/'

echo "git identity: kevin.jin <kevin.jin@bytedance.com>"
