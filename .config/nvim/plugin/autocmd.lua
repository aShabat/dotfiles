local H = {}

-- Enter triggers

-- vim.api.nvim_create_autocmd('VimEnter', {
--     callback = function(args)
--         vim.schedule(function()
--             if vim.fn.argc() == 0 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == '' then
--                 vim.bo.buflisted = false
--                 MiniPick.registry.files { dirs = true }
--             end
--         end)
--     end,
-- })

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

-- Config .ipynb files

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesActionCreate',
    callback = function(args)
        local file_name = args.data.to
        if not file_name:match '%.ipynb$' then return end

        local file = io.open(file_name, 'w')
        if file then
            file:write(H.default_notebook)
            file:close()
        else
            vim.notify "Couldn't rewrite .ipyng file"
        end
    end,
})

H.default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

vim.api.nvim_create_autocmd('User', {
    pattern = 'LuasnipPreExpand',
    callback = function()
        local snippet = require('luasnip').session.event_node
        local docstring = snippet:get_docstring()
        if not docstring[#docstring]:match '%$0$' then
            local luasnip = require 'luasnip'
            local s = luasnip.s
            local i = luasnip.i
            local t = luasnip.t
            luasnip.snip_expand(s('surrounding snippet', { t { '', '' }, i(0) }))
        end
    end,
})
