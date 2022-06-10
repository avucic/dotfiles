local M = {}

function M.config()
  return {
    {
      "kevinhwang91/nvim-bqf",
      requires = { { "junegunn/fzf", module = "nvim-bqf", ft = "qf" } },
      config = function()
        require("user.configs.bqf").config()
      end,
    },

    -- editorconfig
    {
      "gpanders/editorconfig.nvim",
    },
    -- load local config
    {
      "ii14/exrc.vim",
      config = function()
        require("user.configs.exrc").config()
      end,
    },

    -- Themes
    {
      "ful1e5/onedark.nvim",
      config = function()
        require("user.configs.colors.onedark").config()
      end,
    },
    --  Surround text with anything
    {
      "tpope/vim-surround",
    },

    -- Jump between tmux splits
    {
      "numToStr/Navigator.nvim",
      config = function()
        require("user.configs.navigator").config()
      end,
      opt = true,
      cmd = {
        "NavigatorLeft",
        "NavigatorRight",
        "NavigatorUp",
        "NavigatorDown",
        "NavigatorPrevious",
      },
    },

    -- Multicursor
    {
      "mg979/vim-visual-multi",
      branch = "master",
      event = "BufRead",
      setup = function()
        require("user.configs.vim_multi_cursor").config()
      end,
    },

    -- Autocompletion
    {
      "hrsh7th/cmp-cmdline",
      after = "nvim-cmp",
    },

    {
      "dmitmel/cmp-cmdline-history",
      after = "nvim-cmp",
    },
    {
      "hrsh7th/vim-vsnip",
      after = "nvim-cmp",
    },
    {
      "tzachar/cmp-tabnine",
      after = "nvim-cmp",
      run = "./install.sh",
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-emoji",
      after = "nvim-cmp",
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-vsnip",
      after = "nvim-cmp",
    },
    {
      "f3fora/cmp-spell",
      after = "nvim-cmp",
    },

    -- Git
    {
      "TimUntersberger/neogit",
      config = function()
        require("neogit").setup({
          integrations = {
            diffview = true,
          },
        })
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
      cmd = { "Neogit" },
      opt = true,
    },
    {
      "APZelos/blamer.nvim",
      cmd = "GitBlameToggle",
      opt = true,
    },
    {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = {
        "Diffview",
        "DiffviewOpen",
        "DiffviewFileHistory",
      },
      config = function()
        require("user.configs.diffview").config()
      end,
      opt = true,
    },

    -- Jump to char
    {
      "ggandor/lightspeed.nvim",
      event = "BufReadPre",
    },

    -- Highlight current word
    {
      "dominikduda/vim_current_word",
      event = "BufRead",
    },

    -- Todos
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end,
      cmd = {
        "TodoLocList",
        "TodoQuickFix",
        "TodoTrouble",
        "TodoTelescope",
      },
      opt = true,
    },

    -- Error/diagnostic
    {
      "folke/trouble.nvim",
      opt = true,
      cmd = "TroubleToggle",
    },

    -- Debugging
    {
      "mfussenegger/nvim-dap",
      -- event = "BufWinEnter",
      setup = function()
        require("user.configs.dap").config()
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      after = "nvim-dap",
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
    },
    -- Bookmarks
    {
      "tom-anders/telescope-vim-bookmarks.nvim",
      config = function()
        require("user.configs.vim_bookmarks").config()
      end,
      requires = { "MattesGroeger/vim-bookmarks" },
      opt = true,
      cmd = {
        "Telescope",
        "BookmarkToggle",
        "BookmarkAnnotate",
        "BookmarkClear",
        "BookmarkClearAll",
      },
    },

    -- Match parenthesis
    {
      "andymass/vim-matchup",
      event = "BufRead",
    },

    -- Toggle ruby block, tag etc.
    {
      "AndrewRadev/splitjoin.vim",
      module = "splitjoin",
      event = "InsertEnter",
    },

    -- Syntax
    {
      "lewis6991/spellsitter.nvim",
      after = "nvim-treesitter",
      config = function()
        require("spellsitter").setup({
          -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
          enable = true,
        })
      end,
    },

    -- Telescope
    {
      "nvim-telescope/telescope-file-browser.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    },
    {
      "gbrlsnchs/telescope-lsp-handlers.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("lsp_handlers")
      end,
    },

    -- Treesitter
    {
      "ahmedkhalf/project.nvim",
      after = "telescope.nvim",
      config = function()
        require("user.configs.project").config()
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    },
    {
      "nvim-treesitter/playground",
      opt = true,
      cmd = {
        "TSPlaygroundToggle",
        "TSHighlightCapturesUnderCursor",
      },
    },

    -- Tasks
    {
      "~/Work/Neovim/vs-tasks.nvim",
      config = function()
        require("user.configs.vstask").config()
      end,
      after = "telescope.nvim",
      opt = true,
    },

    -- Enhance visibility
    {
      "Pocco81/TrueZen.nvim",
      opt = true,
      cmd = {
        "TZMinimalist",
        "TZFocus",
        "TZAtaraxis",
      },
    },

    -- LSP
    {
      "folke/lsp-colors.nvim",
    },
    {
      "ray-x/lsp_signature.nvim",
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        require("user.configs.lightbulb").config()
      end,
    },
    --
    -- Window picker
    {
      "s1n7ax/nvim-window-picker",
      tag = "v1.*",
      config = function()
        require("user.configs.window_picker").config()
      end,
    },

    -- Notes
    {
      "nvim-neorg/neorg",
      config = function()
        require("user.configs.neorg").config()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
      },
      cmd = {
        "Neorg",
        "NeorgStart",
      },
      ft = "norg",
      after = "nvim-treesitter",
    },
    {
      "esquires/neorg-gtd-project-tags",
      opt = true,
      cmd = "Neorg",
    },
    {
      "max397574/neorg-kanban",
      opt = true,
      cmd = "Neorg",
    },
    {
      "max397574/neorg-contexts",
      opt = true,
      cmd = "Neorg",
    },

    -- my
    -- {
    --   "~/Work/Neovim/nvim-notes",
    --   config = function()
    --     require("user.configs.notes").config()
    --   end,
    --   after = "telescope.nvim",
    --   opt = true,
    -- },

    -- Harpoon
    {
      "ThePrimeagen/harpoon",
      after = "telescope.nvim",
      config = function()
        require("user.configs.harpoon").config()
      end,
    },

    -- Google translate
    {
      "kraftwerk28/gtranslate.nvim",
      cmd = "Translate",
      opt = true,
    },

    -- db
    {
      "tpope/vim-dadbod",
      cmd = "DB",
      opt = true,
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      config = function()
        require("user.configs.dadbod").config()
      end,
      cmd = {
        "DBUI",
        "DBUIToggle",
      },
      opt = true,
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      after = "vim-dadbod-ui",
    },
    -- UI
    {
      "wfxr/minimap.vim",
      opt = true,
      cmd = {
        "Minimap",
        "MinimapToggle",
      },
      -- event = "BufRead",
      setup = function()
        require("user.configs.minimap").config()
      end,
    },
    {
      "beauwilliams/focus.nvim",
      config = function()
        require("user.configs.focus").config()
      end,
      opt = true,
      cmd = {
        "FocusDisable",
        "FocusEnable",
        "FocusToggle",
        "FocusSplitNicely",
        "FocusMaximise",
        "FocusEqualise",
        "FocusMaxOrEqual",
        "FocusSplitLeft",
        "FocusSplitDown",
        "FocusSplitUp",
        "FocusSplitRight",
      },
    },
    -- text
    {
      "farfanoide/inflector.vim",
      event = "InsertEnter",
      setup = function()
        require("user.configs.inflector").config()
      end,
    },
    -- Session
    {
      "rmagatti/auto-session",
      config = function()
        require("user.configs.auto_session").config()
      end,
    },

    -- Browser search
    {
      "voldikss/vim-browser-search",
      opt = true,
      cmd = {
        "BrowserSearch",
      },
    },
    {
      "tyru/open-browser.vim",
      opt = true,
      cmd = {
        "OpenGithubFile",
        "OpenGithubProject",
      },
    },
    {
      "tyru/open-browser-github.vim",
      opt = true,
      cmd = {
        "OpenGithubFile",
        "OpenGithubProject",
      },
    },
    -- {
    --   "ray-x/go.nvim",
    --   config = function()
    --     require("go").setup({
    --       test_runner = "ginkgo",
    --       goimport = "gopls", -- if set to 'gopls' will use golsp format
    --       gofmt = "gopls", -- if set to gopls will use golsp format
    --       max_line_len = 120,
    --       tag_transform = false,
    --       test_dir = "",
    --       comment_placeholder = " ?  ",
    --       lsp_cfg = true, -- false: use your own lspconfig
    --       lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    --       lsp_on_attach = true, -- use on_attach from go.nvim
    --       dap_debug = true,
    --     })
    --   end,
    -- },
  }
end

return M
