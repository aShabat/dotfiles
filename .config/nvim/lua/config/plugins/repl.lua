return {
    {
        'Olical/conjure',
        init = function()
            vim.keymap.set({ 'n', 'v' }, ',', '<NOP>')
            vim.g['conjure#mapping#prefix'] = ','
        end,
    },
}
