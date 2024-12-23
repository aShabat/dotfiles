-- FZF
local fzf = require'fzf-lua'
vim.keymap.set('n', '<leader>ff', fzf.files)
vim.keymap.set('n', '<leader>fh', fzf.helptags)
