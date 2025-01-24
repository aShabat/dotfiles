return {
	'echasnovski/mini.nvim',
	dependencies = {
		'3rd/image.nvim',
		'nvim-treesitter/nvim-treesitter',
	},
	config = function()
		require 'config.mini'
	end,
}
