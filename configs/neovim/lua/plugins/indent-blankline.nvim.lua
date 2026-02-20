-- luacheck: push ignore
local v = vim
-- luacheck: pop

return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			local nvim_set_hl = v.api.nvim_set_hl
			nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		v.g.rainbow_delimiters = { highlight = highlight }
		require("ibl").setup({
			indent = { char = "▏" },
			scope = { highlight = highlight },
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
	dependencies = {
		"https://gitlab.com/hiphish/rainbow-delimiters.nvim",
	},
	main = "ibl",
}
