local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local colors, _ = wezterm.color.load_scheme("/home/anton/.config/wezterm/base16-theme.toml")
config.colors = colors

config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'

config.keys = {
    { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-0.5) },
    { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(0.5) }
}

return config
