-- luacheck: push ignore
local v = vim
-- luacheck: pop

return {
	"stevearc/conform.nvim",
	-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
	cmd = { "ConformInfo" },
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			dart = { "dart_format" },
			elm = { "elm_format" },
			fish = { "fish_indent" },
			go = { "gofumpt" },
			htmldjango = { "djlint", "rustywind" },
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			sql = { "sql_formatter" },
			toml = { "taplo" },
			zig = { "zigfmt" },
			-- prettier
			css = { "prettier" },
			graphql = { "prettier" },
			json = { "prettier" },
			less = { "prettier" },
			markdown = { "prettier" },
			scss = { "prettier" },
			vue = { "prettier" },
			yaml = { "prettier" },
			-- prettier + rustywind
			html = { "prettier", "rustywind" },
			javascript = { "prettier", "rustywind" },
			javascriptreact = { "prettier", "rustywind" },
			typescript = { "prettier", "rustywind" },
			typescriptreact = { "prettier", "rustywind" },
			-- rest
			["*"] = { "trim_whitespace", "trim_newlines" },
		},
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 1000,
				lsp_fallback = not disable_filetypes[v.bo[bufnr].filetype],
			}
		end,
		formatters = {
			ruff_fix = {
				prepend_args = {
					"check",
					"--ignore=F401", -- unused-import
					"--unfixable=B007", -- unused-loop-control-variable
					"--unfixable=C411", -- unnecessary-list-call
					"--unfixable=C416", -- unnecessary-comprehension
					"--unfixable=F541", -- f-string-missing-placeholders
					"--unfixable=F601", -- multi-value-repeated-key-literal
					"--unfixable=F841", -- unused-variable
					"--unfixable=PERF102", -- incorrect-dict-iterator
					"--unfixable=PIE794", -- duplicated-class-field-definition
					"--unfixable=PLR5501", -- collapsible-else-if
					"--unfixable=PT014", -- pytest-duplicate-parametrize-test-cases
					"--unfixable=PYI016", -- duplicate-union-member
					"--unfixable=PYI018", -- unused-private-type-var
					"--unfixable=RET504", -- unnecessary-assign
					"--unfixable=RUF059", -- unused-unpacked-variable
					"--unfixable=SIM102", -- collapsible-if
					"--unfixable=SIM105", -- suppressible-exception
					"--unfixable=SIM114", -- if-with-same-arms
					"--unfixable=T201", -- print
				},
			},
			taplo = {
				append_args = {
					"--option",
					"indent_tables=true",
					"--option",
					"indent_entries=true",
					"--option",
					"reorder_keys=true",
					"--option",
					"reorder_inline_tables=true",
				},
			},
		},
		notify_on_error = true,
	},
}
