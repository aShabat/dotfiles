return {
    {
        'mbbill/undotree',
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<cr>', { desc = '[U]ndo [T]ree' })
        end,
    },
}
