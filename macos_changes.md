# macOS Manual System Settings

Changes that can't be automated and must be applied manually on a new machine.

## Keyboard Shortcuts → Mission Control

**System Settings > Keyboard > Keyboard Shortcuts > Mission Control**

Disable or reassign all shortcuts that use Ctrl, as they conflict with Karabiner's `ctrl_shortcuts` and `ctrl_browser_bindings` rules:

- [ ] `^ Control + Left` — Move left a space → **disable**
- [ ] `^ Control + Right` — Move right a space → **disable**

## Karabiner-Elements

**After running `ansible-playbook ansible/macos.yml`:**

- [ ] Open Karabiner-Elements and grant the required Input Monitoring and keyboard driver permissions
- [ ] Verify the profile "Default profile" is selected and all rules are active

## AeroSpace

- [ ] Confirm AeroSpace is allowed in **System Settings > General > Login Items** (set via `start-at-login = true` in config, but macOS may prompt for confirmation)
