return {
    {
        "nvim-focus/focus.nvim",
        opts = {
            autoresize = {
                enable = false,
            },
            ui = {
                hybridnumber = true,
                absolutenumber_unfocussed = true,
                colorcolumn = {
                    enable = false,
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
