-- luacheck: push ignore
local v = vim
-- luacheck: pop

return {
	"monaqa/dial.nvim",
	config = function()
		local keymap_set = require("utilities").keymap_set
		local map = require("dial.map")
		keymap_set("n", "<C-a>", function()
			map.manipulate("increment", "normal")
		end, "Increment (normal)")
		keymap_set("n", "<C-x>", function()
			map.manipulate("decrement", "normal")
		end, "Increment (normal)")
		keymap_set("n", "g<C-a>", function()
			map.manipulate("increment", "gnormal")
		end, "Increment (gnormal)")
		keymap_set("n", "g<C-x>", function()
			map.manipulate("decrement", "gnormal")
		end, "Increment (gnormal)")
		keymap_set("x", "<C-a>", function()
			map.manipulate("increment", "visual")
		end, "Increment (visual)")
		keymap_set("x", "<C-x>", function()
			map.manipulate("decrement", "visual")
		end, "Increment (visual)")
		keymap_set("x", "g<C-a>", function()
			map.manipulate("increment", "gvisual")
		end, "Increment (gvisual)")
		keymap_set("x", "g<C-x>", function()
			map.manipulate("decrement", "gvisual")
		end, "Increment (gvisual)")

		local function titlecase(s)
			return s:sub(1, 1):upper() .. s:sub(2):lower()
		end

		-- build groups
		local groups = {
			{ "absolute", "relative" },
			{ "after", "before" },
			{ "all", "any" },
			{ "and", "or" },
			{ "append", "extend" },
			{ "ascending", "descending" },
			{ "ask", "bid" },
			{ "backward", "forward" },
			{ "bear", "bull" },
			{ "bottom", "top" },
			{ "buy", "sell" },
			{ "ceil", "floor" },
			{ "close", "open" },
			{ "cloud", "local" },
			{ "cold", "hot" },
			{ "column", "row" },
			{ "disable", "enable" },
			{ "down", "up" },
			{ "end", "start", "stop" },
			{ "entered", "exited" },
			{ "entry", "exit" },
			{ "external", "internal" },
			{ "failure", "success" },
			{ "fast", "slow" },
			{ "faster", "slower" },
			{ "fastest", "slowest" },
			{ "first", "last" },
			{ "float", "int" },
			{ "gateway", "tws" },
			{ "head", "tail" },
			{ "height", "width" },
			{ "high", "low" },
			{ "higher", "lower" },
			{ "highest", "lowest" },
			{ "horizontal", "vertical" },
			{ "init", "post" },
			{ "key", "value" },
			{ "keys", "values" },
			{ "left", "right" },
			{ "long", "short" },
			{ "loss", "profit" },
			{ "lower", "upper" },
			{ "max", "min" },
			{ "max_value", "min_value" },
			{ "maximum", "minimum" },
			{ "minor", "major" },
			{ "new", "old" },
			{ "no", "yes" },
			{ "off", "on" },
			{ "only", "skip" },
			{ "positive", "negative" },
			{ "public", "private" },
			{ "read", "write" },
			{ "starting", "stopping" },
			{ "stderr", "stdout" },
			{ "true", "false" },
		}

		local groups_all_cases = {}
		local augend = require("dial.augend")
		for _, pair in ipairs(groups) do
			table.insert(
				groups_all_cases,
				augend.constant.new({
					elements = v.tbl_map(string.upper, pair),
					word = true,
					cyclic = true,
				})
			)
			table.insert(
				groups_all_cases,
				augend.constant.new({
					elements = v.tbl_map(titlecase, pair),
					word = true,
					cyclic = true,
				})
			)
			table.insert(
				groups_all_cases,
				augend.constant.new({
					elements = v.tbl_map(string.lower, pair),
					word = true,
					cyclic = true,
				})
			)
		end

		-- register all
		require("dial.config").augends:register_group({
			default = v.list_extend({
				augend.integer.alias.decimal,
				augend.integer.alias.decimal_int,
				augend.integer.alias.hex,
				augend.integer.alias.octal,
				augend.integer.alias.binary,
				augend.date.alias["%Y/%m/%d"],
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%H:%M:%S"],
				augend.date.alias["%H:%M"],
				augend.constant.alias.bool,
				augend.semver.alias.semver,
			}, groups_all_cases),
		})
	end,
}
