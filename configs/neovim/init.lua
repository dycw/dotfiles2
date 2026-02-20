-- main
require("globals") -- setting leader must happen before plugins are loaded
require("autocmds")
require("keymaps")
require("opts")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
