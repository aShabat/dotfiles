return {
    {
        "echasnovski/mini.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("mini.base16").setup({
                palette = require("user.minibase16-theme")
            })

            require("mini.ai").setup({
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

            local files_set_cwd = function (path)
                local cur_entry_path = MiniFiles.get_fs_entry().path
                local cur_directory = vim.fs.dirname(cur_entry_path)
                vim.fn.chdir(cur_directory)
            end

            local show_dot = false
            local filter_show = function(fs_entry)
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, '.')
            end
            local toggle_dotfiles = function()
                show_dot = not show_dot
                local filter = show_dot and filter_show or filter_hide
                MiniFiles.refresh({ content = { filter = filter } })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function (args)
                    vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })
                    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = args.data.buf_id, desc = "Toggle hidden" })
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

            require("mini.jump2d").setup({
            })
        end
    },
}
