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
            require('config.keymaps').set_git_keybinds(buf)
        end,
    },
}
