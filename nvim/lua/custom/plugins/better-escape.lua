return {
    "max397574/better-escape.nvim",
    config = function()
        require("better_escape").setup({
            mapping = { "jj", "jk", "kj", "kk" },
        })
    end,
    event = "VeryLazy",
}
