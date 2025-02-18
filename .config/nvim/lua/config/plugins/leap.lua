return {
    'ggandor/leap.nvim',
    config = function()
        local leap = require 'leap'
        leap.opts.equivalence_classes = { ' \t\r\n', '({[', ']})', '\'"`' }
        leap.opts.safe_labels = 'fnut/SFNLHMUGTZ?'

        vim.keymap.set({ 'v', 'n' }, 'f', '<Plug>(leap)', { desc = '[F]ind' })
        vim.keymap.set('n', 'F', '<Plug>(leap-from-window)', { desc = '[F]ind (other window)' })
    end,
}
