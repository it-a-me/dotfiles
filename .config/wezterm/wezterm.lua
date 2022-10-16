local wezterm = require 'wezterm'
local colors = require 'colors'

return {
   xcursor_theme = 'Adwaita',
   colors = {
      foreground = colors.grey_alpha(85, 100),
      ansi = colors.ansi,
      brights = colors.brights,
      -- The default background color
      background = '#1D1F21',
   },
   keys = require 'keybinds'.keys,
   font_size = 12,
   window_background_opacity = 0.9,
   text_background_opacity = 0.9,
   hide_tab_bar_if_only_one_tab = true,
   window_decorations = "NONE",
   window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
   },
}
