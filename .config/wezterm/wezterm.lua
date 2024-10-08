local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('window-config-reloaded', function(window, pane)
  -- approximately identify this gui window, by using the associated mux id
  local id = tostring(window:window_id())

  -- maintain a mapping of windows that we have previously seen before in this event handler
  local seen = wezterm.GLOBAL.seen_windows or {}
  -- set a flag if we haven't seen this window before
  local is_new_window = not seen[id]
  -- and update the mapping
  seen[id] = true
  wezterm.GLOBAL.seen_windows = seen

  -- now act upon the flag
  if is_new_window then
    window:maximize()
  end
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
