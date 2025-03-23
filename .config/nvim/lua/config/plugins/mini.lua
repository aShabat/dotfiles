return {
    'echasnovski/mini.nvim',
    dependencies = {
        '3rd/image.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'snacks.nvim',
        {
            'MaximilianLloyd/ascii.nvim',
            dependencies = 'MunifTanjim/nui.nvim',
        },
        'GCBallesteros/NotebookNavigator.nvim',
    },
    config = function()
        require 'config.mini'
    end,
}
