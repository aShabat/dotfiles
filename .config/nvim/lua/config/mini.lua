local M = {}

-- Base16

if vim.fn.filereadable(vim.fn.stdpath('config') .. '/lua/config/minibase16.lua') ~= 0 then
    dofile(vim.fn.stdpath('config') .. '/lua/config/minibase16.lua')
end

-- Files

local files_set_cwd = function(path)
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    vim.fn.chdir(cur_directory)
end

local files_show_dot = false
local files_filter_show = function(fs_entry)
    return true
end
local files_filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end
local files_toggle_dotfiles = function()
    files_show_dot = not files_show_dot

    local filter = files_show_dot and files_filter_show or files_filter_hide
    MiniFiles.refresh({ content = { filter = filter } })
end

local files_show_preview = false
local files_toggle_preview = function()
    files_show_preview = not files_show_preview
    MiniFiles.refresh({ windows = { preview = files_show_preview } })
    MiniFiles.trim_right()
end
M.hide_preview = function()
    files_show_preview = false
end

require("mini.files").setup({
    options = {
        use_as_default_explorer = true,
    },
    content = {
        filter = files_filter_hide,
    },
    windows = {
        width_preview = 100,
    },
    mappings = {
        go_in = "L",
        go_in_plus = "l",
    },
})

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })
        vim.keymap.set("n", "g.", files_toggle_dotfiles, { buffer = args.data.buf_id, desc = "Toggle hidden" })
        vim.keymap.set("n", "gp", files_toggle_preview, { buffer = args.data.buf_id, desc = "Toggle preview" })
    end
})

-- SplitJoin

require("mini.splitjoin").setup({
    mappings = {
        toggle = "",
        split = "<leader>ms",
        join = "<leader>mj",
    },
    join = {
        hooks_post = { require("mini.splitjoin").gen_hook.pad_brackets({ brackets = { "%b{}" } }), },
    },
})

-- TrailSpace

require("mini.trailspace").setup()

-- Git

require("mini.git").setup()

-- Diff

require("mini.diff").setup()

-- Statusline

vim.opt.cmdheight = 0
vim.opt.showcmdloc = "statusline"

require("mini.statusline").setup({
    content = {
        active = function()
            local reg_recording = vim.fn.reg_recording()
            if reg_recording ~= "" then
                reg_recording = "Recording: @" .. reg_recording
            end
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 40 })
            local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
            local showcmd       = vim.api.nvim_eval_statusline("%S", {}).str

            return MiniStatusline.combine_groups({
                { hl = "MiniStatuslineDevinfo", strings = { reg_recording } },
                { hl = mode_hl,                 strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { search, location } },
                { hl = "MiniStatuslineDevinfo",  strings = { showcmd } },
            })
        end
    },
})

-- AI and Surround
require("mini.ai").setup({
    custom_textobjects = {
        -- Whole region
        G = function()
            local from = { line = 1, col = 1 }
            local to = {
                line = vim.fn.line("$"),
                col = math.max(vim.fn.getline("$"):len(), 1)
            }
            return { from = from, to = to }
        end,
    },
})

require("mini.surround").setup()

-- Indentcsope

require("mini.indentscope").setup({
    draw = {
        animation = require("mini.indentscope").gen_animation.none()
    },
    symbol = ""
})


-- Clue

local miniclue = require("mini.clue")

miniclue.setup({
    triggers = {
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        { mode = "n", keys = "<C-w>" },

        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },
    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    }
})

-- Move

require("mini.move").setup()

-- Hipatterns

local hipatterns = require("mini.hipatterns")

hipatterns.setup({
    highlighters = {
        fixme     = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
        hack      = { pattern = 'HACK', group = 'MiniHipatternsHack' },
        todo      = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
        note      = { pattern = 'NOTE', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

-- Icons

require("mini.icons").setup()

return M
