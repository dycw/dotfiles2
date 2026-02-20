-- luacheck: push ignore
local v = vim
-- luacheck: pop

return {
	"mizlan/iswap.nvim",
	config = function()
		v.keymap.set("n", "<Leader>is", function()
			require("iswap").iswap()
		end, { desc = "i[s]wap" })
		v.keymap.set("n", "<Leader>iw", function()
			require("iswap").iswap_with()
		end, { desc = "iswap [w]ith" })
	end,
	enabled = v.loop.os_uname().sysname ~= "Darwin",
}
