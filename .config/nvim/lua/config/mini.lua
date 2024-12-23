-- Base16
if vim.fn.filereadable(vim.fn.stdpath'config' .. '/lua/config/minibase16.lua') ~= 0 then
    dofile(vim.fn.stdpath'config' .. '/lua/config/minibase16.lua')
end

-- Files
require'mini.files'.setup{
    options = {
        use_as_default_explorer = true,
    },
    windows = {
        width_preview = 100,
    },
    mappings = {
        go_in = 'L',
        go_in_plus = 'l',
    },
}

-- Icons
require'mini.icons'.setup()
MiniIcons.mock_nvim_web_devicons()

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesActionRename',
    callback = function (event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})
