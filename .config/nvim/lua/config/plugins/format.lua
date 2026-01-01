return {
    'stevearc/conform.nvim',
    opts = {
        -- log_level = vim.log.levels.TRACE,
        formatters_by_ft = {
            lua = { 'stylua' },
            cpp = { 'clang-format' },
            go = { 'gofumpt' },
            clojure = { 'zprint' },
            python = { 'black' },
            -- markdown = { 'injected' },
            gleam = { 'gleam' },
            html = { 'prettier' },
            css = { 'prettier' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            ocaml = { 'ocamlformat' },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
        formatters = {
            injected = {
                options = {
                    ignore_errors = true,
                },
            },
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
                append_args = { '-style={BasedOnStyle: Google, IndentWidth: 4}' },
            },
            ['goimports-reviser'] = {
                prepend_args = {
                    '-rm-unused',
                    '-set-alias',
                    '-separate-named',
                },
            },
            zprint = {
                prepend_args = { '{:style :community}' },
            },
        },
    },
    config = function(_, opts)
        require('conform').setup(opts)

        vim.keymap.set('n', '<leader>F', require('conform').format, { desc = '[F]ormat' })
        vim.api.nvim_create_user_command('Format', function(_)
            require('conform').format()
        end, {})
    end,
}
