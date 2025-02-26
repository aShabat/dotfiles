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

vim.keymap.set('n', '<leader>mts', MiniTrailspace.trim, { desc = '[M]ini.[T]rail[S]pace' })
vim.keymap.set('n', '<leader>mtl', MiniTrailspace.trim_last_lines, { desc = '[M]ini.[T]rim[L]ines' })

-- Notify
require('mini.notify').setup {}
vim.notify = MiniNotify.make_notify {}

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

-- Files
require 'config.mini.files'

-- Pick
require 'config.mini.pick'

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
}

vim.api.nvim_create_user_command('MSWrite', function(args)
    local opts = {
        force = args.bang,
    }
    local name = args.fargs[1]
    if not name then
        opts = vim.tbl_deep_extend('force', opts, { force = true })
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

-- Starter
local starter = require 'mini.starter'
starter.setup {
    autoopen = true,
    evaluate_single = true,
    header = table.concat(require('ascii').get_random('text', 'neovim'), '\n'),
    items = {
        starter.sections.builtin_actions(),
        starter.sections.sessions(),
    },
    content_hooks = {
        starter.gen_hook.adding_bullet '•',
        starter.gen_hook.aligning('center', 'center'),
    },
}
