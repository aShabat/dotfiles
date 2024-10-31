local wezterm = require 'wezterm'

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

wezterm.on('toggle-ligature', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.harfbuzz_features then
        -- If we haven't overridden it yet, then override with ligatures disabled
        overrides.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    else
        -- else we did already, and we should disable out override now
        overrides.harfbuzz_features = nil
    end
    window:set_config_overrides(overrides)
end)
