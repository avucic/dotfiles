return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.motion.harpoon" },
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader><leader>e",
        "<cmd>Telescope harpoon marks<CR>",
        false,
        desc = "Show marks in Telescope",
      },
      {
        "<leader><leader>m",
        false,
      },
    },
  },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  {
    "folke/todo-comments.nvim",

    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "Identifier", "#f1a971" },
        hint = { "#f1a971" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      highlight = {
        -- keyword = "wide_fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      },
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
  },
  {

    "nvim-neotest/neotest",
    config = require("user.plugins.configs.neotest"),
    ft = { "go", "rust", "ruby" },
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-treesitter/nvim-treesitter", -- this adding nvim-treesitter
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
    },
  },
  {
    "stevearc/overseer.nvim",
    config = require("user.plugins.configs.overseer"),
    opts = {
      strategy = "toggleterm",
    },
  },

  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
