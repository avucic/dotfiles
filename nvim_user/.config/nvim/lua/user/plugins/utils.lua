return {
    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require("colortils").setup()
        end,
    },

    {
        "kraftwerk28/gtranslate.nvim",
        cmd = "Translate",
        opts = {
            default_to_language = "English",
        },
        config = require("user.plugins.configs.gtranslate")
    },

    {
        "tpope/vim-dadbod",
        cmd = "DB",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        init = require("user.plugins.configs.dadbod").init,
        cmd = {
            "DBUI",
            "DBUIToggle",
        },
        dependencies = {
            "kristijanhusak/vim-dadbod-completion",
        }
    },

    {
        "voldikss/vim-browser-search",
        cmd = "BrowserSearch",
    },
    {
        "tyru/open-browser.vim",
        cmd = {
            "OpenGithubFile",
            "OpenGithubProject",
        },
    },

    {
        "rest-nvim/rest.nvim",
        opts = {

            -- Open request results in a horizontal split
            result_split_horizontal = false,
            -- Keep the http file buffer above|left when split horizontal|vertical
            result_split_in_place = false,
            -- Skip SSL verification, useful for unknown certificates
            skip_ssl_verification = true,
            -- Highlight request on run
            highlight = {
                enabled = true,
                timeout = 150,
            },
            result = {
                -- toggle showing URL, HTTP info, headers at top the of result window
                show_url = true,
                show_http_info = true,
                show_headers = true,
            },
            -- Jump to request line on run
            jump_to_request = false,
            env_file = ".env",
            custom_dynamic_variables = {},
            yank_dry_run = true,
        },
        config = require("user.plugins.configs.rest"),
        ft = "http",
        cmd = {
            "RestNvim",
            "RestNvimPreview",
            "RestNvimLast",
        },
    },
    {
        "christianrondeau/vim-base64",
    },
    {
        "mattn/calendar-vim",
        init = require("user.plugins.configs.calendar").init,
        cmd = {
            "Calendar",
            "CalendarH",
            "CalendarT",
            "CalendarVR",
        },
    },

    {
        "narutoxy/silicon.lua", -- silicon is a lua plugin for neovim to generate beautiful images of code snippet using silicon
        requires = { "nvim-lua/plenary.nvim" },
        config = require("user.plugins.configs.silicon"),
    },
    {
        "klen/nvim-config-local",
        opts = {
            -- Default configuration (optional)
            config_files = { ".vimrc.lua", ".vimrc" }, -- Config file patterns to load (lua supported)
            hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
            autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
            commands_create = true, -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
            silent = true, -- Disable plugin messages (Config loaded/ignored)
            lookup_parents = false, -- Lookup config files in parent directories
        },
        config = require("user.plugins.configs.nvim_local_config")
    },
}
