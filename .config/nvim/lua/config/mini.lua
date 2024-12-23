if vim.fn.filereadable(vim.fn.stdpath('config') .. '/lua/config/minibase16.lua') ~= 0 then
    dofile(vim.fn.stdpath('config') .. '/lua/config/minibase16.lua')
end
