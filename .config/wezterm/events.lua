local wezterm = require 'wezterm'
local act = wezterm.action

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

-- Key-emitted events

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

wezterm.on('move-spawn-right', function(window, pane)
    wezterm.log_info 'called'
    local tab = pane:tab()
    if tab:get_pane_direction 'Right' ~= nil then
        window:perform_action(act.ActivatePaneDirection 'Right', pane)
        return
    else
        pane:split { direction = 'Right' }
    end
end)
wezterm.on('move-spawn-left', function(window, pane)
    wezterm.log_info 'called'
    local tab = pane:tab()
    if tab:get_pane_direction 'Left' ~= nil then
        window:perform_action(act.ActivatePaneDirection 'Left', pane)
        return
    else
        pane:split { direction = 'Left' }
    end
end)
wezterm.on('move-spawn-top', function(window, pane)
    wezterm.log_info 'called'
    local tab = pane:tab()
    if tab:get_pane_direction 'Up' ~= nil then
        window:perform_action(act.ActivatePaneDirection 'Up', pane)
        return
    else
        pane:split { direction = 'Top' }
    end
end)
wezterm.on('move-spawn-bottom', function(window, pane)
    wezterm.log_info 'called'
    local tab = pane:tab()
    if tab:get_pane_direction 'Down' ~= nil then
        window:perform_action(act.ActivatePaneDirection 'Down', pane)
        return
    else
        pane:split { direction = 'Bottom' }
    end
end)

wezterm.on('close-pane', function(window, pane)
    if pane:tab():panes()[2] == nil then
        wezterm.log_info 'tab'
        window:perform_action(act.CloseCurrentTab { confirm = false }, pane)
    else
        wezterm.log_info 'pane'
        window:perform_action(act.CloseCurrentPane { confirm = false }, pane)
    end
end)
