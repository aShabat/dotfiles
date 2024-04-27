return({
    {
        "echasnovski/mini.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("mini.base16").setup({
                palette = {
                    base00 = "#151515",
                    base01 = "#202020",
                    base02 = "#303030",
                    base03 = "#505050",
                    base04 = "#B0B0B0",
                    base05 = "#D0D0D0",
                    base06 = "#E0E0E0",
                    base07 = "#F5F5F5",
                    base08 = "#AC4142",
                    base09 = "#D28445",
                    base0A = "#F4BF75",
                    base0B = "#90A959",
                    base0C = "#75B5AA",
                    base0D = "#6A9FB5",
                    base0E = "#AA759F",
                    base0F = "#8F5536",
                },
            })

            require("mini.ai").setup({
            })

            require("mini.comment").setup({
            })

            require("mini.files").setup({
                options = {
                    use_as_default_explorer = true,
                },
            })

            require("mini.hipatterns").setup({
                highlighters = {
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })

            require("mini.move").setup({
                mappings = {
                    left = "H",
                    right = "L",
                    up = "K",
                    down = "J",

                    line_left = "H",
                    line_right = "L",
                    line_up = "K",
                    line_down = "J",
                },
            })
        end
    },
})
