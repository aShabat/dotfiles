-- Start directory picker if in empty buffer
if vim.fn.getreg'%' == '' then
    require'config.mini'.pick_files{ dirs = true }
end
