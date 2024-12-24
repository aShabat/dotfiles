local M = {}
-- My
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- FZF
local fzf = require'fzf-lua'
vim.keymap.set('n', '<leader>ff', fzf.files)
vim.keymap.set('n', '<leader>fh', fzf.helptags)
vim.keymap.set('n', '<leader>fb', fzf.buffers)
vim.keymap.set('n', '<leader>fg', fzf.grep)

-- Mini
vim.keymap.set('n', '<leader>e', function ()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
    MiniFiles.trim_right()
end)
vim.keymap.set('n', '<leader>gn', MiniNotify.show_history)
vim.keymap.set('n', '<leader>mts', MiniTrailspace.trim)
vim.keymap.set('n', '<leader>mtl', MiniTrailspace.trim_last_lines)

-- LSP
M.set_lsp_keybinds = function (buffer)
    local set = function (keys, func)
        vim.keymap.set('n', keys, func, { buffer = buffer })
    end
    set('<leader>rn', vim.lsp.buf.rename)
    set('<leader>ca', vim.lsp.buf.code_action)
    set('gd', fzf.lsp_definitions)
    set('gD', vim.lsp.buf.declaration)
    set('gr', fzf.lsp_references)
    set('gI', fzf.lsp_implementations)
    set('<leader>D', fzf.lsp_typedefs)
    set('<leader>ds', fzf.lsp_document_symbols)
    set('<leader>ws', fzf.lsp_live_workspace_symbols)
end

-- Leap
vim.keymap.set('n', 'f', '<Plug>(leap)')
vim.keymap.set('n', 'F', '<Plug>(leap-from-window)')

-- UndoTree
vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<cr>')

return M
