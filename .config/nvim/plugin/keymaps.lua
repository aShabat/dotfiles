local M = {}
local H = {}

local Hydra = require 'hydra'
H.hydras = {}

-- My

vim.keymap.set('n', '<Esc>', '<cmd>noh<cr>', { desc = 'Esc' })

vim.keymap.set('n', 'R', 'vc', { desc = '[R]eplace' })

vim.keymap.set('n', 'zw', '<CMD>set invwrap<CR>', { desc = 'Toggle [W]rap' })

vim.keymap.set('n', '<C-q>', '<CMD>q<CR>', { desc = '[Q]uit' })

-- QuickFix

vim.keymap.set('n', '<leader>qo', '<CMD>lclose<CR><CMD>copen<CR>', { desc = '[Q]uickFix [O]pen' })
vim.keymap.set('n', '<leader>qc', '<CMD>cclose<CR>', { desc = '[Q]uickFix [C]lose' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = '[Q]uickFix [N]ext' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = '[Q]uickFix [P]rev' })

H.hydras.qf = Hydra {
    name = 'QFlist',
    mode = 'n',
    body = '<leader>qq',
    config = {
        invoke_on_body = true,
    },
    heads = {
        { 'n', '<CMD>cnext<CR>', {} },
        { 'p', '<CMD>cprev<CR>', {} },
        { 'o', '<CMD>copen<CR>', {} },
        { 'c', '<CMD>cclose<CR>', { exit = true } },
    },
}

-- LocList

vim.keymap.set('n', '<leader>lo', '<CMD>cclose<CR><CMD>lopen<CR>', { desc = '[L]oclist [O]pen' })
vim.keymap.set('n', '<leader>lc', '<CMD>lclose<CR>', { desc = '[L]oclist [C]lose' })
vim.keymap.set('n', '<leader>ln', '<CMD>lnext<CR>', { desc = '[L]oclist [N]ext' })
vim.keymap.set('n', '<leader>lp', '<CMD>lprev<CR>', { desc = '[L]oclist [P]rev' })

H.hydras.loc = Hydra {
    name = 'Loclist',
    mode = 'n',
    body = '<leader>ll',
    config = {
        invoke_on_body = true,
    },
    heads = {
        { 'n', '<CMD>lnext<CR>', {} },
        { 'p', '<CMD>lprev<CR>', {} },
        { 'o', '<CMD>lopen<CR>', {} },
        { 'c', '<CMD>lclose<CR>', { exit = true } },
    },
}

vim.keymap.set('n', '<leader>ld', function()
    vim.diagnostic.setloclist {}
end)

-- WinTab

vim.keymap.set('n', '<C-Tab>', function()
    local windows = {}
    for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(window)
        if vim.bo[buf].buftype ~= 'empty' and vim.bo[buf].buftype ~= 'nofile' then windows[#windows + 1] = window end
    end
    if #windows <= 1 then return end
    local current_win = vim.api.nvim_tabpage_get_win(0)
    local current_index
    for index, window in ipairs(windows) do
        if window == current_win then current_index = index end
    end
    vim.api.nvim_tabpage_set_win(0, windows[(current_index % #windows) + 1])
end)

vim.keymap.set('n', '<C-Esc>', '<C-W>o')

return M
