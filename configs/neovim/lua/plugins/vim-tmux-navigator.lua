return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	event = "VeryLazy",
	keys = {
		{ "<C-h>", "<Cmd><C-U>TmuxNavigateLeft<CR>" },
		{ "<C-j>", "<Cmd><C-U>TmuxNavigateDown<CR>" },
		{ "<C-k>", "<Cmd><C-U>TmuxNavigateUp<CR>" },
		{ "<C-l>", "<Cmd><C-U>TmuxNavigateRight<CR>" },
		{ "<C-\\>", "<Cmd><C-U>TmuxNavigatePrevious<CR>" },
	},
}
