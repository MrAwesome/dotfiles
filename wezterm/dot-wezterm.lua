local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'dawnfox'
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

-- Keyboard shortcuts
config.keys = {
}

-- Mouse bindings
config.mouse_bindings = {
    {
		event = { Down = { streak = 1, button = "Middle" } },
		mods = "SHIFT",
		action = act({ PasteFrom = "PrimarySelection" }),
	},
}

-- Window padding
config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}

return config
