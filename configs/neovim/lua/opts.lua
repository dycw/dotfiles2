-- luacheck: push ignore
local v = vim
-- luacheck: pop
local opt = v.opt

-- Make a backup before overwriting a file?
opt.backup = false

-- Every wrapped line with continue visually indended?
opt.breakindent = true

-- Sync clipboard between OS and Neovim
v.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Number of screen lines to use for the command-line
opt.cmdheight = 1

-- Comma-separated list of screen columns that are highlighted with ColorColumn
opt.colorcolumn = "80"

-- A comma-separated list of options for Insert mode completion
opt.completeopt = { "menuone", "preview" }

-- Determine how text with the "conceal" syntax attribute is shown
opt.conceallevel = 0

-- Execute {command}, and use a dialog when an operation has to be confirmed
opt.confirm = false

-- Highlight the text line of the cursor with CursorLine
opt.cursorline = false

-- Use the appropriate number of spaces to insert a <Tab>?
opt.expandtab = true

-- File-content encoding for the current buffer
opt.fileencoding = "utf-8"

-- The expression used for when `'foldmethod'`  is "expr"
opt.foldexpr = ""

-- The kind of folding used for the current window
opt.foldmethod = "manual"

-- The ":substitute" flag `'g'`?
opt.gdefault = true

-- When off a buffer is unloaded when it is abandoned?
opt.hidden = true

-- When there is a previous search pattern, highlight all its matches
opt.hlsearch = true

-- Ignore case in search patterns
opt.ignorecase = true

-- When nonempty, shows the effects of substitute, smagic, snomagic and user
-- commands with the command-preview flag as you type
opt.inccommand = "split"

-- The value of this option influences when the last window will have a status
-- line
opt.laststatus = 3

-- By default, show tabs as ">", trailing spaces as "-", and non-breakable
-- space characters as "+".
opt.list = true

-- Strings to use in `'list'`  mode and for the |:list| command
opt.listchars = { tab = "▏ ", trail = "·", nbsp = "␣" }

-- Disables mouse support
opt.mouse = ""

-- Print the line number in front of each line?
opt.number = true

-- Minimal number of columns to use for the line number
opt.numberwidth = 4

-- Maximum number of items to show in the popup menu
opt.pumheight = 10

-- Show the line number relative to the line with the cursor in front of each
-- line?
opt.relativenumber = true

-- Show the line and column number of the cursor position, separated by a
-- comma?
opt.ruler = false

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 10

-- If in Insert, Replace or Visual mode put a message on the last line?
opt.showmode = false

-- The minimal number of screen columns to keep to the left and to the right of
-- the cursor if `nowrap` is set
opt.sidescrolloff = 10

-- When and how to draw the sign column
opt.signcolumn = "yes"

-- Override the `'ignorecase'`  option if the search pattern contains upper
-- case characters
opt.smartcase = true

-- Number of spaces to use for each step of (auto)indent
opt.shiftwidth = 2

-- Show command in the last line of the screen?
opt.showcmd = false

-- When on, splitting a window will put the new window right of the current one
opt.splitright = true

-- When on, splitting a window will put the new window below the current one
opt.splitbelow = true

-- Use a swapfile for the buffer?
opt.swapfile = false

-- Number of spaces that a <Tab> int he file counts for
opt.tabstop = 2

-- Enables 24-bit RGB color in the TUI
opt.termguicolors = true

-- This option and `'timeoutlen'`  determine the behavior when part of a mapped
-- key sequence has been received
opt.timeout = true

-- Time in milliseconds to wait for a mapped sequence to complete
opt.timeoutlen = 300

-- When on, the title of the window will be set to the value of `titlestring`
opt.title = true

-- When this option is not empty, it will be used for the title of the window
opt.titlestring = "%<%F%=%l/%L - nvim"

-- When on, Vim automatically saves undo history to an undo file when writing a
-- buffer to a file
opt.undofile = true

-- If this many milliseconds nothing is typed the swap file will be written to
-- disk
opt.updatetime = 100

-- When on, lines longer than the width of the window will wrap and displaying
-- continues on the next line
opt.wrap = true

-- Make a backup before overwriting a file
opt.writebackup = true
