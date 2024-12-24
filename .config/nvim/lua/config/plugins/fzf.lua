return {
    'ibhagwan/fzf-lua',
    opts = {
    },
    config = function (_, opts)
        local actions = require'fzf-lua'.actions
        opts.lsp = {
            jump_to_single_result = true,
            jump_to_single_result_action = actions.file_edit,
        }
        require'fzf-lua'.setup(opts)
    end,
}
