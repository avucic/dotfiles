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
    "danielfalk/smart-open.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    -- branch = "0.2.x",
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup()
    end,
  },
}
