-- luacheck: push ignore
local v = vim
-- luacheck: pop

return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local filetypes = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"rust",
			"vim",
			"vimdoc",
		}
		require("nvim-treesitter").install(filetypes)
		v.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				v.treesitter.start()
			end,
		})
	end,
}
