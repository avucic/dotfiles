return {
    {

        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
        },
        cmd = "Telescope",
        opts = require("user.plugins.configs.telescope"),
        config = function(plg, opts)
            require("plugins.configs.telescope")(plg, opts)
            require("telescope").load_extension("media_files")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("smart_open")
            require("telescope").load_extension("neoclip")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
    },
    {
        "gbrlsnchs/telescope-lsp-handlers.nvim",
        cmd = "Telescope"
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim", -- live grap with args
    },
    {
        "avucic/telescope-vim-bookmarks.nvim",
        init = function()
            require("user.plugins.configs.vim_bookmarks").init()
        end,
        dependencies = { "MattesGroeger/vim-bookmarks" },
        cmd = {
            "Telescope",
            "BookmarkToggle",
            "BookmarkAnnotate",
            "BookmarkClear",
            "BookmarkClearAll",
        },
    },
    {
        "nvim-telescope/telescope-media-files.nvim",
    },
    {
        "nvim-telescope/telescope-project.nvim",
        config = function()
            require("user.configs.project").config()
        end,
        cmd = "Telescope"
    },
    {
        "LukasPietzschmann/telescope-tabs",
        config = function()
            require("user.configs.telescope_tabs").config()
        end,
        cmd = "Telescope"
    },
    {
        "jedrzejboczar/toggletasks.nvim",
        config = function()
            require("user.configs.toggletasks").config()
        end,
        cmd = "Telescope"
    },
    {
        "danielfalk/smart-open.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        cmd = "Telescope"
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { "kkharji/sqlite.lua", module = "sqlite" },
        opts = {
            history = 1000,
            enable_persistent_history = true,
            length_limit = 1048576,
            continuous_sync = true,
            db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
            filter = nil,
            preview = true,
            default_register = '"',
            default_register_macros = "q",
            enable_macro_history = true,
            content_spec_column = false,
            on_paste = {
                set_reg = false,
            },
            on_replay = {
                set_reg = false,
            },
            keys = {
                telescope = {
                    i = {
                        select = "<tab>",
                        paste = "<cr>",
                        paste_behind = "<CR>",
                        replay = "<c-q>", -- replay a macro
                        delete = "<c-d>", -- delete an entry
                        custom = {},
                    },
                    n = {
                        select = "<cr>",
                        paste = "p",
                        paste_behind = "P",
                        replay = "q",
                        delete = "d",
                        custom = {},
                    },
                },
                fzf = {
                    select = "default",
                    paste = "ctrl-p",
                    paste_behind = "ctrl-k",
                    custom = {},
                },
            }
        },
        config = require("user.plugins.configs.neoclip"),
    }

}
