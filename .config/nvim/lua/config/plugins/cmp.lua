return {
    'Saghen/blink.cmp',
    version = '*',
    dependencies = {
        'echasnovski/mini.nvim',
        'L3MON4D3/LuaSnip',
    },
    opts = {
        keymap = {
            preset = 'default',

            ['<Tab>'] = {},
            ['<S-Tab>'] = {},
            ['<C-k>'] = {},
            ['<Up>'] = {},
            ['<Down>'] = {},
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        sources = {
            default = { 'lsp', 'path', 'buffer' },
            providers = {
                path = {
                    opts = {
                        show_hidden_files_by_default = true,
                    },
                },
            },
        },
        snippets = { preset = 'luasnip' },
        completion = {
            keyword = { range = 'full' },
            accept = { auto_brackets = { enabled = false } },
            documentation = { auto_show = true },
            menu = {
                draw = {
                    columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                return kind_icon
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            text = function(ctx)
                                return '< ' .. ctx.kind .. ' >'
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
        },
        signature = {
            enabled = true,
            window = { direction_priority = { 'n', 's' } },
        },
        cmdline = {
            completion = {
                menu = {
                    auto_show = true,
                },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
