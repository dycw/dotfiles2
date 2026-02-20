return {
	"folke/lazy.nvim",
	config = function()
		require("utilities").keymap_set("n", "<Leader>lu", "<Cmd>Lazy update<CR>", "Lazy [u]pdate")
	end,
	keys = {
		{ "<Leader>lu", "<Cmd>Lazy update<CR>", desc = "Lazy [u]pdate" },
	},
}
