-- luacheck: push ignore
local v = vim
-- luacheck: pop
local fn = v.fn

return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x",  -- https://github.com/nvim-telescope/telescope.nvim/issues/3438
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local config = require("telescope.config")
		local keymap_set = require("utilities").keymap_set

		local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
		table.insert(vimgrep_arguments, "--context=0")
		table.insert(vimgrep_arguments, "--trim")

		require("telescope").setup({
			defaults = {
				layout_config = {
					height = 0.6,
					preview_cutoff = 40,
					preview_width = 0.4,
					prompt_position = "top",
					width = 0.99,
				},
				layout_strategy = "horizontal",
				path_display = {
					"smart",
					shorten = {
						len = 5,
						exclude = { 1, -1 },
					},
				},
				sorting_strategy = "ascending",
				vimgrep_arguments = vimgrep_arguments,
			},
			extensions = {
				adjacent = { level = 2 },
				project = {
					base_dirs = {
						{ "~", max_depth = 1 },
						{ "~/work", max_depth = 1 },
					},
				},
				recent_files = { only_cwd = true },
			},
		})

		-- extensions
		telescope.load_extension("adjacent")
		telescope.load_extension("file_browser")
		telescope.load_extension("recent-files")
		telescope.load_extension("ui-select")

		-- key maps
		-- key maps: files
		keymap_set("n", "<Leader>af", "<Cmd>Telescope adjacent<CR>", "adjacent [f]iles")
		keymap_set("n", "<Leader>f", function()
			require("telescope").extensions["recent-files"].recent_files({})
			-- builtin.find_files
		end, "[f]iles")
		keymap_set("n", "<Leader>gf", function()
			builtin.git_files({ show_untracked = true })
		end, "git [f]iles")
		keymap_set("n", "<Leader>lg", builtin.live_grep, "live [g]rep")
		keymap_set("n", "<Leader>of", builtin.oldfiles, "old [f]iles")

		-- key maps: buffers
		keymap_set("n", "<Leader><Leader>", builtin.buffers, "buffers")

		-- key maps: LSP
		keymap_set("n", "gd", builtin.lsp_definitions, "[d]efinitions")
		keymap_set("n", "gi", builtin.lsp_incoming_calls, "[i]ncoming calls")
		keymap_set("n", "gI", builtin.lsp_implementations, "[i]mplementations")
		keymap_set("n", "go", builtin.lsp_outgoing_calls, "[o]utgoing calls")
		keymap_set("n", "gr", builtin.lsp_references, "[r]eferences")
		keymap_set("n", "gt", builtin.lsp_type_definitions, "[t]ype definitions")
		keymap_set("n", "<Leader>ds", builtin.lsp_document_symbols, "document [s]ymbols")
		keymap_set("n", "<Leader>dd", builtin.diagnostics, "workspace [d]iagnostics")
		keymap_set("n", "<Leader>ws", builtin.lsp_dynamic_workspace_symbols, "workspace [s]ymbols")

		-- keys maps: text
		keymap_set("n", "<Leader>gs", builtin.grep_string, "grep [s]tring")
		keymap_set("n", "<Leader>bf", builtin.current_buffer_fuzzy_find, "buffer [f]uzzy find")

		-- key maps: miscellaneous
		keymap_set("n", "<Leader>ch", builtin.command_history, "command [h]istory")
		keymap_set({ "n", "v" }, "<Leader>co", builtin.commands, "c[o]mmands")
		keymap_set("n", "<Leader>te", builtin.builtin, "t[e]lescope")

		-- Shortcut for searching your Neovim configuration files
		keymap_set("n", "<Leader>nf", function()
			builtin.find_files({ cwd = fn.stdpath("config") })
		end, "neovim [f]iles")
		-- autocommands
		v.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if fn.argc() == 0 then
					require("telescope").extensions["recent-files"].recent_files({})
				end
			end,
		})
	end,
	dependencies = {
		"maximilianlloyd/adjacent.nvim",
		"mollerhoj/telescope-recent-files.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-project.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	event = "VimEnter",
}
