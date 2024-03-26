-- luacheck: push ignore vim
local v = vim
-- luacheck: pop
local fn = v.fn
local set = v.keymap.set

return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
        require("telescope").setup({
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            -- pickers = {}
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- Slightly advanced example of overriding default behavior and theme
        set("n", "<leader>/", function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })

        -- Shortcut for searching your Neovim configuration files
        set("n", "<leader>sn", function()
            builtin.find_files({ cwd = fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons", enabled = v.g.have_nerd_font },
    },
    event = "VimEnter",
}