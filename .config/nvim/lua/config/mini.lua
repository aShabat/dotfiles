local M = {}

local H = {}
-- Extra
require'mini.extra'.setup{}
-- Base16
if vim.fn.filereadable(vim.fn.stdpath'config' .. '/lua/config/minibase16.lua') ~= 0 then
    dofile(vim.fn.stdpath'config' .. '/lua/config/minibase16.lua')
else
    local base16 = require'mini.base16'
    base16.setup{ palette = base16.mini_palette('#112641', '#e2e98f', 75) }
end

local palette = MiniBase16.config.palette
local hl_configs = {
    LeapLabel = { fg = palette.base05, bg = palette.base08 },
    Comment = { italic = true },
}
for group, config in pairs(hl_configs) do
    vim.api.nvim_set_hl(
        0,
        group,
        vim.tbl_extend('force', vim.api.nvim_get_hl(0, { name = group }), config)
    )
end


-- Coments
require'mini.comment'.setup{}

-- Icons
require'mini.icons'.setup()
MiniIcons.mock_nvim_web_devicons()

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesActionRename',
    callback = function (event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})

-- Git
require'mini.git'.setup{}

-- Hipatterns

local hipatterns = require'mini.hipatterns'

hipatterns.setup{
    highlighters = {
        fixme     = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
        hack      = { pattern = 'HACK', group = 'MiniHipatternsHack' },
        todo      = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
        note      = { pattern = 'NOTE', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
}

-- StatusLine
vim.opt.cmdheight = 0
vim.opt.showcmdloc = 'statusline'

require'mini.statusline'.setup{
    content = {
        active = function ()
            local reg_recording = vim.fn.reg_recording()
            if reg_recording ~= '' then
                reg_recording = 'Recording: @' .. reg_recording
            end
            local mode, mode_hl = MiniStatusline.section_mode{ trunc_width = 120 }
            local git           = MiniStatusline.section_git{ trunc_width = 40 }
            local diff          = MiniStatusline.section_diff{ trunc_width = 75 }
            local diagnostics   = MiniStatusline.section_diagnostics{ trunc_width = 75 }
            local lsp           = MiniStatusline.section_lsp{ trunc_width = 75 }
            local filename      = MiniStatusline.section_filename{ trunc_width = 140 }
            local fileinfo      = MiniStatusline.section_fileinfo{ trunc_width = 120 }
            local location      = MiniStatusline.section_location{ trunc_width = 75 }
            local search        = MiniStatusline.section_searchcount{ trunc_width = 75 }
            local showcmd       = vim.api.nvim_eval_statusline('%S', {}).str

            return MiniStatusline.combine_groups{
                { hl = 'MiniStatuslineDevinfo', strings = { reg_recording } },
                { hl = mode_hl,                 strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { search, location } },
                { hl = 'MiniStatuslineDevinfo',  strings = { showcmd } },
            }
        end,
    },
}

-- TrailSpace
require'mini.trailspace'.setup{}

-- Notify
require'mini.notify'.setup{}
vim.notify = MiniNotify.make_notify{
}

-- Files
local files_set_cwd = function (_)
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.fn.chdir(cur_directory)
end

local files_show_dot = false
local files_filter_show = function (_)
    return true
end
local files_filter_hide = function (fs_entry)
    return not vim.startswith(fs_entry.name, '.')
end

local files_toggle_dotfiles = function ()
    files_show_dot = not files_show_dot

    local filter = files_show_dot and files_filter_show or files_filter_hide
    MiniFiles.refresh{ content = { filter = filter } }
end

local files_show_preview = false
local files_toggle_preview = function ()
    files_show_preview = not files_show_preview
    MiniFiles.refresh{ windows = { preview = files_show_preview } }
    MiniFiles.trim_right()
end
M.hide_preview = function ()
    files_show_preview = false
end

require'mini.files'.setup{
    options = {
        use_as_default_explorer = true,
    },
    content = {
        filter = files_filter_hide,
    },
    windows = {
        width_preview = 100,
    },
    mappings = {
        go_in = 'L',
        go_in_plus = 'l',
    },
}

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function (args)
        vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd' })
        vim.keymap.set('n', 'g.', files_toggle_dotfiles, { buffer = args.data.buf_id, desc = 'Toggle hidden' })
        vim.keymap.set('n', 'gp', files_toggle_preview, { buffer = args.data.buf_id, desc = 'Toggle preview' })
    end,
})

-- Pick
require'mini.pick'.setup{
    mappings = {
        choose_marked = '<C-CR>',
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

H.pick_dirs_action = function ()
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
    MiniPick.set_picker_items_from_cli(
        { 'fd', '--type=d', '--no-follow', '--color=never' },
        {
            postprocess = function (items)
                local new_items = { '.' }
                for i, item in ipairs(items) do
                    new_items[i + 1] = item
                end
                return new_items
            end,
        })
end
H.pick_files_action = function ()
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
    MiniPick.set_picker_items_from_cli{ 'fd', '--type=f', '--no-follow', '--color=never' }
end
H.open_dir = function (item)
    local path = MiniPick.get_picker_opts().source.cwd .. '/' .. item
    vim.schedule(function ()
        MiniFiles.open(path, false)
    end)
end
M.pick_files = function (local_opts, opts)
    if not local_opts or not local_opts.dirs then
        opts = vim.tbl_deep_extend(
            'force',
            {
                mappings = {
                    toggle_files_dirs = {
                        char = '<c-d>',
                        func = H.pick_dirs_action,
                    },
                },
                source = {
                    name = 'Files/Dirs',
                },
            },
            opts or {}
        )
        MiniPick.builtin.files(local_opts, opts)
    else
        opts = vim.tbl_deep_extend(
            'force',
            {
                mappings = {
                    toggle_files_dirs = {
                        char = '<c-d>',
                        func = H.pick_files_action,
                    },
                },
                source = {
                    chose = H.open_dir,
                    name = 'Files/Dirs',
                    show = function (buf_id, items_to_show, query)
                        return MiniPick.default_show(buf_id, items_to_show, query, { show_icons = true })
                    end,
                },
            },
            opts or {}
        )
        local_opts = vim.tbl_deep_extend(
            'force',
            {
                command = { 'fd', '--type=d', '--no-follow', '--color=never' },
                postprocess = function (items)
                    local new_items = { '.' }
                    for i, item in ipairs(items) do
                        new_items[i + 1] = item
                    end
                    return new_items
                end,
            },
            local_opts or {})
        MiniPick.builtin.cli(local_opts, opts)
    end
end

-- Move
require'mini.move'.setup{
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
require'mini.splitjoin'.setup{}

-- AI
require'mini.ai'.setup{
    custom_textobjects = {
        -- Whole region
        G = function ()
            local from = { line = 1, col = 1 }
            local to = {
                line = vim.fn.line'$',
                col = math.max(vim.fn.getline'$':len(), 1),
            }
            return { from = from, to = to }
        end,
    },
}

-- Bracketed
require'mini.bracketed'.setup{
}

-- Surround
require'mini.surround'.setup{
}

return M
