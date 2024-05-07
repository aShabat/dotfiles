local miniFilesHelpers = {}

-- function to sed working directory
miniFilesHelpers.files_set_cwd = function (path)
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.fn.chdir(cur_directory)
end

-- function to toggle dotfiles
local show_dot = false
local filter_show = function(fs_entry)
    return true
end
local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
end
miniFilesHelpers.toggle_dotfiles = function()
    show_dot = not show_dot
    local filter = show_dot and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = filter } })
end

-- function to toggle preview
local show_preview = false
miniFilesHelpers.toggle_preview  = function()
    show_preview = not show_preview
    MiniFiles.refresh({ windows = { preview = show_preview } })
    MiniFiles.trim_right()
end

return miniFilesHelpers
