local H = {}
H.saved_git_on_attach = function(_) end

return {
    'lewis6991/gitsigns.nvim',
    opts = {
        worktrees = {
            {
                toplevel = vim.env.HOME,
                gitdir = vim.env.HOME .. '/.config/dotfiles.git',
            },
        },
        -- signcolumn = false,
        numhl = true,
        diff_opts = {
            algorithm = 'histogram',
        },
        on_attach = function(buf)
            require('config.plugins.git').git_on_attach(buf)
        end,
    },
    git_on_attach = function(buf)
        H.saved_git_on_attach(buf)
    end,
    set_git_on_attach = function(func)
        H.saved_git_on_attach = func
    end,
}
