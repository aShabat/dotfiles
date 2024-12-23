return {
    'ggandor/leap.nvim',
    config = function ()
        require'leap'.opts = {
            equivalence_classes = { ' \t\r\n', '({[', ']})', '\'"`' },
            safe_labels = 'fnut/SFNLHMUGTZ?',
        }
    end,
}
