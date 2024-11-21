local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'dawnfox'
-- config.color_scheme = 'Dark Ocean (terminal.sexy)'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Kasugano (terminal.sexy)'

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
  left = '0.5cell',
  right = '0.5cell',
  top = '0cell',
  bottom = '0cell',
}

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 100,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 100,
}
config.colors = {
  visual_bell = '#202020',
}

return config
