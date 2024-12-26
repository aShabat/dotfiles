local M = {}

-- My
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- Mini
vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files)
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help)
vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers)
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live)

vim.keymap.set('n', '<leader>e', function ()
    require'config.mini'.hide_preview()
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
    local minilsp = function (scope)
        return function ()
            MiniExtra.pickers.lsp{ scope = scope }
        end
    end
    set('<leader>rn', vim.lsp.buf.rename)
    set('<leader>ca', require'fastaction'.code_action)
    set('gd', minilsp'definition')
    set('gD', vim.lsp.buf.declaration)
    set('gr', minilsp'references')
    set('gI', minilsp'implementation')
    set('<leader>D', minilsp'type_definition')
    set('<leader>ds', minilsp'document_symbol')
    set('<leader>ws', minilsp'workspace_symbol')
end

-- LuaSnip
local ls = require'luasnip'
vim.keymap.set({ 's', 'i' }, '<c-l>', function ()
                   if ls.expand_or_jumpable() then
                       ls.expand_or_jump()
                   end
               end, { silent = true })
vim.keymap.set({ 's', 'i' }, '<c-h>', function ()
                   if ls.jumpable(-1) then
                       ls.jump(-1)
                   end
               end, { silent = true })
vim.keymap.set({ 's', 'i' }, '<c-k>', function ()
    if ls.choice_active() then
        ls.change_choice()
    end
end)

-- Leap
vim.keymap.set('n', 'f', '<Plug>(leap)')
vim.keymap.set('n', 'F', '<Plug>(leap-from-window)')

-- UndoTree
vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<cr>')

-- Suda
vim.api.nvim_create_user_command('W', 'SudaWrite', {})

return M
