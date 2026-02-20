-- luacheck: push ignore
local v = vim
-- luacheck: pop
local api = v.api

return {
	"okuuva/auto-save.nvim", -- forked from pocco81/auto-save.nvim
	config = function()
		require("auto-save").setup({
			debounce_delay = 10,
		})
		require("utilities").keymap_set("n", "<leader>as", function()
			require("auto-save").toggle()
		end, "auto [s]ave")
		local group = api.nvim_create_augroup("autosave", {})
		api.nvim_create_autocmd("User", {
			pattern = "AutoSaveEnable",
			group = group,
			callback = function()
				v.notify("AutoSave enabled", v.log.levels.INFO)
			end,
		})
		api.nvim_create_autocmd("User", {
			pattern = "AutoSaveDisable",
			group = group,
			callback = function()
				v.notify("AutoSave disabled", v.log.levels.INFO)
			end,
		})
	end,
	-- N.B.: do not try to put any other keys in this dict, it won't work
}
