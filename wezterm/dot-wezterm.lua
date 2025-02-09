local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

local dark_scheme = 'Kasugano (terminal.sexy)'
local lite_scheme = 'dawnfox'

local desired_scheme = dark_scheme -- automated
config.color_scheme = desired_scheme
-- config.color_scheme = 'dawnfox'
-- config.color_scheme = 'Dark Ocean (terminal.sexy)'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Kasugano (terminal.sexy)'

config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

wezterm.on('toggle-colorscheme', function(window, pane)
    local new_desired_scheme = "lite_scheme"
    if desired_scheme == lite_scheme then
        new_desired_scheme = "dark_scheme"
    end
    print(new_desired_scheme)
    os.execute("sed -i'' \"s/^local desired_scheme = .*/local desired_scheme = " .. new_desired_scheme .. " -- automated/\" /home/glenn/.wezterm.lua")
end)

config.keys = {
    {
        key = 'F12',
        action = wezterm.action.EmitEvent 'toggle-colorscheme',
    },
    {
        key = 'F9',
        mods = "CTRL",
        action = act({ PasteFrom = "PrimarySelection" }),
    },
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

wezterm.font_with_fallback({
  -- /usr/share/fonts/TTF/JetBrainsMono-Regular.ttf, FontConfig
  "JetBrains Mono",

  -- /usr/share/fonts/TTF/SymbolsNerdFontMono-Regular.ttf, FontConfig
  "Symbols Nerd Font Mono",

  -- /usr/share/fonts/noto/NotoColorEmoji.ttf, FontConfig
  -- Assumed to have Emoji Presentation
  -- Pixel sizes: [128]
  "Noto Color Emoji",

})

-- config.key_map_preference = "Mapped"

return config
