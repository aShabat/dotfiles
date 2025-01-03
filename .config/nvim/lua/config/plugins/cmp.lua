return {
    'Saghen/blink.cmp',
    version = '*',
    dependencies = {
        -- 'rafamadriz/friendly-snippets',
        'echasnovski/mini.nvim',
        'L3MON4D3/LuaSnip',
    },
    opts = {
        keymap = {
            preset = 'default',
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        sources = {
            default = { 'lsp', 'path', 'buffer' },
        },
        snippets = {
            expand = function (snippet) require'luasnip'.lsp_expand(snippet) end,
            jump = function (direction) require'luasnip'.jump(direction) end,
            active = function (filter)
                if filter and filter.direction then
                    return require'luasnip'.jumpable(filter.direction)
                end
                return require'luasnip'.in_snippet()
            end,
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
