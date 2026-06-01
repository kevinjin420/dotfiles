-- Move the focused window to macOS Desktop N (1-9).
--
-- Trigger: alt-shift-#
--
-- On macOS 26 Tahoe, SLSSetWindowListWorkspace (moveWindowToSpace) returns
-- true but does nothing, and all AX-based paths are blocked. The space switch
-- still works; the window will follow once Hammerspoon or Apple fixes the API.
--
-- Requires in System Settings:
--   * Keyboard > Shortcuts > Mission Control > Switch to Desktop 1-9 = Option+1-9
--   * Mission Control > "Automatically rearrange Spaces" = OFF

local spaces = require("hs.spaces")
local et = hs.eventtap

local NATIVE_SWITCH_MODS = { "alt" }
local KEY_HOLD_US = 100000

local function moveFocusedWindowToDesktop(n)
  local win = hs.window.focusedWindow()
  if not win then return end
  if win:isFullScreen() then
    hs.alert.show("Can't move a fullscreen window between desktops")
    return
  end

  local screenSpaces, err = spaces.spacesForScreen(win:screen())
  if not screenSpaces then
    hs.alert.show("spacesForScreen failed: " .. tostring(err))
    return
  end
  if n > #screenSpaces then
    hs.alert.show("Desktop " .. n .. " does not exist (" .. #screenSpaces .. " total)")
    return
  end

  local targetSpaceID = screenSpaces[n]
  if spaces.focusedSpace() == targetSpaceID then return end

  -- Best-effort window move via private API. Returns true on macOS 26 without
  -- acting; left here so it works automatically if the API is ever fixed.
  spaces.moveWindowToSpace(win:id(), targetSpaceID, true)

  -- Switch to the target space with the native shortcut. Avoids the Mission
  -- Control flash that spaces.gotoSpace() triggers on macOS 26 by design.
  hs.timer.usleep(50000)
  et.keyStroke(NATIVE_SWITCH_MODS, tostring(n), KEY_HOLD_US)
end

for i = 1, 9 do
  hs.hotkey.bind({ "alt", "shift" }, tostring(i), function()
    moveFocusedWindowToDesktop(i)
  end)
end

hs.alert.show("Hammerspoon: move-to-desktop loaded")
