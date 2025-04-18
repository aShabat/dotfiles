local wezterm = require 'wezterm'
local act = wezterm.action
local H = {}

H.hyperlink_pattens = {}
for _, tbl in pairs(wezterm.default_hyperlink_rules()) do
    H.hyperlink_pattens[#H.hyperlink_pattens + 1] = tbl.regex
end

return {
    keys = {
        { key = 'l', mods = 'ALT|SHIFT', action = act.EmitEvent 'toggle-ligature' },
        { key = 'RightArrow', mods = 'ALT', action = act.ActivateTabRelative(1) },
        { key = 'RightArrow', mods = 'ALT|SHIFT', action = act.MoveTabRelative(1) },
        { key = 'LeftArrow', mods = 'ALT', action = act.ActivateTabRelative(-1) },
        { key = 'LeftArrow', mods = 'ALT|SHIFT', action = act.MoveTabRelative(-1) },
        { key = 'UpArrow', mods = 'ALT', action = act.ActivateTab(0) },
        { key = 'UpArrow', mods = 'ALT|SHIFT', action = act.MoveTab(0) },
        { key = 'DownArrow', mods = 'ALT', action = act.ActivateTab(-1) },
        { key = 'DownArrow', mods = 'ALT|SHIFT', action = act.EmitEvent 'move-tab-last' },
        { key = '[', mods = 'ALT', action = act.ActivateTab(0) },
        { key = '{', mods = 'ALT|SHIFT', action = act.MoveTab(0) },
        { key = ']', mods = 'ALT', action = act.ActivateTab(-1) },
        { key = 'f', mods = 'ALT', action = act.ToggleFullScreen },
        { key = 'l', mods = 'ALT', action = act.EmitEvent 'move-spawn-right' },
        { key = 'h', mods = 'ALT', action = act.EmitEvent 'move-spawn-left' },
        { key = 'k', mods = 'ALT', action = act.EmitEvent 'move-spawn-top' },
        { key = 'j', mods = 'ALT', action = act.EmitEvent 'move-spawn-bottom' },
        { key = '+', mods = 'ALT|SHIFT', action = act.IncreaseFontSize },
        { key = '-', mods = 'ALT', action = act.DecreaseFontSize },
        { key = '0', mods = 'ALT', action = act.ResetFontSize },
        { key = 'd', mods = 'ALT', action = act.ShowDebugOverlay },
        { key = 'p', mods = 'ALT', action = act.ActivateCommandPalette },
        { key = 'r', mods = 'ALT', action = act.ReloadConfiguration },
        { key = 'Enter', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'Enter', mods = 'ALT|SHIFT', action = act.SpawnWindow },
        { key = 'q', mods = 'ALT', action = act.EmitEvent 'close-pane' },
        { key = 'q', mods = 'ALT|SHIFT', action = act.CloseCurrentTab { confirm = true } },
        {
            key = 'u',
            mods = 'ALT',
            action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' },
        },
        {
            key = 'u',
            mods = 'ALT|SHIFT',
            action = act.QuickSelectArgs {
                label = 'open hyperlink',
                patterns = H.hyperlink_pattens,
                action = wezterm.action_callback(function(window, pane)
                    local url = window:get_selection_text_for_pane(pane)
                    wezterm.log_info('opening ' .. url)
                    wezterm.open_with(url)
                end),
            },
        },
        { key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
        { key = 'c', mods = 'ALT', action = act.CopyTo 'ClipboardAndPrimarySelection' },
        { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
        { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
        { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
        { key = 'y', mods = 'ALT', action = act.QuickSelect },
        {
            key = 'y',
            mods = 'ALT|SHIFT',
            action = act.Multiple {
                act.ActivateCopyMode,
                { CopyMode = 'ClearPattern' },
            },
        },
    },
    key_tables = {
        copy_mode = {
            {
                key = 'y',
                mods = 'NONE',
                action = act.Multiple {
                    { CopyTo = 'ClipboardAndPrimarySelection' },
                    { CopyMode = 'Close' },
                },
            },
            {
                key = 'y',
                mods = 'SHIFT',
                action = act.Multiple {
                    { CopyTo = 'ClipboardAndPrimarySelection' },
                    { CopyMode = 'Close' },
                    { PasteFrom = 'Clipboard' },
                },
            },
            {
                key = 'Escape',
                mods = 'NONE',
                action = act.Multiple {
                    { CopyMode = 'ClearSelectionMode' },
                    { CopyMode = 'ClearPattern' },
                    { CopyMode = 'Close' },
                },
            },
            { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } },
            { key = 'v', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
            { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' } },
            { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
            { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
            { key = 'l', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
            { key = 'k', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
            { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
            { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
            { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
            { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
            { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
            { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
            { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
            {
                key = '/',
                mods = 'NONE',
                action = act.Multiple {
                    { CopyMode = 'ClearPattern' },
                    { Search = { CaseInSensitiveString = '' } },
                },
            },
            { key = 'n', mods = 'NONE', action = act.CopyMode 'NextMatch' },
            { key = 'n', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
        },
        search_mode = {
            {
                key = 'Escape',
                mods = 'NONE',
                action = act.Multiple {
                    { CopyMode = 'ClearPattern' },
                    { CopyMode = 'ClearSelectionMode' },
                    { CopyMode = 'Close' },
                },
            },
            { key = 'Enter', mods = 'NONE', action = act.ActivateCopyMode },
        },
    },
}
