local M = {}
local H = {}

-- My

vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { desc = 'Esc' })
vim.keymap.set('n', 'R', 'vc', { desc = '[R]eplace' })

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
    end
end, { nargs = '?', bang = true })

-- LSP

require('config.plugins.lsp').set_lsp_on_attach(function(buf)
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
end)

-- Git
local gitsigns = require 'gitsigns'
local nav_hunk = function(direction)
    gitsigns.nav_hunk(direction, {})
end

H.hydras.git = Hydra {
    name = 'LazyGit',
    mode = 'n',
    config = {
        invoke_on_body = true,
        color = 'pink',
    },
    heads = {
        {
            'n',
            function()
                nav_hunk 'next'
            end,
            {},
        },
        {
            'p',
            function()
                nav_hunk 'prev'
            end,
            {},
        },
        { 'q', '<CMD>q<CR>', {} },
        {
            'h',
            function()
                local line = vim.api.nvim_win_get_cursor(0)[1]
                gitsigns.stage_hunk { line, line }
            end,
            {},
        },
        { 'H', gitsigns.stage_hunk, {} },
        -- { 'P', gitsigns.preview_hunk, {} },
    },
}

require('config.plugins.git').set_git_on_attach(function(buf)
    local set = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
    end

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
    set('<leader>gg', function()
        H.hydras.git:activate()
    end)
end)

-- only for lazygit
vim.api.nvim_create_user_command('LazyGitEdit', function()
    H.hydras.git:activate()
end, {})

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
