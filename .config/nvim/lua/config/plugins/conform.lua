return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            cmake = { 'gersemi' },
            cpp = { 'clang-format' },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
        formatters = {
            stylua = {
                args = {
                    '--quote-style',
                    'AutoPreferSingle',
                    '--collapse-simple-statement',
                    'ConditionalOnly',
                    '--call-parentheses',
                    'None',
                    '--indent-type',
                    'Tabs',
                    '--',
                    '-',
                },
            },
            clangformat = {
                args = {},
            },
        },
    },
}
