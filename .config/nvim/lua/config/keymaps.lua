local M = {}
local H = {}

-- My

vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { desc = 'Esc' })

vim.keymap.set('n', 'R', 'vc', { desc = '[R]eplace' })

vim.keymap.set('n', 'zw', '<CMD>set invwrap<CR>', { desc = 'Toggle [W]rap' })

-- Hydra

H.hydras = {}
local Hydra = require 'hydra'

-- TreeSitter

vim.keymap.set('n', '<SC-U>', require('treesitter-context').go_to_context)

-- Mini

vim.keymap.set('n', '<leader>ff', MiniPick.registry.files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live, { desc = '[F]ind [G]rep' })

vim.keymap.set('n', '<leader>e', require('config.mini').file_explorer, { desc = 'file [E]xplorer' })

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

-- LuaSnip

local ls = require 'luasnip'
vim.keymap.set({ 's', 'i' }, '<c-l>', function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true })
vim.keymap.set({ 's', 'i' }, '<c-h>', function()
    if ls.jumpable(-1) then ls.jump(-1) end
end, { silent = true })
vim.keymap.set({ 's', 'i' }, '<c-k>', function()
    if ls.choice_active() then ls.change_choice() end
end)

-- UndoTree

vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<cr>', { desc = '[U]ndo [T]ree' })

-- Suda

vim.api.nvim_create_user_command('W', 'SudaWrite', {})

-- QuickFix

vim.keymap.set('n', '<leader>qo', '<CMD>lclose<CR><CMD>copen<CR>', { desc = '[Q]uickFix [O]pen' })
vim.keymap.set('n', '<leader>qc', '<CMD>cclose<CR>', { desc = '[Q]uickFix [C]lose' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = '[Q]uickFix [N]ext' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = '[Q]uickFix [P]rev' })

H.hydras.qf = Hydra {
    name = 'QFlist',
    mode = 'n',
    body = '<leader>qq',
    config = {},
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
    config = {},
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
    local windows = vim.api.nvim_tabpage_list_wins(0)
    if #windows == 1 then return end
    local current_win = vim.api.nvim_tabpage_get_win(0)
    local current_index
    for index, window in ipairs(windows) do
        if window == current_win then current_index = index end
    end
    vim.api.nvim_tabpage_set_win(0, windows[(current_index % #windows) + 1])
end)

return M
