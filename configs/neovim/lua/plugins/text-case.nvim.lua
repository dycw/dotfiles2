-- luacheck: push ignore
local v = vim
-- luacheck: pop

return {
	"johmsalas/text-case.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("textcase").setup()
		v.keymap.set("n", "<Leader>su", "<Cmd>TextCaseStartReplacingCommand<CR>", { desc = "s[u]bstitute" })
		v.keymap.set("v", "<Leader>su", ":Subs/", { desc = "s[u]bstitute" })
	end,
	lazy = false,
}
