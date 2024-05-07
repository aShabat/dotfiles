return {
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function ()
            local leap = require("leap")

            leap.opts.safe_labels = ""

        end
    },
    {
        "ggandor/leap-spooky.nvim",
        opts = {
        },
        dependencies = {
            "ggandor/leap.nvim",
        },
    },
}
