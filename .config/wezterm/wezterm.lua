local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

local colors_file = io.open("/home/anton/.config/wezterm/base16-scheme.toml", "r")
if colors_file ~= nil then
    local colors, _ = wezterm.color.load_scheme("/home/anton/.config/wezterm/base16-scheme.toml")
    config.colors = colors
end

config.window_close_confirmation = "NeverPrompt"

return config
