return {
    'lewis6991/gitsigns.nvim',
    dependencies = {
        'nvimtools/hydra.nvim',
    },
    config = function()
        require 'config.git'
    end,
}
