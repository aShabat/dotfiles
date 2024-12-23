-- FZF
local fzf = require'fzf-lua'
vim.keymap.set('n', '<leader>ff', fzf.files)
vim.keymap.set('n', '<leader>fh', fzf.helptags)

-- Mini
vim.keymap.set('n', '<leader>e', function ()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
    MiniFiles.trim_right()
end)
