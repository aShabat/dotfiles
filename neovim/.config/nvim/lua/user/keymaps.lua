local M = {}

vim.keymap.set("n", "<leader> ", "<CMD>noh<CR>")

-- MiniAi

local map_previous = function(lhs, side, textobj_id)
    for _, mode in ipairs({ "n", "x", "o" }) do
        vim.keymap.set(mode, lhs, function() MiniAi.move_cursor(side, "a", textobj_id, { search_method = "prev" }) end)
    end
end

local map_next = function(lhs, side, textobj_id)
    for _, mode in ipairs({ "n", "x", "o" }) do
        vim.keymap.set(mode, lhs, function() MiniAi.move_cursor(side, "a", textobj_id, { search_method = "next" }) end)
    end
end

map_previous("[f", "left", "F")
map_previous("[F", "right", "F")
map_next("]f", "left", "F")
map_next("]F", "right", "F")

-- MiniFiles

vim.keymap.set("n", "<leader>e", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)

-- Telescope

local tb = require("telescope.builtin")
local is_inside_working_tree = {}
local smart_find_files = function(git_files, find_files)
    return function ()
        local cwd = vim.fn.getcwd()
        if is_inside_working_tree[cwd] == nil then
            vim.fn.system("git rev-parse --is-inside-working-tree")
            is_inside_working_tree[cwd] = vim.v.shell_error == 0
        end

        if is_inside_working_tree[cwd] then
            git_files({ show_untracked = true })
        else
            find_files({ hidden = true })
        end
    end
end

vim.keymap.set("n", "<leader>tf", smart_find_files(tb.git_files, tb.find_files))
vim.keymap.set("n", "<leader>th", tb.help_tags)
vim.keymap.set("n", "<leader>tb", tb.buffers)
vim.keymap.set("n", "<leader>tg", tb.live_grep)

-- LazyGit

vim.keymap.set("n", "<leader>lg", "<CMD>LazyGit<CR>")

-- MiniTrailSpace

vim.keymap.set("n", "<leader>mts", MiniTrailspace.trim)
vim.keymap.set("n", "<leader>mtl", MiniTrailspace.trim_last_lines)

-- LSP

M.map_lsp_keybinds = function(buffer_number)
    local lsp_map = function(keys, func)
        vim.keymap.set("n", keys, func, { buffer = buffer_number })
    end

    lsp_map("<leader>rn", vim.lsp.buf.rename)
    lsp_map("<leader>ca", vim.lsp.buf.code_action)
    lsp_map("<leader>gd", vim.lsp.buf.definition)

    lsp_map("gr", tb.lsp_references)
    lsp_map("gi", tb.lsp_implementations)
    lsp_map("<leader>bs", tb.lsp_document_symbols)
    lsp_map("<leader>ps", tb.lsp_workspace_symbols)

    lsp_map("<leader>F", vim.lsp.buf.format)

    lsp_map("K", vim.lsp.buf.hover)
    lsp_map("<leader>k", vim.lsp.buf.signature_help)
    lsp_map("gD", vim.lsp.buf.declaration)
    lsp_map("<leader>td", vim.lsp.buf.type_definition)
end

-- UndoTree

vim.keymap.set("n", "<leader>ut", "<CMD>UndotreeToggle<CR>")

-- Leap

vim.keymap.set("n", "f", "<Plug>(leap)")
vim.keymap.set("n", "F", "<Plug>(leap-from-window)")
vim.keymap.set({ "x", "o" }, "f", "<Plug>(leap-forward)")
vim.keymap.set({ "x", "o" }, "F", "<Plug>(leap-backward)")

return M
