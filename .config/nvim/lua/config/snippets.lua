local luasnip = require 'luasnip'
luasnip.setup {}

vim.keymap.set({ 's', 'i' }, '<c-l>', function()
    if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end, { silent = true })
vim.keymap.set({ 's', 'i' }, '<c-h>', function()
    if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, { silent = true })
vim.keymap.set({ 's', 'i' }, '<c-k>', function()
    if luasnip.choice_active() then luasnip.change_choice() end
end)

require('luasnip.loaders.from_lua').lazy_load {}
