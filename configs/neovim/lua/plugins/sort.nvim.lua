return {
	"sqve/sort.nvim",
	config = function()
		local keymap_set = require("utilities").keymap_set
		keymap_set("v", "<Leader>so", "<Esc><Cmd>Sort<CR>", "S[o]rt")
		keymap_set("v", "<Leader>sn", "<Esc><Cmd>Sort n<CR>", "Sort [N]umbers")
	end,
}
