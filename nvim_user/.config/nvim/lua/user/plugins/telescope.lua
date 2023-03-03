return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = require("user.plugins.configs.telescope"),
    config = function(plg, opts)
      require("plugins.configs.telescope")(plg, opts)

      local telescope = require("telescope")
      telescope.load_extension("file_browser")
      telescope.load_extension("textcase")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  {
    "gbrlsnchs/telescope-lsp-handlers.nvim",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim", -- live grap with args
  },
  {
    "princejoogie/dir-telescope.nvim",
    -- telescope.nvim is a required dependency
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup({
        hidden = false,
        respect_gitignore = true,
      })
    end,
  },
  {
    "avucic/telescope-vim-bookmarks.nvim",
    init = require("user.plugins.configs.vim_bookmarks").init,
    dependencies = { "MattesGroeger/vim-bookmarks" },
    cmd = {
      "BookmarkToggle",
      "BookmarkAnnotate",
      "BookmarkClear",
      "BookmarkClearAll",
    },
  },
  {
    "johmsalas/text-case.nvim",
    cmd = {
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("textcase")
    end,
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
  },
  {
    "nvim-telescope/telescope-project.nvim",
  },
  { "LukasPietzschmann/telescope-tabs" },
  {
    "jedrzejboczar/toggletasks.nvim",
    config = require("user.plugins.configs.toggletasks"),
  },
  {
    "danielfalk/smart-open.nvim",
    dependencies = { "kkharji/sqlite.lua" },
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
      },
    },
    config = require("user.plugins.configs.neoclip"),
  },
}
