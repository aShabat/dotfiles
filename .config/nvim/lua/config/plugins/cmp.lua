return {
    'Saghen/blink.cmp',
    version = '*',
    dependencies = {
        'rafamadriz/friendly-snippets',
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
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        completion = {
            keyword = { range = 'prefix' },
            accept = { auto_brackets = { enabled = false } },
            documentation = { auto_show = true },
        },
        signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
}
