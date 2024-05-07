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
            extra_text_objects = {
                "ig", "ag",
            },
        },
        dependencies = {
            "ggandor/leap.nvim",
        },
    },
}
