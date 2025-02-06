local M = {}

-- My

vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { desc = 'Esc' })

-- Mini

vim.keymap.set('n', '<leader>ff', MiniPick.registry.files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live, { desc = '[F]ind [G]rep' })

vim.keymap.set('n', '<leader>e', require('config.mini').file_explorer, { desc = 'file [E]xplorer' })

vim.keymap.set('n', '<leader>gn', MiniNotify.show_history, { desc = '[G]et [N]otifications' })

vim.keymap.set('n', '<leader>mts', MiniTrailspace.trim, { desc = '[M]ini.[T]rail[S]pace' })
vim.keymap.set('n', '<leader>mtl', MiniTrailspace.trim_last_lines, { desc = '[M]ini.[T]rim[L]ines' })

-- LSP

M.set_lsp_keybinds = function(buf)
    local set = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
    end
    local minilsp = function(scope)
        return function()
            MiniExtra.pickers.lsp { scope = scope }
        end
    end
    set('<leader>rn', vim.lsp.buf.rename)
    set('<leader>ca', require('fastaction').code_action, '[C]ode [A]ctions')
    set('gd', minilsp 'definition', '[G]et [D]efinition')
    set('gD', vim.lsp.buf.declaration, '[G]et [D]eclaration')
    set('gr', minilsp 'references', '[G]et [R]eferences')
    set('gI', minilsp 'implementation', '[G]et [I]mplementation')
    set('<leader>D', minilsp 'type_definition', '[D]efinition')
    set('<leader>ds', minilsp 'document_symbol', '[D]ocument [S]ymbols')
    set('<leader>ws', minilsp 'workspace_symbol', '[W]orkspace [S]ymbols')
end

-- Git

M.set_git_keybinds = function(buf)
    local set = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
    end
    local gitsigns = require 'gitsigns'

    set('<leader>gp', gitsigns.preview_hunk_inline, '[G]it [P]review')
    set('<leader>gb', gitsigns.toggle_current_line_blame)
    vim.keymap.set('v', 'gh', function()
        local line_start = vim.fn.getpos("'<")[2]
        local line_end = vim.fn.getpos("'>")[2]
        gitsigns.stage_hunk { line_start, line_end }
    end, { buffer = buf, desc = '[G]it [B]lame' })
    set('ghh', function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        gitsigns.stage_hunk { line, line }
    end, '[G]it stage line ')
    set('ghH', gitsigns.stage_hunk, '[G]it stage [H]unk')

    local nav_hunk = function(direction)
        gitsigns.nav_hunk(direction, {
            preview = true,
        })
    end
    set(']h', function()
        nav_hunk 'next'
    end)
    set('[h', function()
        nav_hunk 'prev'
    end)
    set('[H', function()
        nav_hunk 'first'
    end)
    set(']H', function()
        nav_hunk 'last'
    end)
end

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

-- Leap

vim.keymap.set('n', 'f', '<Plug>(leap)', { desc = '[F]ind' })
vim.keymap.set('n', 'F', '<Plug>(leap-from-window)', { desc = '[F]ind (other window)' })

-- UndoTree

vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<cr>', { desc = '[U]ndo [T]ree' })

-- Suda

vim.api.nvim_create_user_command('W', 'SudaWrite', {})

-- QuickFix

vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = '[Q]uickFix [O]pen' })
vim.keymap.set('n', '<leader>qc', '<CMD>cclose<CR>', { desc = '[Q]uickFix [C]lose' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = '[Q]uickFix [N]ext' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = '[Q]uickFix [P]rev' })

-- LocList

vim.keymap.set('n', '<leader>lo', '<CMD>lopen<CR>', { desc = '[L]oclist [O]pen' })
vim.keymap.set('n', '<leader>lc', '<CMD>lclose<CR>', { desc = '[L]oclist [C]lose' })
vim.keymap.set('n', '<leader>ln', '<CMD>lnext<CR>', { desc = '[L]oclist [N]ext' })
vim.keymap.set('n', '<leader>lp', '<CMD>lprev<CR>', { desc = '[L]oclist [P]rev' })

return M
