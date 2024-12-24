vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(event)
        if vim.bo[event.buf].buftype == 'help' then
            vim.fn.feedkeys('zz')
        end
    end
})
