local wezterm = require("wezterm")
local keys = require("keys")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local colors, _ = wezterm.color.load_scheme("/home/anton/.config/wezterm/base16-theme.toml")
config.colors = colors

config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'

keys.apply(config)

return config
