return {
    {
        'nvim-treesitter/nvim-treesitter',
        main = 'nvim-treesitter.configs',
        opts = {
            auto_install = true,
            ensure_installed = 'all',
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    node_incremental = '+',
                    scope_incremental = '*',
                    node_decremental = '-',
                },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function(_, opts)
            local context = require 'treesitter-context'
            context.setup(opts)
            vim.keymap.set({ 'n', 'v', 'o' }, '<SC-U>', context.go_to_context)
        end,
    },
}
