local H = {}

-- Enter triggers

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(args)
        --     if next(vim.fn.argv()) == nil and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == '' then
        --         MiniPick.registry.files { dirs = true }
        --     end
    end,
})

-- Disable relative numbers when in other window

H.relnum_disabled = {}
vim.api.nvim_create_autocmd('WinLeave', {
    callback = function(args)
        local win = vim.api.nvim_get_current_win()
        if vim.wo[win].relativenumber then
            H.relnum_disabled[win] = true
            vim.wo[win].relativenumber = false
        end
    end,
})

vim.api.nvim_create_autocmd('WinEnter', {
    callback = function(_)
        local win = vim.api.nvim_get_current_win()
        if H.relnum_disabled[win] then
            vim.wo[win].relativenumber = true
            H.relnum_disabled[win] = false
        end
    end,
})
