# klassy window border investigation

There is a thin gray border visible around windows. All the obvious klassy/kwin settings have been set to "none" but the border persists.

## settings already confirmed set (not the cause)

`~/.config/klassy/klassyrc [WindowOutlineStyle]`:
- `ThinWindowOutlineStyleActive=WindowOutlineNone`
- `ThinWindowOutlineStyleInactive=WindowOutlineNone`
- `WindowOutlineStyleActive=WindowOutlineNone`
- `WindowOutlineStyleInactive=WindowOutlineNone`
- `WindowOutlineShadowColorOpacity=0`

`~/.config/kwinrc [org.kde.kdecoration2]`:
- `BorderSize=None`

## things not yet checked / compare against the working machine

- is the working machine on X11 vs Wayland? (`echo $XDG_SESSION_TYPE`)
- kwin effects — any effect drawing an outline? (`~/.config/kwinrc [Plugins]`)
- color scheme — `~/.local/share/color-schemes/AritimDark.colors` — does it define a window border color?
- `~/.config/breezerc` — `OutlineIntensity` key
- compositor settings (`~/.config/kwinrc [Compositing]`)
- `UseTitleBarColorForAllBorders` in klassyrc — currently `false`; try toggling
- check if border disappears when temporarily switching windeco to Breeze — would narrow it down to klassy vs kwin/compositor
