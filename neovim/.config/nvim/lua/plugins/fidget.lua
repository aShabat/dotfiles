return {
    {
        "j-hui/fidget.nvim",
        config = function ()
            local fidget = require("fidget")
            fidget.setup({
            notification = {
                override_vim_notify = true,
                },
            })

            print = function ( ... )
                local args = { ... }

                fidget.notify("Print:  " .. table.concat(vim.tbl_map(tostring, args), " "))
            end
        end
    },
}
