return {
    'Saghen/blink.cmp',
    version = '*',
    dependencies = {
        -- 'rafamadriz/friendly-snippets',
        'echasnovski/mini.nvim',
    },
    opts = {
        keymap = {
            preset = 'default',
            ['<C-l>'] = { 'snippet_forward' },
            ['<C-h>'] = { 'snippet_backward' },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        sources = {
            default = { 'lsp', 'path', 'buffer' },
        },
        completion = {
            keyword = { range = 'prefix' },
            accept = { auto_brackets = { enabled = false } },
            documentation = { auto_show = true },
            list = { selection = 'auto_insert' },
            menu = {
                draw = {
                    columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function (ctx)
                                local kind_icon, _, _ = require'mini.icons'.get('lsp', ctx.kind)
                                return kind_icon
                            end,
                            highlight = function (ctx)
                                local _, hl, _ = require'mini.icons'.get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            text = function (ctx)
                                return '< ' .. ctx.kind .. ' >'
                            end,
                            highlight = function (ctx)
                                local _, hl, _ = require'mini.icons'.get('lsp', ctx.kind)
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
    },
    opts_extend = { 'sources.default' },
}
