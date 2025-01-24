local wezterm = require 'wezterm'
local act = wezterm.action

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
		{ key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
		{ key = 'x', mods = 'ALT', action = act.ActivateCopyMode },
		{ key = 'c', mods = 'ALT', action = act.CopyTo 'Clipboard' },
		{ key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
		{ key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
		{ key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
		{ key = 'y', mods = 'ALT', action = act.QuickSelect },
	},
	key_tables = {},
}
