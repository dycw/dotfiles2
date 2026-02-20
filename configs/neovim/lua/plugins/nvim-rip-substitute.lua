return {
	"chrisgrieser/nvim-rip-substitute",
	cmd = "RipSubstitute",
	event = "VeryLazy",
	keys = {
		{
			"<leader>fs",
			function()
				require("rip-substitute").sub()
			end,
			mode = { "n", "x" },
			desc = "rip [s]ubstitute",
		},
	},
}
