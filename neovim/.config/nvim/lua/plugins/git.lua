return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 0,
                ignore_whitespace = true,
            },
            numhl = true,
        },
    },
}
