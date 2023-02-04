return {
  {
    "ggandor/leap.nvim",
    -- event = "BufReadPre",
    dependencies = {
      "ggandor/flit.nvim", -- f,F,t,T commands
    },
    config = require("user.plugins.configs.leap").config,
  },
  {
    "ggandor/leap-spooky.nvim",
    opt = {
      affixes = {
        -- These will generate mappings for all native text objects, like:
        -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
        -- Special line objects will also be added, by repeating the affixes.
        -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
        -- window.
        -- You can also use 'rest' & 'move' as mnemonics.
        remote = { window = "r", cross_window = "R" },
        magnetic = { window = "m", cross_window = "M" },
      },
      -- If this option is set to true, the yanked text will automatically be pasted
      -- at the cursor position if the unnamed register is in use.
      paste_on_remote_yank = false,
    },
    config = require("user.plugins.configs.leap_spooky"),
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
  },
}
