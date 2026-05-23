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

## findings from diffing working machine config

Both machines are on Wayland.

Working machine `~/.config/klassy/klassyrc [WindowOutlineStyle]` only has:
- `ThinWindowOutlineStyleActive=WindowOutlineNone`
- `ThinWindowOutlineStyleInactive=WindowOutlineNone`

The problematic machine has those PLUS the non-thin variants (`WindowOutlineStyleActive`, `WindowOutlineStyleInactive`, `WindowOutlineShadowColorOpacity`). These keys don't exist in the older Klassy version on the working machine -- they were added in a newer release. If the running Klassy binary doesn't recognize `WindowOutlineNone` as a valid value for those keys, it may silently fall back to a default non-zero outline.

Working machine `~/.config/breezerc`:
- `OutlineIntensity=OutlineOff`

Klassy is built on Breeze and in many versions still reads breezerc for outline rendering. If the problematic machine has a different value here (or the key is absent), Breeze's outline drawing pipeline could be adding the border.

### next steps for the problematic machine

1. Check `~/.config/breezerc` -- is `OutlineIntensity=OutlineOff` set?
2. Run `qdbus org.kde.KWin /KWin supportInformation 2>/dev/null | grep -i border` to see what kwin reports at runtime.
3. Try removing `WindowOutlineStyleActive` and `WindowOutlineStyleInactive` from klassyrc entirely, leaving only the `Thin*` keys (matching the working machine's config), then restart kwin.

## things not yet checked / compare against the working machine

- is the working machine on X11 vs Wayland? (`echo $XDG_SESSION_TYPE`)
- kwin effects — any effect drawing an outline? (`~/.config/kwinrc [Plugins]`)
- color scheme — `~/.local/share/color-schemes/AritimDark.colors` — does it define a window border color?
- `~/.config/breezerc` — `OutlineIntensity` key
- compositor settings (`~/.config/kwinrc [Compositing]`)
- `UseTitleBarColorForAllBorders` in klassyrc — currently `false`; try toggling
- check if border disappears when temporarily switching windeco to Breeze — would narrow it down to klassy vs kwin/compositor
