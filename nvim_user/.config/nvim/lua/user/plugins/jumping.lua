return {
  {
    event = "BufRead",
    "cbochs/portal.nvim",
    config = require("user.plugins.configs.portal")
  },
  {
    -- "ggandor/lightspeed.nvim",
    "ggandor/leap.nvim",
    -- event = "BufReadPre",
    dependencies = {
      "ggandor/flit.nvim", -- f,F,t,T commands
    },
    config = require("user.plugins.configs.leap").config(),
  },
  {
    "andymass/vim-matchup",
    event = "BufRead",
  },
  {
    "ggandor/flit.nvim", -- f,F,t,T commands
    opts = {
      keys = { f = "f", F = "F", t = "t", T = "T" },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "v",
      multiline = true,
      -- Like `leap`s similar argument (call-specific overrides).
      -- E.g.: opts = { equivalence_classes = {} }
      opts = {},
    },

    config = require("user.plugins.configs.flit"),
  }
}
