-- luacheck: push ignore vim
local set = vim.keymap.set
-- luacheck: pop
local opts = { noremap = true, silent = true }

return {
    "monaqa/dial.nvim",
    config = function()
        set("n", "<C-a>", require("dial.map").inc_normal(), opts)
        set("n", "<C-x>", require("dial.map").dec_normal(), opts)
        set("v", "<C-a>", require("dial.map").inc_visual(), opts)
        set("v", "<C-x>", require("dial.map").dec_visual(), opts)
        set("v", "g<C-a>", require("dial.map").inc_gvisual(), opts)
        set("v", "g<C-x>", require("dial.map").dec_gvisual(), opts)
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.decimal_int,
                augend.integer.alias.hex,
                augend.integer.alias.octal,
                augend.integer.alias.binary,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%Y-%m-%d"],
                augend.date.alias["%H:%M:%S"],
                augend.date.alias["%H:%M"],
                augend.constant.alias.bool,
                augend.semver.alias.semver,
                augend.constant.new({
                    elements = { "True", "False" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "true", "false" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "&&", "||" },
                    word = true,
                    cyclic = true,
                }),
            },
        })
    end,
    event = "VeryLazy",
}
