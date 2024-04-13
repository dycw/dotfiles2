-- luacheck: push ignore vim
local api = vim.api
-- luacheck: pop

return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            lua = { "luacheck" },
            -- markdown = { "markdownlint" },
            python = { "ruff" },
            sh = { "shellcheck" },
        }

        -- Create autocommand which carries out the actual linting
        -- on the specified events.
        local lint_augroup = api.nvim_create_augroup("lint", { clear = true })
        api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
    event = "VeryLazy",
}
