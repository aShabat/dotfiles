local H = {}

require('mini.pick').setup {
    mappings = {
        choose_marked = '<C-CR>',
        choose_all = {
            char = '<SC-CR>',
            func = function()
                vim.api.nvim_input '<C-a><C-CR>'
            end,
        },
    },
    options = {
        use_cache = true,
    },
    window = {
        config = {
            relative = 'editor',
            row = 0,
            col = 0,
        },
    },
}

vim.ui.select = MiniPick.ui_select

H.pick_dirs_action = function()
    local opts = {
        mappings = {
            toggle_files_dirs = {
                char = '<c-d>',
                func = H.pick_files_action,
            },
        },
        source = {
            choose = H.open_dir,
        },
    }
    MiniPick.set_picker_opts(opts)
    MiniPick.set_picker_items_from_cli({ 'fd', '--type=d', '--no-follow', '--color=never' }, {
        postprocess = function(items)
            local new_items = { '.' }
            for i, item in ipairs(items) do
                new_items[i + 1] = item
            end
            return new_items
        end,
    })
end
H.pick_files_action = function()
    local opts = {
        mappings = {
            toggle_files_dirs = {
                char = '<c-d>',
                func = H.pick_dirs_action,
            },
        },
        source = {
            choose = MiniPick.default_choose,
        },
    }
    MiniPick.set_picker_opts(opts)
    MiniPick.set_picker_items_from_cli { 'fd', '--type=f', '--no-follow', '--color=never' }
end
H.open_dir = function(item)
    local path = MiniPick.get_picker_opts().source.cwd .. '/' .. item
    vim.schedule(function()
        MiniFiles.open(path, false)
    end)
end
MiniPick.registry.files = function(local_opts, opts)
    if not local_opts or not local_opts.dirs then
        opts = vim.tbl_deep_extend('force', {
            mappings = {
                toggle_files_dirs = {
                    char = '<c-d>',
                    func = H.pick_dirs_action,
                },
            },
            source = {
                name = 'Files/Dirs',
            },
        }, opts or {})
        MiniPick.builtin.files(local_opts, opts)
    else
        opts = vim.tbl_deep_extend('force', {
            mappings = {
                toggle_files_dirs = {
                    char = '<c-d>',
                    func = H.pick_files_action,
                },
            },
            source = {
                chose = H.open_dir,
                name = 'Files/Dirs',
                show = function(buf_id, items_to_show, query)
                    return MiniPick.default_show(buf_id, items_to_show, query, { show_icons = true })
                end,
            },
        }, opts or {})
        local_opts = vim.tbl_deep_extend('force', {
            command = { 'fd', '--type=d', '--no-follow', '--color=never' },
            postprocess = function(items)
                local new_items = { '.' }
                for i, item in ipairs(items) do
                    new_items[i + 1] = item
                end
                return new_items
            end,
        }, local_opts or {})
        MiniPick.builtin.cli(local_opts, opts)
    end
end

vim.keymap.set('n', '<leader>ff', MiniPick.registry.files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live, { desc = '[F]ind [G]rep' })
