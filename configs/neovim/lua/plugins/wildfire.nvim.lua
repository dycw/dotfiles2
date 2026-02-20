return {
	"sustech-data/wildfire.nvim",
	config = function()
		require("wildfire").setup()
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
}
