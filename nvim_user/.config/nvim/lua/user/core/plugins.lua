local M = {}

function M.config()
  return {
    -- disable
    ["folke/which-key.nvim"] = { disable = true },
    -- ["akinsho/bufferline.nvim"] = { disable = true },
    -- ["Shatur/neovim-session-manager"] = { disable = true },
    {
      event = "BufRead",
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
      setup = function()
        require("user.configs.exrc").setup()
      end,
    },

    -- Themes
    {
      "ful1e5/onedark.nvim",
      config = function()
        require("user.configs.colors.onedark").config()
      end,
    },
    {
      "rmehri01/onenord.nvim",
      config = function()
        require("onenord").setup({
          theme = vim.g.colortheme or "dark",
        })
      end,
    },
    --  Surround text with anything
    {
      "tpope/vim-surround",
      event = "BufRead",
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
        require("user.configs.dap").setup()
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
      config = function() end,
    },
    -- {
    --   "smartpde/telescope-recent-files",
    --   after = "telescope.nvim",
    --   config = function()
    --     require("user.configs.telescope_recent_files").config()
    --   end,
    -- },

    -- Treesitter
    {
      "nvim-telescope/telescope-project.nvim",
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
    {
      "David-Kunz/markid",
      after = "nvim-treesitter",
      config = function()
        require("user.configs.markid").config()
      end,
    },
    {
      "ziontee113/syntax-tree-surfer",
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
      opt = true,
      after = "nvim-lspconfig",
    },
    {
      "ray-x/lsp_signature.nvim",
      opt = true,
      after = "nvim-lspconfig",
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        require("user.configs.lightbulb").config()
      end,
    },
    -- emmet
    {
      "aca/emmet-ls",
      opt = true,
      after = "nvim-lspconfig",
    },

    -- Notes and Markdown
    {
      "mtth/scratch.vim",
      config = function()
        require("user.configs.scratch").config()
      end,
    },
    {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      opt = true,
      cmd = { "MarkdownPreview" },
      ft = "markdown",
    },
    {
      "AckslD/nvim-FeMaco.lua",
      config = 'require("femaco").setup()',
      ft = { "markdown" },
      opt = true,
      cmd = { "FeMaco" },
    },
    {
      "mickael-menu/zk-nvim",
      config = function()
        require("user.configs.zk").config()
      end,
      ft = { "markdown" },
      opt = true,
      cmd = {
        "ZkNew",
        "ZkIndex",
        "ZkNotes",
        "ZkLinks",
        "ZkBacklinks",
        "ZkTags",
        "ZkGrep",
      },
    },
    {
      "jbyuki/venn.nvim",
      ft = { "markdown" },
      opt = true,
      cmd = { "VBox" },
    },
    {
      "phaazon/mind.nvim",
      -- branch = "v2.2",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("user.configs.mind").config()
      end,
      after = "telescope.nvim",
      opt = true,
      cmd = {
        "MindOpenProject",
        "MindOpenMain",
        "MindFindOrCreateNote",
        "MindImportFiles",
      },
    },
    {
      "dhruvasagar/vim-table-mode",
      setup = function()
        require("user.configs.vim_table_mode").setup()
      end,
      ft = { "markdown" },
      opt = true,
    },
    {
      "dkarter/bullets.vim",
      setup = function()
        require("user.configs.bullets").setup()
      end,
      ft = "markdown",
      opt = true,
      config = function()
        require("user.configs.bullets").config()
      end,
    },

    -- Neorg
    -- {
    --   "nvim-neorg/neorg-telescope",
    --   opt = true,
    --   -- cmd = {
    --   --   "Neorg",
    --   --   "NeorgStart",
    --   -- },
    --   -- ft = "norg",
    --   after = "neorg",
    -- },
    -- {
    --   "nvim-neorg/neorg",
    --   opt = true,
    --   config = function()
    --     require("user.configs.neorg").config()
    --   end,
    --   cmd = {
    --     "Neorg",
    --     "NeorgStart",
    --   },
    --   -- ft = "norg",
    --   after = "nvim-treesitter",
    -- },
    -- {
    --   "esquires/neorg-gtd-project-tags",
    --   opt = true,
    --   -- ft = "norg",
    --   -- cmd = "Neorg",
    --   after = "neorg",
    -- },
    -- {
    --   "max397574/neorg-kanban",
    --   opt = true,
    --   -- ft = "norg",
    --   -- cmd = "Neorg",
    --   after = "neorg",
    -- },
    -- {
    --   "max397574/neorg-contexts",
    --   opt = true,
    --   -- ft = "norg",
    --   -- cmd = "Neorg",
    --   after = "neorg",
    -- },

    -- color utils
    {
      "max397574/colortils.nvim",
      cmd = "Colortils",
      config = function()
        require("colortils").setup()
      end,
      opt = true,
    },

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
      config = function()
        require("user.configs.gtranslate").config()
      end,
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
      event = "BufRead",
      setup = function()
        require("user.configs.minimap").setup()
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
    },
    {
      "junegunn/vim-easy-align",
      event = "BufRead",
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

    -- rest client
    {
      -- checkout manually commit e5f68db73276c4d4d255f75a77bbe6eff7a476ef
      -- https://github.com/NTBBloodbath/rest.nvim/issues/114
      "NTBBloodbath/rest.nvim",
      config = function()
        require("user.configs.rest").config()
      end,
      ft = "http",
      opt = true,
      cmd = {
        "RestNvim",
        "RestNvimPreview",
        "RestNvimLast",
      },
    },

    -- base64
    {
      "christianrondeau/vim-base64",
      opt = true,
    },

    -- yank history
    {
      "AckslD/nvim-neoclip.lua",
      requires = { "kkharji/sqlite.lua", module = "sqlite" },
      config = function()
        require("user.configs.neoclip").config()
      end,
      opt = true,
      after = "telescope.nvim",
    },

    -- window and buffer management
    -- works for new nvim version 0.8
    -- {
    --   "levouh/tint.nvim",
    --   config = function()
    --     require("user.configs.tint").config()
    --   end,
    -- },
    {
      "anuvyklack/hydra.nvim",
      config = function()
        require("user.configs.hydra").config()
      end,
    },
    {
      "sindrets/winshift.nvim",
      opt = true,
      cmd = "WinShift",
    },
    -- rust
    {
      "simrat39/rust-tools.nvim",
      opt = true,
      ft = "rust",
      config = function()
        require("user.configs.rust_tools").config()
      end,
    },
  }
end

return M
