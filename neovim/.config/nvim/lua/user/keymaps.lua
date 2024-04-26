vim.keymap.set("n", "<leader> ", "<CMD>noh<CR>")

-- Oil

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

-- Telescope

local tb = require("telescope.builtin")
local is_inside_working_tree = {}
local smart_find_files = function(git_files, find_files) 
    local cwd = vim.fn.getcwd()
    if is_inside_working_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-working-tree")
        is_inside_working_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_working_tree[cwd] then
        return(git_files)
    else
        return(find_files)
    end
end

vim.keymap.set("n", "<leader>tf", smart_find_files(tb.git_files, tb.find_files))
vim.keymap.set("n", "<leader>th", tb.help_tags)
vim.keymap.set("n", "<leader>tb", tb.buffers)
