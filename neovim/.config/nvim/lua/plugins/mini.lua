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
                    -- REMEMBER TO ADD TO leap-spooky AND [] MOTIONS IN user.keymaps

                    -- Whole region
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line("$"),
                            col = math.max(vim.fn.getline("$"):len(), 1)
                        }
                        return { from = from, to = to }
                    end,

                    -- function definition
                    F = require("mini.ai").gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner"
                    }),
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
                windows = {
                    width_preview = 100,
                },
                mappings = {
                    go_in = "L",
                    go_in_plus = "l",
                },
            })

            local miniFilesHelpers = require("user.minifileshelpers")
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    vim.keymap.set("n", "g~", miniFilesHelpers.files_set_cwd,
                        { buffer = args.data.buf_id, desc = "Set cwd" })
                    vim.keymap.set("n", "g.", miniFilesHelpers.toggle_dotfiles,
                        { buffer = args.data.buf_id, desc = "Toggle hidden" })
                    vim.keymap.set("n", "gp", miniFilesHelpers.toggle_preview,
                        { buffer = args.data.buf_id, desc = "Toggle preview" })
                end,
            })

            require("mini.hipatterns").setup({
                highlighters = {
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

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

            require("mini.statusline").setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local reg_recording = vim.fn.reg_recording()
                        if reg_recording ~= "" then
                            reg_recording = "Recording: @" .. reg_recording
                        end
                        local git         = MiniStatusline.section_git({ trunc_width = 75 })
                        local diff        = MiniStatusline.section_diff({ trunc_width = 75 })
                        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                        local lsp         = MiniStatusline.section_lsp({ trunc_width = 75 })
                        local filename    = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local location    = MiniStatusline.section_location({ trunc_width = 75 })
                        local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })
                        local showcmd     = vim.api.nvim_eval_statusline("%S", {}).str

                        return MiniStatusline.combine_groups({
                            { hl = 'MiniStatuslineDevinfo', strings = { reg_recording } },
                            { hl = mode_hl,                 strings = { mode } },
                            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                            '%<', -- Mark general truncate point
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=', -- End left alignment
                            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                            { hl = mode_hl,                  strings = { search, location } },
                            { hl = 'MiniStatuslineDevinfo',  strings = { showcmd } },
                        })
                    end
                },
            })

            require("mini.bracketed").setup({
                undo = { suffix = "" },
            })
        end
    },
}
