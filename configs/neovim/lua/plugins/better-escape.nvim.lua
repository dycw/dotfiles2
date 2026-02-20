local esc = "<Esc>"
local j_or_k = { j = esc, k = esc }
local jk_or_kj = { j = { k = esc }, k = { j = esc } }

return {
	"max397574/better-escape.nvim",
	opts = {
		mappings = {
			i = { j = j_or_k, k = j_or_k },
			c = jk_or_kj,
			t = jk_or_kj,
			v = jk_or_kj,
			s = jk_or_kj,
		},
	},
}
