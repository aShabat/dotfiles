local H = {}

if not pcall(require, 'config.colors') then
    local base16 = require 'mini.base16'
    base16.setup { palette = base16.mini_palette('#112641', '#e2e98f', 75) }
end

H.palette = MiniBase16.config.palette
H.hl_configs = {
    LeapLabel = { opts = { fg = H.palette.base06, bg = H.palette.base0A } },
    LeapBackdrop = { opts = { italic = false }, overwrite = true },
    Comment = { opts = { italic = true } },
    Constant = { opts = { bold = true } },
    Conditional = { opts = { italic = true } },
    Repeat = { opts = { italic = true } },
    Keyword = { opts = { italic = true } },
    String = { opts = { italic = true, bold = true } },
    Boolean = { opts = { bold = true } },
}
for group, config in pairs(H.hl_configs) do
    local opts = config.opts
    if not config.overwrite then opts = vim.tbl_deep_extend('force', vim.api.nvim_get_hl(0, { name = group }), opts) end
    vim.api.nvim_set_hl(0, group, opts)
end
