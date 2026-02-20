-- luacheck: push ignore
local v = vim
-- luacheck: pop

local keymap_set = require("utilities").keymap_set

-- command
keymap_set("n", ";", ":", "Command")

-- copy/paste mode
keymap_set({ "n", "v" }, "<F2>", function()
	if v.wo.number then
		v.opt.number = false
		v.opt.relativenumber = false
		v.opt.signcolumn = "no"
		v.opt.paste = true
		pcall(function()
			require("ibl").update({ enabled = false })
		end)
	else
		v.opt.number = true
		v.opt.relativenumber = true
		v.opt.signcolumn = "yes"
		v.opt.paste = false
		pcall(function()
			require("ibl").update({ enabled = true })
		end)
	end
end, "Copy/paste mode")

-- global marks
local prefixes = "m'"
local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #prefixes do
	local prefix = prefixes:sub(i, i)
	for j = 1, #letters do
		local lower_letter = letters:sub(j, j)
		local upper_letter = string.upper(lower_letter)
		keymap_set({ "n", "v" }, prefix .. lower_letter, prefix .. upper_letter, "Mark " .. upper_letter)
	end
end

-- navigation
keymap_set("i", "<C-h>", "<Left>", "Move left")
keymap_set("i", "<C-j>", "<Down>", "Move down")
keymap_set("i", "<C-k>", "<Up>", "Move up")
keymap_set("i", "<C-l>", "<Right>", "Move right")

-- paste in insert mode
keymap_set("i", "<C-v>", "<C-o>p", "Paste")

-- quickfix
keymap_set("n", "]", "<Cmd>cnext<CR>", "Quickfix next")
keymap_set("n", "[", "<Cmd>cprev<CR>", "Quickfix prev")

-- quit
keymap_set({ "n", "v" }, "<C-q>", "<Cmd>confirm q<CR>", "Quit")
keymap_set("i", "<C-q>", "<Esc><Cmd>confirm q<CR>a", "Quit")

-- save
keymap_set({ "n", "v" }, "<C-s>", "<Cmd>w<CR>", "Save")
keymap_set("i", "<C-s>", "<Esc><Cmd>w<CR>a", "Save")

-- search highlight
keymap_set("n", "<Esc>", "<Cmd>nohlsearch<CR>", "Clear highlight")

-- split windows
keymap_set("n", "<C-w>h", "<Cmd>set nosplitright<CR> <Cmd>vsplit<CR> <Cmd>set splitright<CR>", "Split left")
keymap_set("n", "<C-w>j", "<Cmd>set splitbelow<CR> <Cmd>split<CR>", "Split down")
keymap_set("n", "<C-w>k", "<Cmd>set nosplitbelow<CR> <Cmd>split<CR> <Cmd>set splitbelow<CR>", "Split up")
keymap_set("n", "<C-w>l", "<Cmd>set splitright<CR> <Cmd>vsplit<CR>", "Split right")
keymap_set("n", "<Leader>wh", "<Cmd>set nosplitright<CR> <Cmd>vsplit<CR> <Cmd>set splitright<CR>", "Split left")
keymap_set("n", "<Leader>wj", "<Cmd>set splitbelow<CR> <Cmd>split<CR>", "Split down")
keymap_set("n", "<Leader>wk", "<Cmd>set nosplitbelow<CR> <Cmd>split<CR> <Cmd>set splitbelow<CR>", "Split up")
keymap_set("n", "<Leader>wl", "<Cmd>set splitright<CR> <Cmd>vsplit<CR>", "Split right")

-- visual indents
keymap_set("v", "<", "<gv", "Indent left")
keymap_set("v", ">", ">gv", "Indent right")
