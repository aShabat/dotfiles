-- Deps
local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd 'echo "Installing `mini.nvim`" | redraw'
    local clone_cmd = {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim',
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd 'packadd mini.nvim | helptags ALL'
    vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup { path = { package = path_package } }

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

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    add 'folke/snacks.nvim'
    require('snacks').setup {
        bigfile = { enable = true },
        quickfile = { enable = true },
    }
end)

now(function()
    add 'nvim-treesitter/nvim-treesitter'
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        highlight = {
            enable = true,
        },
    }
    add 'nvim-treesitter/nvim-treesitter-context'
    require('treesitter-context').setup {}
end)

later(function()
    add 'ggandor/leap.nvim'
    local leap = require 'leap'
    leap.opts.equivalence_classes = { ' \t\r\n', '({[', ']})', '\'"`' }
    leap.opts.safe_labels = 'fnut/SFNLHMUGTZ?'
end)

-- Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- Keymaps
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- Leap
vim.keymap.set('n', 'f', '<Plug>(leap)')
vim.keymap.set('n', 'F', '<Plug>(leap-from-window)')

-- Catppuccin
now(function()
    add { source = 'catppuccin/nvim', name = 'catppuccin' }
    require('catppuccin').setup {
        flavor = 'latte',
    }
    vim.cmd.colorscheme 'catppuccin'
end)
