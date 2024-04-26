return({
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "bash", "fish" },
                auto_install = true,
            })
        end
    },
})
