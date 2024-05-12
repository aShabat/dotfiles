return {
    {
        "nvim-focus/focus.nvim",
        opts = {
            ui = {
                hybridnumber = true,
                absolutenumber_unfocussed = true,
                colorcolumn = {
                    enable = true,
                },
            },
        },
    },
    {
        "sindrets/winshift.nvim",
        config = function ()
            require("winshift").setup({
            })
        end
    },
}
