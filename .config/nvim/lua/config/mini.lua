local M = {}

local H = {}
-- Extra
require('mini.extra').setup {}
-- Base16
require 'config.mini.base16'
-- Coments
require('mini.comment').setup {}

-- Icons
require('mini.icons').setup {}
MiniIcons.mock_nvim_web_devicons()

-- Git
require('mini.git').setup {}

-- -- Diff
-- require('mini.diff').setup {}

-- Hipatterns

local hipatterns = require 'mini.hipatterns'

hipatterns.setup {
    highlighters = {
        fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
        hack = { pattern = 'HACK', group = 'MiniHipatternsHack' },
        todo = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
        note = { pattern = 'NOTE', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
}

-- StatusLine
vim.opt.cmdheight = 0
vim.opt.showcmdloc = 'statusline'

require('mini.statusline').setup {
    content = {
        active = function()
            local reg_recording = vim.fn.reg_recording()
            if reg_recording ~= '' then reg_recording = 'Recording: @' .. reg_recording end
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = MiniStatusline.section_location { trunc_width = 75 }
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }
            local showcmd = vim.api.nvim_eval_statusline('%S', {}).str

            return MiniStatusline.combine_groups {
                { hl = 'MiniStatuslineDevinfo', strings = { reg_recording } },
                { hl = mode_hl, strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl, strings = { search, location } },
                { hl = 'MiniStatuslineDevinfo', strings = { showcmd } },
            }
        end,
    },
}

-- TrailSpace
require('mini.trailspace').setup {}

-- Notify
require('mini.notify').setup {}
vim.notify = MiniNotify.make_notify {}

-- Files
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
        if synced then MiniFiles.go_in { close_on_file = true } end
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

-- Pick

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

-- Move
require('mini.move').setup {
    mappings = {
        left = 'H',
        right = 'L',
        up = 'K',
        down = 'J',
        line_left = '',
        line_right = '',
        line_up = '<C-k>',
        line_down = '<C-j>',
    },
}

-- SplitJoin
require('mini.splitjoin').setup {}

-- AI

local ai = require 'mini.ai'
ai.setup {
    custom_textobjects = {
        -- Whole region
        G = MiniExtra.gen_ai_spec.buffer(),
        L = MiniExtra.gen_ai_spec.line(),
        c = ai.gen_spec.treesitter { a = '@code_cell.outer', i = '@code_cell.inner' },
    },
    search_method = 'cover',
    n_lines = math.huge,
}

-- Bracketed
require('mini.bracketed').setup {
    diagnostic = {
        options = { float = false },
    },
}

-- Surround
require('mini.surround').setup {}

--Clue

local miniclue = require 'mini.clue'
miniclue.setup {
    triggers = {
        { mode = 'n', keys = '`' },
        { mode = 'n', keys = "'" },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    clues = {
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows {
            submode_move = true,
            submode_navigate = true,
            submode_resize = true,
        },
        miniclue.gen_clues.z(),
    },
    window = {
        config = {
            width = 'auto',
        },
    },
}

-- Sessions

require('mini.sessions').setup {
    file = '.session.vim',
    autoread = true,
}

vim.keymap.set('n', '<leader>ff', MiniPick.registry.files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live, { desc = '[F]ind [G]rep' })

vim.keymap.set('n', '<leader>e', H.file_explorer, { desc = 'file [E]xplorer' })

vim.keymap.set('n', '<leader>mnh', function()
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines
    local win = vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
        relative = 'editor',
        width = math.floor(editor_width * 0.9),
        height = math.floor(editor_height * 0.8),
        row = math.floor(editor_height * 0.05),
        col = math.floor(editor_width * 0.05),
        border = 'single',
        title = { { 'Notification History', 'MiniFilesTitle' } },
    })
    MiniNotify.show_history()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD>q<CR>', {})
end, { desc = '[M]ini.[N]otify [H]istory' })

vim.keymap.set('n', '<leader>mts', MiniTrailspace.trim, { desc = '[M]ini.[T]rail[S]pace' })
vim.keymap.set('n', '<leader>mtl', MiniTrailspace.trim_last_lines, { desc = '[M]ini.[T]rim[L]ines' })

vim.api.nvim_create_user_command('MSWrite', function(args)
    local opts = {
        force = args.bang,
    }
    local name = args.fargs[1]
    if not name then
        if vim.api.nvim_get_vvar 'this_session' == '' then
            MiniSessions.write(MiniSessions.config.file, opts)
        else
            MiniSessions.write(nil, opts)
        end
    else
        MiniSessions.write(name, opts)
        local local_session =
            vim.fn.confirm('Link project in ' .. vim.fn.getcwd() .. ' to session "' .. name .. '"?', '&Yes\n&No')
        if local_session == 1 then
            local cmd = {
                'ln',
                '-s',
                MiniSessions.config.directory .. '/' .. name,
                vim.fn.getcwd() .. '/' .. MiniSessions.config.file,
            }
            vim.system(cmd, {}, nil):wait()
        end
    end
end, { nargs = '?', bang = true })

return M
