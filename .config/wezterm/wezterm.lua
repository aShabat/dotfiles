local wezterm = require 'wezterm'
local mux = wezterm.mux
require("events")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

local colors_file = io.open("/home/anton/.config/wezterm/base16-scheme.toml", "r")
if colors_file ~= nil then
    local colors, _ = wezterm.color.load_scheme("/home/anton/.config/wezterm/base16-scheme.toml")
    config.colors = colors
end

config.window_close_confirmation = "NeverPrompt"
config.enable_wayland = false

config.disable_default_key_bindings = true
config.keys = require("keys").keys
config.key_tables = require("keys").key_tables

return config
