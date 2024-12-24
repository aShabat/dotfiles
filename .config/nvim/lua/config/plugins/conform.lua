return {
    'stevearc/conform.nvim',
    opts = {
        default_format_opts = {
            lsp_format = 'fallback',
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
    },
}
