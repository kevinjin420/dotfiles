#!/usr/bin/env bash
# Uninstalls everything that macos-aerospace.yml or macos-iss.yml may have installed.
# Safe to run before switching between the two playbooks.

set -euo pipefail

echo "==> Quitting managed apps if running..."
for app in AltTab AltTab-aerospace AltTab-fork Aerospace; do
  osascript -e "tell application \"$app\" to quit" 2>/dev/null || true
done
# instant-space-switcher runs as a menu bar agent
pkill -x "instant-space-switcher" 2>/dev/null || true
pkill -f "AltTab" 2>/dev/null || true
pkill -f "AeroSpace" 2>/dev/null || true
sleep 1

echo "==> Uninstalling Homebrew casks..."
for cask in nikitabobko/tap/aerospace jurplel/tap/instant-space-switcher; do
  if brew list --cask "$cask" &>/dev/null; then
    brew uninstall --cask "$cask" && echo "  removed $cask"
  else
    echo "  $cask not installed, skipping"
  fi
done

echo "==> Removing taps (if no other formulae depend on them)..."
brew untap nikitabobko/tap 2>/dev/null && echo "  removed nikitabobko/tap" || echo "  nikitabobko/tap not tapped or has dependents, skipping"
brew untap jurplel/tap    2>/dev/null && echo "  removed jurplel/tap"    || echo "  jurplel/tap not tapped or has dependents, skipping"

echo "==> Removing AltTab.app (source-built fork)..."
if [ -d /Applications/AltTab.app ]; then
  rm -rf /Applications/AltTab.app && echo "  removed /Applications/AltTab.app"
else
  echo "  /Applications/AltTab.app not found, skipping"
fi

echo "==> Removing alt-tab fork build directory..."
if [ -d /tmp/alt-tab-macos-fork ]; then
  rm -rf /tmp/alt-tab-macos-fork && echo "  removed /tmp/alt-tab-macos-fork"
else
  echo "  /tmp/alt-tab-macos-fork not found, skipping"
fi

echo "==> Removing aerospace config symlink..."
AEROSPACE_CONF="$HOME/.config/aerospace/aerospace.toml"
if [ -L "$AEROSPACE_CONF" ]; then
  rm "$AEROSPACE_CONF" && echo "  removed $AEROSPACE_CONF"
else
  echo "  $AEROSPACE_CONF is not a symlink, skipping"
fi

echo ""
echo "Done. You can now run either macos-aerospace.yml or macos-iss.yml cleanly."
