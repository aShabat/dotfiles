local wezterm = require'wezterm'
local act = wezterm.action
local M = {}

wezterm.on('window-config-reloaded', function (window, pane)
    local id = tostring(window:window_id())

    local seen = wezterm.GLOBAL.seen_open_windows or {}
    local is_seen = not seen[id]
    seen[id] = true
    wezterm.GLOBAL.seen_open_windows = seen
    if is_seen then
        window:maximize()
    end
end)

wezterm.on('window-resized', function (window, pane)
    local overrides = window:get_config_overrides() or {}
    if window:get_dimensions().is_full_screen then
        overrides.enable_tab_bar = false
    else
        overrides.enable_tab_bar = true
    end
    window:set_config_overrides(overrides)
end)

-- Key-emitted events

M.default_harfbuzz = {
    'cv01', -- a
    'cv02', -- g
    'ss01', -- r
    'cv13', -- 0
    'ss05', -- @
    'ss04', -- $
    'ss03', -- &
    'cv16', -- *
    'cv31', -- ()
    'cv29', -- {}
    'cv30', -- |
    'ss02', -- >= <=
    'cv27', -- []
    'ss06', -- \\
    'ss07', -- =~ !~
}
local enable_ligatures = true
wezterm.on('toggle-ligature', function (window, pane)
    enable_ligatures = not enable_ligatures
    local overrides = window:get_config_overrides() or {}
    overrides.harfbuzz_features = M.default_harfbuzz
    local add
    if enable_ligatures then
        add = { 'calt=1', 'clig=1', 'liga=1' }
    else
        add = { 'calt=0', 'clig=0', 'liga=0' }
    end
    for _, a in pairs(add) do
        overrides.harfbuzz_features[#overrides.harfbuzz_features + 1] = a
    end
    window:set_config_overrides(overrides)
end)

wezterm.on('move-spawn-right', function (window, pane)
    local tab = pane:tab()
    if tab:get_pane_direction'Right' ~= nil then
        window:perform_action(act.ActivatePaneDirection'Right', pane)
        return
    else
        pane:split{ direction = 'Right' }
    end
end)
wezterm.on('move-spawn-left', function (window, pane)
    local tab = pane:tab()
    if tab:get_pane_direction'Left' ~= nil then
        window:perform_action(act.ActivatePaneDirection'Left', pane)
        return
    else
        pane:split{ direction = 'Left' }
    end
end)
wezterm.on('move-spawn-top', function (window, pane)
    local tab = pane:tab()
    if tab:get_pane_direction'Up' ~= nil then
        window:perform_action(act.ActivatePaneDirection'Up', pane)
        return
    else
        pane:split{ direction = 'Top' }
    end
end)
wezterm.on('move-spawn-bottom', function (window, pane)
    local tab = pane:tab()
    if tab:get_pane_direction'Down' ~= nil then
        window:perform_action(act.ActivatePaneDirection'Down', pane)
        return
    else
        pane:split{ direction = 'Bottom' }
    end
end)

wezterm.on('close-pane', function (window, pane)
    if pane:tab():panes()[2] == nil then
        window:perform_action(act.CloseCurrentTab{ confirm = false }, pane)
    else
        window:perform_action(act.CloseCurrentPane{ confirm = false }, pane)
    end
end)

wezterm.on('move-tab-last', function (window, pane)
    window:perform_action(act.MoveTab(#(window:mux_window():tabs()) - 1), pane)
end)

return M
