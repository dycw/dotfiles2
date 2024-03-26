-- luacheck: push ignore vim
local cmd = vim.cmd
-- luacheck: pop

return {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    init = function()
        cmd.colorscheme("tokyonight-night")
        cmd.hi("Comment gui=none")
    end,
    priority = 1000, -- Make sure to load this before all the other start plugins.
}
