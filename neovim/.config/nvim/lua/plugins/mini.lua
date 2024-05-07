return {
    {
        "echasnovski/mini.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("mini.base16").setup({
                palette = require("user.minibase16-theme")
            })

            require("mini.ai").setup({
                custom_textobjects = {
                    -- Whole region
                    g = function ()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line("$"),
                            col = math.max(vim.fn.getline("$"):len(), 1)
                        }
                        return { from = from, to = to }
                    end
                },
            })

            require("mini.surround").setup({
            })

            require("mini.comment").setup({
            })

            require("mini.files").setup({
                options = {
                    use_as_default_explorer = true,
                },
                content = {
                    filter = function(fs_entry)
                        return not vim.startswith(fs_entry.name, '.')
                    end
                },
            })

            local miniFilesHelpers = require("user.minifileshelpers")
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function (args)
                    vim.keymap.set("n", "g~", miniFilesHelpers.files_set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })
                    vim.keymap.set("n", "g.", miniFilesHelpers.toggle_dotfiles, { buffer = args.data.buf_id, desc = "Toggle hidden" })
                    vim.keymap.set("n", "gp", miniFilesHelpers.toggle_preview, { buffer = args.data.buf_id, desc = "Toggle preview" })
                end,
            })

            require("mini.hipatterns").setup({
                highlighters = {
                    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })

            require("mini.move").setup({
                mappings = {
                    left = "H",
                    right = "L",
                    up = "K",
                    down = "J",

                    line_left = "",
                    line_right = "",
                    line_up = "",
                    line_down = "",
                },
            })

            require("mini.splitjoin").setup({
            })

            require("mini.trailspace").setup({
            })

            -- require("mini.jump2d").setup({
            -- })

            require("mini.statusline").setup({
                content = {
                },
            })
        end
    },
}
