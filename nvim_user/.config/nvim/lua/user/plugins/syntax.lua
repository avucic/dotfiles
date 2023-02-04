return {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    cmd = {
      "TodoLocList",
      "TodoQuickFix",
      "TodoTrouble",
      "TodoTelescope",
    },
  },
  {
    "folke/paint.nvim", -- highlight symbols in code like @something TODO:
    event = "BufRead",
    opts = {
      highlights = {
        {
          filter = { filetype = "lua" },
          pattern = "%s*%-%-%-%s*(@%w+)",
          hl = "Constant",
        },
        {
          filter = function()
            return true
          end,
          pattern = "TODO:",
          hl = "@text.note",
        },

        {
          filter = function()
            return true
          end,
          pattern = "NOTE:",
          hl = "@text.note",
        },
      },
    },
    config = require("user.plugins.configs.paint"),
  },
  -- {
  --  "dominikduda/vim_current_word",
  -- - event = "BufRead",
  -- },
}
