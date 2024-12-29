-- Start directory picker if in empty buffer
vim.schedule(function ()
    if next(vim.fn.argv()) == nil and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == '' then
        require'config.mini'.pick_files{ dirs = true }
    end
end)
