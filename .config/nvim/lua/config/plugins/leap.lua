return {
    'ggandor/leap.nvim',
    config = function ()
        local leap = require'leap'
        leap.opts.equivalence_classes = { ' \t\r\n', '({[', ']})', '\'"`' }
        leap.opts.safe_labels = 'fnut/SFNLHMUGTZ?'
    end,
}
