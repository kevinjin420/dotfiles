#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
    echo "Do not run as root" >&2
    exit 1
fi

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

if [[ "$OSTYPE" != "darwin"* ]]; then
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

    KITTY_ICON=$(realpath ~/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png)
    KITTY_BIN=$(realpath ~/.local/kitty.app/bin/kitty)
    sed -i "s|Icon=kitty|Icon=${KITTY_ICON}|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=${KITTY_BIN}|g" ~/.local/share/applications/kitty*.desktop

    echo 'kitty.desktop' > ~/.config/xdg-terminals.list
fi

echo "Completed"
