local H = {}

H.lsp_keymaps = function(event)
    local buf = event.buf
    local set = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
    end
    local minilsp = function(scope)
        return function()
            MiniExtra.pickers.lsp { scope = scope }
        end
    end
    set('<leader>rn', vim.lsp.buf.rename)
    set('<leader>ca', require('fastaction').code_action, '[C]ode [A]ctions')
    set('gd', minilsp 'definition', '[G]et [D]efinition')
    set('gD', vim.lsp.buf.declaration, '[G]et [D]eclaration')
    set('gr', minilsp 'references', '[G]et [R]eferences')
    set('gI', minilsp 'implementation', '[G]et [I]mplementation')
    set('<leader>D', minilsp 'type_definition', '[D]efinition')
    set('<leader>ds', minilsp 'document_symbol', '[D]ocument [S]ymbols')
    set('<leader>ws', minilsp 'workspace_symbol', '[W]orkspace [S]ymbols')
end

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
                config.on_attach = H.lsp_keymaps
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
    lsp_keymaps = H.lsp_keymaps,
}
