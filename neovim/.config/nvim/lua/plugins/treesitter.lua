return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "bash", "fish" },
                auto_install = true,
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>is",
                        node_incremental = "+",
                        scope_incremental = "grc",
                        node_decremental = "-",
                    },
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
        },
    },
}
