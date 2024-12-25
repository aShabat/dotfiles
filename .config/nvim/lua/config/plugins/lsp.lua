return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'saghen/blink.cmp',
        {
            'folke/lazydev.nvim',
            opts = {
                library = {
                    path = { '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
        {
            'Chaitanyabsprip/fastaction.nvim',
            opts = {
                dismiss_keys = { 'j', 'k', 'q', '<esc>' },
            },
        },
    },
    opts = {
        servers = {
            lua_ls = {},
            gopls = {},
        },
    },
    config = function (_, opts)
        local lspconfig = require'lspconfig'
        for server, config in pairs(opts.servers) do
            config.capabilities = require'blink.cmp'.get_lsp_capabilities(config.capabilities, true)
            config.on_attach = function (event)
                require'config.keymaps'.set_lsp_keybinds(event.buf)
            end
            lspconfig[server].setup(config)
        end
    end,
}
