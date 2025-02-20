local H = {}

H.files_set_cwd = function(_)
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.fn.chdir(cur_directory)
end

H.files_show_dot = false
H.files_filter_show = function(_)
    return true
end
H.files_filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
end

H.files_toggle_dotfiles = function()
    H.files_show_dot = not H.files_show_dot

    local filter = H.files_show_dot and H.files_filter_show or H.files_filter_hide
    MiniFiles.refresh { content = { filter = filter } }
end

H.files_show_preview = false
H.files_toggle_preview = function()
    H.files_show_preview = not H.files_show_preview
    MiniFiles.refresh { windows = { preview = H.files_show_preview } }
    MiniFiles.trim_right()
end
H.hide_preview = function()
    H.files_show_preview = false
end

H.sync_and_go_in = function()
    if not MiniFiles.get_explorer_state() then return end
    local fs_entry = MiniFiles.get_fs_entry()
    if fs_entry and fs_entry.fs_type == 'directory' then
        MiniFiles.go_in()
    else
        local synced = MiniFiles.synchronize()
        if synced then
            while MiniFiles.get_explorer_state() do
                MiniFiles.go_in { close_on_file = true }
            end
        end
    end
end

require('mini.files').setup {
    options = {
        use_as_default_explorer = true,
    },
    content = {
        filter = H.files_filter_hide,
    },
    windows = {
        width_preview = 100,
    },
    mappings = {
        go_in = 'L',
        go_in_plus = '',
    },
}

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesActionRename',
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        vim.keymap.set('n', 'l', H.sync_and_go_in, { buffer = args.data.buf_id, desc = 'Synchronize and go in' })
        vim.keymap.set('n', 'g~', H.files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd' })
        vim.keymap.set('n', 'g.', H.files_toggle_dotfiles, { buffer = args.data.buf_id, desc = 'Toggle hidden' })
        vim.keymap.set('n', 'gp', H.files_toggle_preview, { buffer = args.data.buf_id, desc = 'Toggle preview' })
    end,
})

H.preview = {}
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowUpdate',
    callback = function(args)
        local buf_id, win_id = args.data.buf_id, args.data.win_id
        if not win_id then return end

        local win_config = vim.api.nvim_win_get_config(win_id)
        if not win_config.title[1] then return end

        if H.preview.image then H.preview.image:clear() end
        local image_extensions = { '%.png$', '%.jpg$', '%.jpeg$', '%.gif$', '%.webp$', '%.avif$' }
        local is_image = false
        for _, ext in ipairs(image_extensions) do
            is_image = is_image or win_config.title[1][1]:match(ext)
        end
        if not is_image then return end

        vim.api.nvim_buf_set_lines(buf_id, 0, -1, true, {})

        local image = MiniFiles.get_explorer_state().windows[#MiniFiles.get_explorer_state().windows].path
        H.preview.image = require('image').from_file(image, {
            window = win_id,
            with_virtual_padding = true,
        })

        local max_height_percentage = 0.9
        local max_width_percentage = 0.5
        local term_size = require('image.utils').term.get_size()
        local height = math.ceil(H.preview.image.image_height / term_size.cell_height)
        local width = math.ceil(H.preview.image.image_width / term_size.cell_width)
        if height > max_height_percentage * vim.o.lines then
            width = math.ceil(width * vim.o.lines * max_height_percentage / height)
            height = math.ceil(vim.o.lines * max_height_percentage)
        end
        if width > max_width_percentage * vim.o.columns then
            height = math.ceil(height * vim.o.columns * max_width_percentage / width)
            width = math.ceil(max_width_percentage * vim.o.columns)
        end

        win_config.height = height
        win_config.width = width
        vim.api.nvim_win_set_config(win_id, win_config)
        H.preview.image:render()
    end,
})

H.file_explorer = function()
    H.files_show_dot = false
    H.hide_preview()
    local path = vim.api.nvim_buf_get_name(0)
    path = vim.fs.normalize(path)
    if vim.fn.filereadable(path) == 0 then
        path = vim.fs.dirname(path)
        if vim.fn.isdirectory(path) == 0 then path = vim.fn.getcwd() end
    end
    MiniFiles.open(path, false)
    MiniFiles.trim_right()
end

vim.keymap.set('n', '<leader>e', H.file_explorer, { desc = 'file [E]xplorer' })
