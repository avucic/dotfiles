return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.test.neotest" },
  {
    "nvim-neotest/neotest",
    config = require("user.plugins.configs.neotest"),
    ft = { "go", "rust", "ruby" },
    dependencies = {
      -- "nvim-neotest/neotest-go",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
    },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = "toggleterm",
    },
  },

  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
