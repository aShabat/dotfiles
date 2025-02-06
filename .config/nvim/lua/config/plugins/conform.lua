return {
    'stevearc/conform.nvim',
    opts = {
        -- log_level = vim.log.levels.TRACE,
        formatters_by_ft = {
            lua = { 'stylua' },
            cmake = { 'gersemi' },
            cpp = { 'clang-format' },
            go = { 'gofumpt', 'goimports-reviser' },
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
                prepend_args = {
                    '--quote-style',
                    'AutoPreferSingle',
                    '--collapse-simple-statement',
                    'ConditionalOnly',
                    '--call-parentheses',
                    'None',
                    '--indent-type',
                    'Tabs',
                },
            },
            ['clang-format'] = {
                append_args = { '-style={IndentWidth: 4}' },
            },
            ['goimports-reviser'] = {
                prepend_args = {
                    '-rm-unused',
                    '-set-alias',
                    '-separate-named',
                },
            },
        },
    },
}
