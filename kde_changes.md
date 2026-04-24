# KDE Settings Reference

## Prerequisites
- `klassy` must be installed (script exits if not found)
- Run as normal user, not root

## Assets Copied

| Source (dotfiles) | Destination |
|---|---|
| `kde/color-schemes/AritimDark.colors` | `~/.local/share/color-schemes/` |
| `wallpapers/*` | `~/Documents/wallpapers/` (no-clobber) |
| `kde/plasma-org.kde.plasma.desktop-appletsrc` | `~/.config/` (with `/home/kevinjin/` replaced by `$HOME`) |

---

## kwinrc

| Setting | Value | Notes |
|---|---|---|
| Desktops/Number | 5 | |
| Desktops/Rows | 1 | Single row of desktops |
| Windows/RollOverDesktops | false | No wraparound when switching desktops |
| Windows/DelayFocusInterval | 0 | Instant focus follows mouse |
| Tiling/padding | 4 | Gap between tiled windows |
| org.kde.kdecoration2/library | org.kde.klassy | Klassy window decoration |
| org.kde.kdecoration2/theme | Klassy | |
| TabBox/ActivitiesMode | 0 | Alt-Tab shows windows from all activities |
| TabBox/HighlightWindows | false | No hover highlight in alt-tab |
| TabBox/LayoutName | compact | Compact alt-tab switcher |
| Plugins/shakecursorEnabled | false | Disable shake-to-find-cursor |
| Plugins/slideEnabled | false | Disable desktop slide animation |
| Script-desktopchangeosd/TextOnly | true | Desktop switcher OSD shows text only |
| Wayland/EnablePrimarySelection | false | Disable middle-click paste |

---

## kdeglobals

| Setting | Value | Notes |
|---|---|---|
| KDE/LookAndFeelPackage | org.kde.breezedark.desktop | Breeze Dark global theme |
| KDE/AnimationDurationFactor | 0.25 | Animations at 25% speed |
| General/ColorScheme | AritimDark | |
| General/BrowserApplication | com.google.Chrome.desktop | |
| General/TerminalService | kitty.desktop | |
| General/TerminalApplication | kitty binary path | Resolved at install time via `which kitty`, falls back to `~/.local/kitty.app/bin/kitty` |

---

## klassy/klassyrc

| Setting | Value | Notes |
|---|---|---|
| Global/LookAndFeelSet | org.kde.breezedark.desktop | |
| ShadowStyle/ShadowStrength | 128 | |
| Windeco/AnimationsEnabled | false | No decoration animations |
| Windeco/ButtonShape | ShapeFullHeightRectangle | Full-height square titlebar buttons |
| Windeco/ColorizeThinWindowOutlineWithButton | false | |
| Windeco/CornerRadius | 0 | Square corners |
| Windeco/UseTitleBarColorForAllBorders | false | |
| Windeco/WindowCornerRadius | 0 | Square window corners |
| WindowOutlineStyle/ThinWindowOutlineStyleActive | WindowOutlineNone | No active window outline |
| WindowOutlineStyle/ThinWindowOutlineStyleInactive | WindowOutlineNone | No inactive window outline |

---

## plasmarc

| Setting | Value |
|---|---|
| Theme/name | klassy |

---

## plasmashellrc

| Setting | Value | Notes |
|---|---|---|
| PlasmaViews/Panel 2/floating | 0 | Panel not floating |
| PlasmaViews/Panel 2/panelOpacity | 1 | Panel fully opaque |
| PlasmaViews/Panel 2/Defaults/thickness | 44px | |

---

## kcminputrc

| Setting | Value | Notes |
|---|---|---|
| Keyboard/RepeatDelay | 200ms | |
| Keyboard/RepeatRate | 40hz | |

> Touchpad natural scroll, tap-to-click, and clickfinger are device-ID-specific and not set by this script. Configure via System Settings on each machine.

---

## powerdevilrc

| Profile | Setting | Value |
|---|---|---|
| AC/Display | DimDisplayWhenIdle | false |
| AC/Display | TurnOffDisplayWhenIdle | false |
| AC/Performance | PowerProfile | performance |
| AC/SuspendAndShutdown | AutoSuspendAction | 0 (disabled) |
| Battery/Display | DimDisplayWhenIdle | false |
| Battery/Performance | PowerProfile | balanced |
| Battery/SuspendAndShutdown | AutoSuspendIdleTimeoutSec | 900 |
| BatteryManagement | BatteryCriticalAction | 1 (hibernate) |
| LowBattery/Performance | PowerProfile | power-saver |

---

## kscreenlockerrc

| Setting | Value |
|---|---|
| Daemon/Timeout | 30 min |
| Lock screen wallpaper | `~/Documents/wallpapers/firewatch.png` |

---

## breezerc

| Setting | Value |
|---|---|
| Common/OutlineIntensity | OutlineOff |
| Common/ShadowStrength | 128 |

---

## Panel Layout (plasma-org.kde.plasma.desktop-appletsrc)

Captured from Plasma 6.2. May need refresh on 6.6.

Panel order: `Kicker > Desktop Status Bar > Icon Tasks > Separator > System Tray > Clock`

| Applet | Plugin ID | Notes |
|---|---|---|
| Kicker | org.kde.plasma.kicker | Meta key shortcut, Kubuntu logo button, no recent apps/docs |
| Desktop Status Bar | org.kde.plasma.desktop-status-bar | Custom widget, broken on 6.6 -- will appear as error until fixed |
| Icon Tasks | org.kde.plasma.icontasks | No wheel scroll, single row |
| Margins Separator | org.kde.plasma.marginsseparator | |
| System Tray | org.kde.plasma.systemtray | Battery %, network, bluetooth, volume, clipboard, notifications |
| Digital Clock | org.kde.plasma.digitalclock | ISO date format, 24h, weight 400 |

Desktop wallpaper: `~/Documents/wallpapers/bryce_canyon_valley.JPG`

---

## Not Handled by Script

- **Display layout** (`kwinoutputconfig.json`, `kscreen/`) -- machine-specific
- **Touchpad device settings** -- hardware-ID-specific, set via System Settings
- **Global shortcuts** (`kglobalshortcutsrc`) -- mostly KDE defaults, set manually if needed
- **Plasmoid `org.kde.plasma.desktop-status-bar`** -- broken on 6.6, not installed
