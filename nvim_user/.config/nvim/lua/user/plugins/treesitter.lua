return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "David-Kunz/markid", -- A Neovim extension to highlight same-name identifiers with the same color.
    },
    opts = require("user.plugins.configs.treesitter"),
  },
  {
    "lewis6991/spellsitter.nvim",
    event = "InsertEnter",
    config = function()
      require("spellsitter").setup({
        -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
        enable = true,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufRead",
  },

  {
    "RRethy/nvim-treesitter-textsubjects",
    event = "BufRead",
  },

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
    "Wansmer/treesj",
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

  -- {
  --   "levouh/tint.nvim",
  --   config = function()
  --     require("user.plugins.configs.tint").config()
  --   end,
  --   event = "BufRead",
  --   after = "nvim-treesitter",
  -- },
}
