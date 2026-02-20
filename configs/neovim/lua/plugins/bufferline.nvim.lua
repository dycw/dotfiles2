return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Buffer next" },
		{ "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Buffer prev" },
	},
	opts = {
		options = {
			always_show_bufferline = true,
			show_buffer_icons = false,
			show_buffer_close_icons = false,
			show_close_icon = false,
		},
	},
	version = "*",
}
