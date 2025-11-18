return {
    {
        'Olical/conjure',
        init = function()
            vim.keymap.set({ 'n', 'v' }, ',', '<NOP>')
            vim.g['conjure#mapping#prefix'] = '<localleader>'
            vim.g['conjure#mapping#doc_word'] = 'K'
        end,
    },
}
