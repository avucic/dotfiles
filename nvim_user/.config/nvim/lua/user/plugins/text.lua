return {
    {
        "tpope/vim-surround",
        event = "BufRead",
    },
    {
        "mg979/vim-visual-multi",
        branch = "master",
        event = "BufRead",
        init = function()
            vim.g["VM_leader"] = "<m-\\>"
            vim.g["VM_default_mappings"] = 1
        end,
    },

    -- text
    {
        "farfanoide/inflector.vim",
        event = "InsertEnter",
    },
    {
        "junegunn/vim-easy-align",
        -- event = "BufRead",
    },
    {
        "nguyenvukhang/nvim-toggler", -- Invert text in vim, purely with lua.
        -- event = "BufRead",
        opts = {
            -- your own inverses
            -- inverses = {
            --   ["true"] = "false",
            --   ["yes"] = "no",
            --   ["on"] = "off",
            --   ["left"] = "right",
            --   ["up"] = "down",
            --   ["!="] = "==",
            -- },
            -- removes the default <leader>i keymap
            remove_default_keybinds = true,
        },
        config = require("user.plugins.configs.nvim_toggler")
    },
}
