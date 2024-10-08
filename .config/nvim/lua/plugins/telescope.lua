return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "echasnovski/mini.nvim",
        "jvgrootveld/telescope-zoxide",
    },
    config = function ()
        local t = require("telescope")

        t.setup({
            defaults = {
                generic_sorter = require("mini.fuzzy").get_telescope_sorter,
                file_sorter = require("mini.fuzzy").get_telescope_sorter,
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
