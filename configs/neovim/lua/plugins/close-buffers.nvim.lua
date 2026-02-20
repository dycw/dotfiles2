return {
	"kazhala/close-buffers.nvim",
	keys = {
		{
			"<Leader>bd",
			function()
				require("close_buffers").delete({ type = "this" })
			end,
			desc = "buffer [d]elete",
		},
		{
			"<Leader>bo",
			function()
				require("close_buffers").delete({ type = "other" })
			end,
			desc = "buffer [o]thers",
		},
	},
}
