local H = {}

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
