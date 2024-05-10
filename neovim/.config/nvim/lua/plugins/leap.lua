return {
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function ()
            local leap = require("leap")

            leap.opts.safe_labels = ""

            leap.opts.equivalence_classes = { " \t\r\n", "({[", ")}]", "!@#$%^&*=~:;+-_", "\'\"`" }

        end
    },
    {
        "ggandor/leap-spooky.nvim",
        lazy = false,
        opts = {
            extra_text_objects = {
                "ig", "ag",
                "iq", "aq",
                "ia", "aa",
                "if", "af",
                "iF", "aF",
            },
        },
        dependencies = {
            "ggandor/leap.nvim",
        },
    },
}
