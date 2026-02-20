-- luacheck: push ignore
local v = vim
-- luacheck: pop

local bufnr = v.api.nvim_get_current_buf()

v.keymap.set("n", "<leader>a", function()
	v.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

v.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		v.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)
