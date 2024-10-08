local M = {}

vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>")

-- MiniFiles

vim.keymap.set("n", "<leader>e", function()
    require("config.mini").hide_preview()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
    MiniFiles.trim_right()
end)

-- MiniTrailspace

vim.keymap.set("n", "<leader>mt", MiniTrailspace.trim)
vim.keymap.set("n", "<leader>mll", MiniTrailspace.trim_last_lines)

-- Telescope

local tb = require("telescope.builtin")
local is_inside_working_tree = {}
local smart_find_files = function(git_files, find_files)
    return function()
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

vim.keymap.set("n", "<leader>tz", require("telescope").extensions.zoxide.list)

-- Leap

vim.keymap.set("n", "f", "<Plug>(leap)")
vim.keymap.set("n", "F", "<Plug>(leap-from-window)")
vim.keymap.set({ "x", "o" }, "f", "<Plug>(leap-forward)")
vim.keymap.set({ "x", "o" }, "F", "<Plug>(leap-backward)")

vim.keymap.set("n", "gs", require("leap.remote").action)

local default_text_objects = {
    'iw', 'iW', 'is', 'ip', 'i[', 'i]', 'i(', 'i)', 'ib',
    'i>', 'i<', 'it', 'i{', 'i}', 'iB', 'i"', 'i\'', 'i`',
    'aw', 'aW', 'as', 'ap', 'a[', 'a]', 'a(', 'a)', 'ab',
    'a>', 'a<', 'at', 'a{', 'a}', 'aB', 'a"', 'a\'', 'a`',
}

-- Create remote versions of all native text objects by inserting `r`
-- into the middle (`iw` becomes `irw`, etc.):
for _, tobj in ipairs(default_text_objects) do
    vim.keymap.set({ 'x', 'o' }, tobj:sub(1, 1) .. 'r' .. tobj:sub(2), function()
        require('leap.remote').action({ input = tobj })
    end)
end

-- Lsp

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

-- Conform

vim.keymap.set({ "n", "v" }, "<leader>F", vim.lsp.buf.format)

-- UndoTree

vim.keymap.set("n", "<leader>ut", "<CMD>UndotreeToggle<CR>")

return M
