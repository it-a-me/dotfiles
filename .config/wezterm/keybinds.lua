local keybinds = {}
local wezterm = require 'wezterm'

keybinds.keys = {
   {
      key = 'Enter',
      mods = 'ALT',
      action = wezterm.action.DisableDefaultAssignment
   }
}

return keybinds
