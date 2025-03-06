vim.opt.scrolloff = 2
require('quarto').activate()

require('config.plugins.lsp').lsp_keymaps {}

local set = function(lhs, rhs, desc, opts)
    opts = vim.tbl_deep_extend('force', { desc = desc, silent = true, buffer = 0 }, opts or {})
    local mode = opts.mode or 'n'
    opts.mode = nil
    vim.keymap.set(mode, lhs, rhs, opts)
end

set(']c', function()
    if MiniAi.find_textobject('a', 'c', { search_method = 'next' }) then
        MiniAi.move_cursor('right', 'i', 'c', { search_method = 'next' })
    else
        vim.api.nvim_buf_set_lines(0, -1, -1, false, { '```python', '', '```', '' })
        vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0) - 2, 0 })
    end
    vim.api.nvim_input 'zz'
end, 'next [C]ell')
set('[c', function()
    MiniAi.move_cursor('right', 'i', 'c', { search_method = 'prev' })
    vim.api.nvim_input 'zz'
end, 'prev [C]ell')
set('gg', 'gg]c', 'gg', { remap = true })
set('G', 'G[c', 'G', { remap = true })

set('<leader>re', '<CMD>MoltenEvaluateOperator<CR>', '[R]unner [E]valuate')
set('<leader>rr', '<CMD>MoltenReevaluateCell<CR>', '[R]unner [R]eevaluate')
set('<leader>rmd', '<CMD>MoltenDelete<CR>', '[R]unner [M]olten [D]elete')
set('<leader>rR', '<CMD>MoltenRestart!<CR>', '[R]unner [R]estart')
set('<leader>rS', '<CMD>MoltenInterrupt<CR>', '[R]unner [S]top')
set('<leader>oc', '<CMD>MoltenHideOutput<CR>', '[O]utput [C]lose')
set('<leader>oe', 'zt<CMD>sleep 10m<CR><CMD>noautocmd MoltenEnterOutput<CR>', '[O]utput [E]nter')
set('<leader>oi', '<CMD>MoltenImagePopup<CR>', '[O]utput [I]mage')

local runner = require 'quarto.runner'
vim.b.runner = runner
set('<leader>rc', runner.run_cell, '[R]un [C]ell')
set('<leader>ra', runner.run_above, '[R]un [A]bove')
set('<leader>rb', runner.run_below, '[R]un [B]elow')
set('<leader>rA', runner.run_all, '[R]un [A]ll')
set('<leader>r', runner.run_range, '[R]un', { mode = 'v' })

vim.cmd 'MoltenInit'
