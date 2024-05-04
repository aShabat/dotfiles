local wezterm = require("wezterm")

local config = require("config")

local colors, _ = wezterm.color.load_scheme("/home/anton/.config/wezterm/config/theme.toml")
config.colors = colors

return config
