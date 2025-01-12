local wezterm = require'wezterm'
local mux = wezterm.mux
local events = require'events'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback{
    'FiraCode Nerd Font Mono',
    'Unifont',
    'Unifont Upper',
    'Unifont CSUR',
}
config.font_rules = {
    {
        italic = true,
        intensity = 'Normal',
        font = wezterm.font{
            family = 'VictorMono',
            style = 'Italic',
        },
    },
}
config.font_size = 12.5
config.harfbuzz_features = events.default_harfbuzz

local colors_file = io.open('/home/anton/.config/wezterm/base16-scheme.toml', 'r')
if colors_file ~= nil then
    local colors, _ = wezterm.color.load_scheme'/home/anton/.config/wezterm/base16-scheme.toml'
    config.colors = colors
end

config.window_close_confirmation = 'NeverPrompt'
config.enable_wayland = false

config.disable_default_key_bindings = true
config.keys = require'keys'.keys
config.key_tables = require'keys'.key_tables

return config
