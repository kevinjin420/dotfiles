#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]; then
    echo "Do not run as root" >&2
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

check_prerequisites() {
    if ! command -v kwriteconfig6 &>/dev/null; then
        echo "kwriteconfig6 not found -- is KDE Plasma installed?" >&2
        exit 1
    fi
    if ! dpkg -s klassy 2>/dev/null | grep -q "Status: install ok installed"; then
        echo "klassy is not installed -- install it before running this script" >&2
        exit 1
    fi
}

setup_assets() {
    mkdir -p "$HOME/.local/share/color-schemes"
    cp "$DOTFILES_DIR/kde/color-schemes/AritimDark.colors" "$HOME/.local/share/color-schemes/"

    mkdir -p "$HOME/Documents/wallpapers"
    cp -n "$DOTFILES_DIR/wallpapers/"* "$HOME/Documents/wallpapers/"

    sed "s|/home/kevinjin/|$HOME/|g" \
        "$DOTFILES_DIR/kde/plasma-org.kde.plasma.desktop-appletsrc" \
        > "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
}

apply_kwin() {
    kwriteconfig6 --file kwinrc --group Desktops --key Number 5
    kwriteconfig6 --file kwinrc --group Desktops --key Rows 1
    kwriteconfig6 --file kwinrc --group Windows --key RollOverDesktops false
    kwriteconfig6 --file kwinrc --group Windows --key DelayFocusInterval 0
    kwriteconfig6 --file kwinrc --group Tiling --key padding 4
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.klassy
    kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme Klassy
    kwriteconfig6 --file kwinrc --group TabBox --key ActivitiesMode 0
    kwriteconfig6 --file kwinrc --group TabBox --key HighlightWindows false
    kwriteconfig6 --file kwinrc --group TabBox --key LayoutName compact
    kwriteconfig6 --file kwinrc --group Plugins --key shakecursorEnabled false
    kwriteconfig6 --file kwinrc --group Plugins --key slideEnabled false
    kwriteconfig6 --file kwinrc --group Script-desktopchangeosd --key TextOnly true
    kwriteconfig6 --file kwinrc --group Wayland --key EnablePrimarySelection false
}

apply_kdeglobals() {
    kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage org.kde.breezedark.desktop
    kwriteconfig6 --file kdegloobals --group General --key TerminalApplication "$KITTY_BIN"
}

apply_klassy() {
    kwriteconfig6 --file klassy/klassyrc --group Global --key LookAndFeelSet org.kde.breezedark.desktop
    kwriteconfig6 --file klassy/klassyrc --group ShadowStyle --key ShadowStrength 128
    kwriteconfig6 --file klassy/klassyrc --group Windeco --key AnimationsEnabled false
    kwriteconfig6 --file klassy/klassyrc --group Windeco --key ButtonShape ShapeFullHeightRectangle
    kwriteconfig6 --file klassy/klassyrc --group Windeco --key ColorizeThinWindowOutlineWithButton false
    kwriteconfig6 --file klassy/klassyrc --group Windeco --key CornerRadius 0
    kwriteconfig6 --file klassy/klassyrc --group Windeco --key UseTitleBarColorForAllBorders false
    kwriteconfig6 --file klassy/klassyrc --group Windeco --key WindowCornerRadius 0
    kwriteconfig6 --file klassy/klassyrc --group WindowOutlineStyle --key ThinWindowOutlineStyleActive WindowOutlineNone
    kwriteconfig6 --file klassy/klassyrc --group WindowOutlineStyle --key ThinWindowOutlineStyleInactive WindowOutlineNone
}

apply_plasma() {
    kwriteconfig6 --file plasmarc --group Theme --key name klassy
    kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --key floating 0
    kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --key panelOpacity 1
    kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --group Defaults --key thickness 44
}

apply_input() {
    kwriteconfig6 --file kcminputrc --group Keyboard --key RepeatDelay 200
    kwriteconfig6 --file kcminputrc --group Keyboard --key RepeatRate 40
}

apply_power() {
    kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayWhenIdle false
    kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayWhenIdle false
    kwriteconfig6 --file powerdevilrc --group AC --group Performance --key PowerProfile performance
    kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction 0
    kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayWhenIdle false
    kwriteconfig6 --file powerdevilrc --group Battery --group Performance --key PowerProfile balanced
    kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key AutoSuspendIdleTimeoutSec 900
    kwriteconfig6 --file powerdevilrc --group BatteryManagement --key BatteryCriticalAction 1
    kwriteconfig6 --file powerdevilrc --group LowBattery --group Performance --key PowerProfile power-saver
}

apply_lockscreen() {
    kwriteconfig6 --file kscreenlockerrc --group Daemon --key Timeout 30
    kwriteconfig6 --file kscreenlockerrc \
        --group Greeter --group Wallpaper --group org.kde.image --group General \
        --key Image "$HOME/Documents/wallpapers/firewatch.png"
}

apply_breeze() {
    kwriteconfig6 --file breezerc --group Common --key OutlineIntensity OutlineOff
    kwriteconfig6 --file breezerc --group Common --key ShadowStrength 128
}

apply_shortcuts() {
    # Window management
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window Maximize" "Meta+Up,Meta+PgUp,Maximize Window"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window Quick Tile Left" "Meta+Left,Meta+Left,Quick Tile Window to the Left"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window Quick Tile Right" "Meta+Right,Meta+Right,Quick Tile Window to the Right"

    # Switch to desktop (Alt+1-0)
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 1" "Alt+1,Ctrl+F1,Switch to Desktop 1"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 2" "Alt+2,Ctrl+F2,Switch to Desktop 2"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 3" "Alt+3,Ctrl+F3,Switch to Desktop 3"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 4" "Alt+4,Ctrl+F4,Switch to Desktop 4"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 5" "Alt+5,,Switch to Desktop 5"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 6" "Alt+6,,Switch to Desktop 6"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 7" "Alt+7,,Switch to Desktop 7"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 8" "Alt+8,,Switch to Desktop 8"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 9" "Alt+9,,Switch to Desktop 9"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 10" "Alt+0,,Switch to Desktop 10"

    # Move window to desktop (Alt+Shift+1-0)
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 1" "Alt+!,,Window to Desktop 1"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 2" "Alt+@,,Window to Desktop 2"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 3" "Alt+#,,Window to Desktop 3"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 4" "Alt+$,,Window to Desktop 4"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 5" "Alt+%,,Window to Desktop 5"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 6" "Alt+^,,Window to Desktop 6"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 7" "Alt+&,,Window to Desktop 7"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 8" "Alt+*,,Window to Desktop 8"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 9" "Alt+(,,Window to Desktop 9"
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop 10" "Alt+),,Window to Desktop 10"

    # Kitty
    kwriteconfig6 --file kglobalshortcutsrc --group services --group kitty.desktop --key _launch "Alt+Return"
}

reload_kde() {
    qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
    kbuildsycoca6 --noincremental 2>/dev/null || true
    nohup plasmashell --replace > /dev/null 2>&1 &
    disown
}

wait_for_plasmashell() {
    echo "Waiting for Plasma to restart..."
    sleep 3
    while ! pgrep -x plasmashell > /dev/null; do sleep 1; done
    sleep 3
}

check_prerequisites
setup_assets
apply_kwin
apply_kdeglobals
apply_klassy
apply_plasma
apply_input
apply_power
apply_lockscreen
apply_breeze
reload_kde
wait_for_plasmashell
apply_shortcuts

echo "Completed -- log out and back in to activate shortcuts"
