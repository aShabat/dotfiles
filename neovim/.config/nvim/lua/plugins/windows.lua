return {
    {
        "nvim-focus/focus.nvim",
        config = function ()
            require("focus").setup({
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
            })

            local ignore_filetypes = { "minifiles-help", }
            local ignore_buftypes = { "nofile", "prompt", "popup" }

            local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

            vim.api.nvim_create_autocmd("WinEnter", {
                group = augroup,
                callback = function (_)
                    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
                    then
                        vim.w.focus_disable = true
                    else
                        vim.w.focus_disable = false
                    end
                end,
                desc = "Disable focus auterosize for BufType",
            })

            vim.api.nvim_create_autocmd("FileType", {
                group = augroup,
                callback = function (_)
                    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                        vim.b.focus_disable = true
                    else
                        vim.b.focus_disable = false
                    end
                end,
                desc = "Disable focus autoresize for FileType",
            })
        end
    },
    {
        "sindrets/winshift.nvim",
        config = function ()
            require("winshift").setup({
            })
        end
    },
}
