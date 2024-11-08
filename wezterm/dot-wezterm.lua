-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.hide_tab_bar_if_only_one_tab = true

-- For example, changing the color scheme:
config.color_scheme = 'dawnfox'

config.keys = {
    { key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
    { key = "F8", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
    { key = "F9", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
    { key = "F8", action = act.PasteFrom("PrimarySelection") },
    { key = "F9", action = act.PasteFrom("PrimarySelection") },
}

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Middle' } },
        mods = 'SHIFT',
        action = act.PasteFrom("PrimarySelection"),
    },
}

-- and finally, return the configuration to wezterm
return config
