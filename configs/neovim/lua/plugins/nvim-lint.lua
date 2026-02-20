-- luacheck: push ignore
local v = vim
-- luacheck: pop

return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			haskell = { "hlint" },
			lua = { "luacheck" },
			python = { "ruff" },
			sh = { "shellcheck" },
			sql = { "sqlfluff" },
			zsh = { "shellcheck" },
		}

		local ruff_linter = lint.linters.ruff
		local function get_file_name()
			return v.api.nvim_buf_get_name(0)
		end
		ruff_linter.args = {
			"check",
			"--force-exclude",
			"--quiet",
			"--stdin-filename",
			get_file_name,
			"--no-fix",
			"--output-format",
			"json",
			"--ignore=F401", --unused-import
			"-",
		}

		local lint_augroup = v.api.nvim_create_augroup("lint", { clear = true })
		v.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
