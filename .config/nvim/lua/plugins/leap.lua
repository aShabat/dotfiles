return {
    {
        "ggandor/leap.nvim",
        init = function ()
            local leap = require("leap")

            leap.opts.preview_filter = function (ch0, ch1, ch2)
                return not (
                    ch1:match('%s') or
                    ch0:match('%w') and ch1:match('%w') and ch2:match('%w')
                )
            end
        end
    },
}
