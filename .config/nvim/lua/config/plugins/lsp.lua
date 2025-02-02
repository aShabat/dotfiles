return {
    {
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
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            usePlaceholders = true,
                        },
                    },
                },
                bashls = {},
                ts_ls = {},
                basedpyright = {},
                clangd = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require 'lspconfig'
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities, true)
                config.on_attach = function(event)
                    require('config.keymaps').set_lsp_keybinds(event.buf)
                end
                lspconfig[server].setup(config)
            end
        end,
    },
    {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        name = 'lsp_lines',
        config = function()
            local lsp_lines = require 'lsp_lines'
            lsp_lines.setup()
            vim.diagnostic.config {
                virtual_lines = {
                    only_current_line = function()
                        return vim.api.nvim_get_mode() == 'n'
                    end,
                },
            }
        end,
    },
}
