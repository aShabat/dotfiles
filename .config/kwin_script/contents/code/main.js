function killActiveWindow() {
    workspace.activeWindow.closeWindow();
}

registerShortcut("KillActiveWindow", "KillActiveWindow", "Meta+Shift+Q", killActiveWindow);
