local H = {}

local gitsigns = require 'gitsigns'
local nav_hunk = function(direction)
    vim.api.nvim_feedkeys('jk', 't', true)
    vim.schedule(function()
        gitsigns.nav_hunk(direction, { target = 'all' })
    end)
end

H.hydra = require 'hydra' {
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
        { 'P', gitsigns.preview_hunk, {} },
    },
}

H.on_attach = function(buf)
    local set = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
    end

    set('<leader>gp', gitsigns.preview_hunk, '[G]it [P]review')
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
        H.hydra:activate()
    end)
end

-- only for lazygit
vim.api.nvim_create_user_command('LazyGitEdit', function()
    H.hydra:activate()
end, {})

require('gitsigns').setup {
    worktrees = {
        {
            toplevel = vim.env.HOME,
            gitdir = vim.env.HOME .. '/.config/dotfiles.git',
        },
    },
    numhl = true,
    diff_opts = {
        algorithm = 'histogram',
    },
    on_attach = H.on_attach,
}
