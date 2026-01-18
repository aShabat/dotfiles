local group = vim.api.nvim_create_augroup('cmdline_height', {})

local function set_cmd_height(height)
    if vim.opt.cmdheight ~= height then
        vim.opt.cmdheight = height
        vim.cmd.redraw()
    end
end

vim.api.nvim_create_autocmd('CmdlineEnter', {
    group = group,
    callback = function()
        set_cmd_height(1)
    end,
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
    group = group,
    callback = function()
        set_cmd_height(0)
    end,
})
