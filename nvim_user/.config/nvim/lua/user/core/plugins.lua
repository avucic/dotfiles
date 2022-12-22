local M = {}

function M.config()
  return {
    -- disable
    -- ["folke/which-key.nvim"] = { disable = true },
    -- ["akinsho/bufferline.nvim"] = { disable = true },
    ["nvim-neo-tree/neo-tree.nvim"] = { disable = true },
    ["s1n7ax/nvim-window-picker"] = { disable = true },
    -- ["Shatur/neovim-session-manager"] = { disable = true },
    {
      event = "BufRead",
      "kevinhwang91/nvim-bqf",
      requires = { { "junegunn/fzf", module = "nvim-bqf", ft = "qf" } },
      config = function()
        require("user.configs.bqf").config()
      end,
    },
    -- Neovim
    {
      "smjonas/live-command.nvim",
      -- live-command supports semantic versioning via tags
      -- tag = "1.*",
      config = function()
        require("live-command").setup({
          commands = {
            Norm = { cmd = "norm" },
            Global = { cmd = "global" },
          },
        })
      end,
      opt =true,
      cmd = {
        "Norm",
        "Global"
      }
    },

    -- editorconfig
    {
      "gpanders/editorconfig.nvim",
    },
    -- load local config
    {
      "klen/nvim-config-local",
      config = function()
        require("user.configs.nvim_local_config").config()
      end,
    },

    -- Themes
    {
      "marko-cerovac/material.nvim",
      opt = true,
      event = "BufRead",
      setup = function()
        vim.g.material_style = "lighter"
      end,
      config = function()
        require("material").setup()
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

    {
      "cbochs/portal.nvim",
      event = "BufRead",
      opt = true,
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
      "Almo7aya/openingh.nvim",
      requires = "tyru/open-browser.vim",
      opt = true,
      cmd = {
        "OpenInGHRepo",
        "OpenInGHFile",
      },
    },

    -- Jump to char
    {
      -- "ggandor/lightspeed.nvim",
      "ggandor/leap.nvim",
      event = "BufReadPre",
      config = function()
        require("user.configs.leap").config()
      end,
      requires = {
        "ggandor/flit.nvim", -- f,F,t,T commands
      },
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
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
    },
    -- Bookmarks
    {
      "avucic/telescope-vim-bookmarks.nvim",
      setup = function()
        require("user.configs.vim_bookmarks").setup()
      end,
      config = function()
        require("user.configs.vim_bookmarks").config()
      end,
      requires = { "MattesGroeger/vim-bookmarks" },
      -- after = "telescope.nvim",
      -- opt = true,
      -- cmd = {
      --   "Telescope",
      --   "BookmarkToggle",
      --   "BookmarkAnnotate",
      --   "BookmarkClear",
      --   "BookmarkClearAll",
      -- },
    },

    -- Match parenthesis
    {
      "andymass/vim-matchup",
      event = "BufRead",
    },

    -- Telescope
    {
      "nvim-telescope/telescope-media-files.nvim",
      after = "telescope.nvim",
      opt = true,
      config = function()
        require("telescope").load_extension("media_files")
      end,
    },
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
      opt = true,
    },
    {
      "LukasPietzschmann/telescope-tabs",
      after = "telescope.nvim",
      config = function()
        require("user.configs.telescope_tabs").config()
      end,
    },
    {
      "nvim-telescope/telescope-project.nvim",
      after = "telescope.nvim",
      config = function()
        require("user.configs.project").config()
      end,
    },

    -- Syntax
    {
      "folke/paint.nvim", -- highlight symbols in code like @something TODO:
      config = function()
        require("user.configs.paint").config()
      end,
    },
    -- Treesitter
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
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    },
    {
      "RRethy/nvim-treesitter-textsubjects",
      after = "nvim-treesitter",
    },

    {
      "nvim-treesitter/playground",
      opt = true,
      cmd = {
        "TSPlaygroundToggle",
        "TSHighlightCapturesUnderCursor",
        "TSCaptureUnderCursor",
      },
    },
    {
      "David-Kunz/markid", -- A Neovim extension to highlight same-name identifiers with the same color.
      after = "nvim-treesitter",
      config = function()
        require("user.configs.markid").config()
      end,
      opt = true,
    },
    {
      "ziontee113/syntax-tree-surfer",
      config = function()
        require("user.configs.syntax_tree_surfer").config()
      end,
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
    {
      "xarthurx/taskwarrior.vim",
      opt = true,
      cmd = { "TW" },
    },

    -- Enhance visibility
    {
      "Pocco81/TrueZen.nvim",
      opt = true,
      cmd = {
        "TZMinimalist",
        "TZFocus",
        "TZAtaraxis",
        "TZNarrow",
      },
      config = function()
        require("user.configs.true_zen").config()
      end,
    },

    -- LSP
    {
      "dnlhc/glance.nvim",
      config = function()
        require("user.configs.glance").config()
      end,
      opt = true,
      cmd = { "Glance" },
    },
    {
      "smjonas/inc-rename.nvim",
      opt = true,
      cmd = { "IncRename" },
      config = function()
        require("user.configs.inc_rename").config()
      end,
    },
    {
      "ray-x/lsp_signature.nvim", -- lsp arguments
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        require("user.configs.lightbulb").config()
      end,
    },
    {
      "joechrisellis/lsp-format-modifications.nvim",
      setup = function()
        vim.g.lsp_format_modifications_silence = 1
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
      "avucic/paste-markdown-url",
      run = "pip3 install requests beautifulsoup4 lxml",
      config = function()
        require("paste-markdown-url")
      end,
      opt = true,
      cmd = { "PasteMDLink" },
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
      "xorid/asciitree.nvim",
      ft = "markdown",
      cmd = { "AsciiTree" },
    },
    -- edit code blocks in markdown
    {
      "AckslD/nvim-FeMaco.lua",
      config = 'require("femaco").setup()',
      ft = { "markdown" },
      opt = true,
      cmd = { "FeMaco" },
    },
    {
      "jubnzv/mdeval.nvim",
      setup = function()
        require("user.configs.mdeval").setup()
      end,
      config = function()
        require("user.configs.mdeval").config()
      end,
      ft = { "markdown" },
      opt = true,
    },
    {
      "mickael-menu/zk-nvim",
      setup = function()
        require("user.configs.zk").setup()
      end,
      config = function()
        require("user.configs.zk").config()
      end,
      -- ft = { "markdown" },
      opt = true,
      cmd = {
        "ZkAnnotateTask",
        "ZkOpenNotes",
        "ZkOrphans",
        "ZkCd",
        "ZkOpenNotebook",
        "ZkShowCalendar",
        "ZkFindOrCreateNote",
        "ZkFindOrCreateProjectNote",
        "ZkFindOrCreateJournalDailyNote",
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
      -- drowing
      "jbyuki/venn.nvim",
      ft = { "markdown" },
      opt = true,
      cmd = { "VBox" },
    },
    -- {
    --   "axkirillov/easypick.nvim",
    --   requires = "nvim-telescope/telescope.nvim",
    --   after = "telescope.nvim",
    --   opt = true,
    --   cmd = {
    --     "Easypick",
    --     "ZkFindOrCreateNote",
    --   },
    --   config = function()
    --     require("user.configs.easypick").config()
    --   end,
    -- },
    {
      "dhruvasagar/vim-table-mode",
      setup = function()
        require("user.configs.vim_table_mode").setup()
      end,
      ft = { "markdown" },
      opt = true,
    },
    -- {
    --   "dkarter/bullets.vim",
    --   setup = function()
    --     require("user.configs.bullets").setup()
    --   end,
    --   ft = "markdown",
    --   opt = true,
    --   config = function()
    --     require("user.configs.bullets").config()
    --   end,
    -- },
    {
      "gaoDean/autolist.nvim",
      ft = { "markdown" },
      config = function()
        require("autolist").setup({})
      end,
      opt = true,
    },

    -- color utils
    {
      "max397574/colortils.nvim",
      cmd = "Colortils",
      config = function()
        require("colortils").setup()
      end,
      opt = true,
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
      "gorbit99/codewindow.nvim",
      config = function()
        require("user.configs.codewindow").config()
      end,
      opt = true,
      cmd = {
        "ToggleMiniMap",
      },
      event = "BufRead",
    },
    {
      "anuvyklack/windows.nvim",
      requires = {
        "anuvyklack/middleclass",
      },
      config = function()
        require("user.configs.windows").config()
      end,
      cmd = {
        "WindowsMaximize",
        "WindowsEqualize",
        "WindowsMaximizeVertically",
        "WindowsMaximizeHorizontally",
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
    {
      "nguyenvukhang/nvim-toggler", -- Invert text in vim, purely with lua.
      event = "BufRead",
      opt = true,
      config = function()
        require("user.configs.nvim_toggler").config()
      end,
    },

    -- Toggle ruby block, tag etc.
    {
      "Wansmer/treesj",
      requires = { "nvim-treesitter" },
      config = function()
        require("user.configs.treesj").config()
      end,
      opt = true,
      cmd = {
        "TSJToggle",
        "TSJSplit",
        "TSJJoin",
      },
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
    {
      "levouh/tint.nvim",
      config = function()
        require("user.configs.tint").config()
      end,
      event = "BufRead",
      after = "nvim-treesitter",
    },
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
    -- image preview
    -- {
    --   "edluffy/hologram.nvim",
    --   config = function()
    --     require("hologram").setup({
    --       auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
    --     })
    --   end,
    -- },
    -- picker
    {
      "https://gitlab.com/yorickpeterse/nvim-window.git",
      config = function()
        require("user.configs.window").config()
      end,
    },
    {
      "mattn/calendar-vim",
      opt = true,
      setup = function()
        require("user.configs.calendar").setup()
      end,
      cmd = {
        "Calendar",
        "CalendarH",
        "CalendarT",
        "CalendarVR",
      },
    },
    -- terminal
    {
      "samjwill/nvim-unception", -- open files from terminal into existing neovim instace
    },

    -- tools
    {
      "narutoxy/silicon.lua", -- silicon is a lua plugin for neovim to generate beautiful images of code snippet using silicon
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("user.configs.silicon").config()
      end,
      opt = true,
      cmd = {
        "Silicon",
      },
    },
  }
end

return M
