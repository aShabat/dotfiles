local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('window-config-reloaded', function(window, pane)
    local id = tostring(window:window_id())

    local seen = wezterm.GLOBAL.seen_open_windows or {}
    local is_seen = not seen[id]
    seen[id] = true
    wezterm.GLOBAL.seen_open_windows = seen
    if is_seen then
        window:maximize()
    end
end)

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.harfbuzz_features = { "clig=0", "liga=0", "calt=0" }

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
