vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.signcolumn = 'auto:9'

vim.opt.clipboard = ''

vim.opt.cursorline = true

vim.opt.colorcolumn = '80'

vim.opt.autoread = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.api.nvim_set_var('python3_host_prog', vim.fn.stdpath 'config' .. '/.python/bin/python')
