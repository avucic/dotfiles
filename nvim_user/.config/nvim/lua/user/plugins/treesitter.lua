return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "~/Desktop/markid", -- A Neovim extension to highlight same-name identifiers with the same color.
    },
    opts = require("user.plugins.configs.treesitter"),
  },
  {
    dir = "~/Desktop/markid",
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   event = "BufRead",
  -- },
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
      "TSCaptureUnderCursor",
    },
  },

  {
    "ziontee113/syntax-tree-surfer",
    event = "BufRead",
    opts = {
      highlight_group = "STS_highlight",
    },
  },
  {
    "Wansmer/treesj", -- splitting/joining blocks
    opts = {
      use_default_keymaps = false,
      max_join_length = 200,
    },
    config = require("user.plugins.configs.treesj"),
    cmd = {
      "TSJToggle",
      "TSJSplit",
      "TSJJoin",
    },
  },
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
  },
  {
    "mfussenegger/nvim-treehopper",
  },

  -- {
  --   "levouh/tint.nvim",
  --   config = function()
  --     require("user.plugins.configs.tint").config()
  --   end,
  --   event = "BufRead",
  --   after = "nvim-treesitter",
  -- },
}
