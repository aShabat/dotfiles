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
            vim.g.molten_virt_lines_off_by_1 = true
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
