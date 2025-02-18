return {
    {
        'benlubas/molten-nvim',
        build = ':UpdateRemotePlugins',
        init = function()
            vim.g.molten_auto_open_output = true
            vim.g.molten_image_provider = 'image.nvim'
            vim.g.molten_image_location = 'float'
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
        end,
    },
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            {
                'jmbuhr/otter.nvim',
                opts = {},
            },
        },
        opts = {
            lspFeatures = {
                chunks = 'all',
            },
            codeRunner = {
                default_method = 'molten',
            },
        },
    },
    {
        'GCBallesteros/jupytext.nvim',
        opts = {
            style = 'markdown',
            output_extension = 'md',
            force_ft = 'markdown.pymd',
        },
    },
}
