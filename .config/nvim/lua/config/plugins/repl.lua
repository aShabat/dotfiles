return {
    {
        'Olical/conjure',
        init = function()
            vim.keymap.set({ 'n', 'v' }, ',', '<NOP>')
            vim.g['conjure#mapping#prefix'] = '<localleader>'
            vim.g['conjure#mapping#doc_word'] = 'K'
        end,
        config = function()
            vim.api.nvim_create_user_command('Clj', function()
                vim.system({ 'clj', '-M:repl/conjure' }, { stdin = true })
            end, {
                force = true,
            })
        end,
    },
}
