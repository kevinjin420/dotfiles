-- Move the focused window to macOS Desktop N (1-9), SIP-free.
--
-- macOS 26 exposes no API to move another app's window to a Space, so we
-- synthesize the native gesture: grab the window by its title bar, switch
-- Space while "holding" it (so it travels), then drop it.
--
-- Trigger:  ctrl-shift-#   (bound here)
-- Internal: alt-#          (must be set in System Settings as the native
--                           "Switch to Desktop N" shortcut)
--
-- Requires, in System Settings:
--   * Keyboard > Shortcuts > Mission Control > Switch to Desktop 1-9 = Option+1-9
--   * Mission Control > "Automatically rearrange Spaces" = OFF
--   * the 9 desktops pre-created in Mission Control

-- Modifier the native "Switch to Desktop N" shortcut uses. Keep in sync with
-- whatever you set in System Settings.
local NATIVE_SWITCH_MODS = { "alt" }

-- Grab point inside the title bar, measured from the window's top-left.
-- TITLE_X clears the traffic-light buttons. Tab-bar apps (Chrome) and custom
-- title bars (VSCode) are the fragile cases — tune these if a window won't grab.
local TITLE_X = 90
local TITLE_Y = 11

-- How long to wait for the (instant-space-switcher) Space change to land
-- before releasing the window. Bump up if windows get left behind.
local SWITCH_SETTLE_US = 180000

local et = hs.eventtap
local types = et.event.types

local function moveFocusedWindowToDesktop(n)
  local win = hs.window.focusedWindow()
  if not win then return end
  if win:isFullScreen() then
    hs.alert.show("Can't move a fullscreen window between desktops")
    return
  end

  local f = win:frame()
  local grab = hs.geometry.point(f.x + TITLE_X, f.y + TITLE_Y)
  local restore = hs.mouse.absolutePosition()

  -- press on the title bar and begin a real drag
  et.event.newMouseEvent(types.leftMouseDown, grab):post()
  hs.timer.usleep(60000)
  et.event.newMouseEvent(types.leftMouseDragged,
    hs.geometry.point(grab.x + 6, grab.y)):post()
  hs.timer.usleep(60000)

  -- switch desktops while the window is held -> it follows
  et.keyStroke(NATIVE_SWITCH_MODS, tostring(n), 0)
  hs.timer.usleep(SWITCH_SETTLE_US)

  -- drop it on the new desktop, then put the cursor back
  et.event.newMouseEvent(types.leftMouseUp, hs.mouse.absolutePosition()):post()
  hs.mouse.absolutePosition(restore)
end

for i = 1, 9 do
  hs.hotkey.bind({ "ctrl", "shift" }, tostring(i), function()
    moveFocusedWindowToDesktop(i)
  end)
end

hs.alert.show("Hammerspoon: move-to-desktop loaded")
