return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "jvgrootveld/telescope-zoxide",
    },
    config = function ()
        local t = require("telescope")
        local z_utils = require("telescope._extensions.zoxide.utils")

        t.setup({
            defaults = {
                path_display = {
                    filename_first = {
                    },
                },
            },
            extensions = {
                zoxide = {
                    mappings = {
                        default = {
                            after_action = function(selection)
                                vim.fn.chdir(selection.path)
                                require("mini.files").open(selection.path)
                            end
                        },
                    },
                },
            },
        })
    end
}
