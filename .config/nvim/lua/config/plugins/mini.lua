return {
    'echasnovski/mini.nvim',
    dependencies = {
        '3rd/image.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require 'config.mini'
    end,
}
