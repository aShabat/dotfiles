local H = {}
H.saved_lsp_on_attach = function(_) end
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
                            usePlaceholders = true,
                        },
                    },
                },
                bashls = {},
                ts_ls = {},
                basedpyright = {
                    basedpyright = {
                        analysis = {
                            diagnosticSeverityOverrides = {
                                reportUnusedExpression = 'none',
                            },
                        },
                    },
                },
                clangd = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require 'lspconfig'
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities, true)
                config.on_attach = function(event)
                    require('config.plugins.lsp').lsp_on_attach(event.buf)
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
    lsp_on_attach = function(buf)
        H.saved_lsp_on_attach(buf)
    end,
    set_lsp_on_attach = function(func)
        H.saved_lsp_on_attach = func
    end,
}
