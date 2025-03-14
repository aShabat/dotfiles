return {
    {
        'GCBallesteros/NotebookNavigator.nvim',
        dependencies = {
            'echanovski/mini.nvim',
            'benlubas/molten-nvim',
            'nvimtools/hydra.nvim',
        },
        opts = {
            repl_provider = 'molten',
        },
        config = function(_, opts)
            local nn = require 'notebook-navigator'
            nn.setup(opts)

            vim.keymap.set('n', '<leader>rC', nn.run_cell, { desc = '[R]un [C]ell' })
            vim.keymap.set('n', '<leader>rc', nn.run_and_move, { desc = '[R]un [C]ell (and move to the next)' })

            require 'hydra' {
                name = 'Notebook Navigation',
                mode = 'n',
                body = '<leader>R',
                config = {
                    foreign_keys = 'warn',
                    invoke_on_body = true,
                    on_enter = function()
                        if #vim.fn.MoltenRunningKernels(true) == 0 then
                            vim.api.nvim_cmd({
                                cmd = 'MoltenInit',
                            }, {})
                        end
                    end,
                },
                heads = {
                    { 'r', nn.run_and_move, {} },
                    { 'o', nn.add_cell_below, {} },
                    { 'O', nn.add_cell_above, {} },
                    { 'c', nn.comment_cell, {} },
                    {
                        'j',
                        function()
                            nn.move_cell 'd'
                        end,
                        {},
                    },
                    {
                        'k',
                        function()
                            nn.move_cell 'u'
                        end,
                        {},
                    },
                },
            }
        end,
    },
    {
        'benlubas/molten-nvim',
        build = ':UpdateRemotePlugins',
        init = function()
            vim.g.molten_auto_open_output = true
            vim.g.molten_image_provider = 'image.nvim'
            vim.g.molten_image_location = 'float'
            vim.g.molten_wrap_output = false
            vim.g.molten_virt_text_output = true
            -- vim.g.molten_virt_lines_off_by_1 = true
        end,
        config = function()
            vim.keymap.set('n', '<leader>rI', '<CMD>MoltenInit<CR>', { desc = '[R]unner [I]nit' })
            vim.keymap.set('n', '<leader>rl', '<CMD>MoltenEvaluateLine<CR>', { desc = '[R]un [L]ine' })
            vim.keymap.set('n', '<leader>rr', '<CMD>MoltenReevaluateCell<CR>', { desc = '[R]e[R]un' })
            vim.keymap.set('n', '<leader>rd', '<CMD>MoltenDelete<CR>', { desc = '[R]unner [D]elete' })
            vim.keymap.set('n', '<leader>ri', '<CMD>MoltenInterrupt<CR>', { desc = '[R]unner [I]nterupt' })
            vim.keymap.set('n', '<leader>rR', '<CMD>MoltenRestart<CR>', { desc = '[R]unner [R]estart' })
            vim.keymap.set('v', '<leader>r', '<CMD>MoltenEvaluateVisual<CR>', { desc = '[R]un' })

            vim.keymap.set('n', '<leader>oe', '<CMD>noautocmd MoltenEnterOutput<CR>', { desc = '[O]utput [E]nter' })
            vim.keymap.set('n', '<leader>oh', '<CMD>MoltenHideOutput<CR>', { desc = '[O]utput [H]ide' })
            vim.keymap.set('n', '<leader>oi', '<CMD>MoltenImagePopup<CR>', { desc = '[O]pen [I]mage' })
        end,
    },
    {
        'GCBallesteros/jupytext.nvim',
        opts = {
            style = 'percent',
            output_extension = 'py',
        },
    },
}
