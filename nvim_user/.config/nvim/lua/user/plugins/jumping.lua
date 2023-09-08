return {
  {
    "ggandor/leap.nvim",
    event = "BufReadPre",
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
  -- {
  --   "ggandor/flit.nvim", -- f,F,t,T commands
  --   opts = {
  --     keys = { f = "f", F = "F", t = "t", T = "T" },
  --     -- A string like "nv", "nvo", "o", etc.
  --     labeled_modes = "v",
  --     multiline = true,
  --     -- Like `leap`s similar argument (call-specific overrides).
  --     -- E.g.: opts = { equivalence_classes = {} }
  --     opts = {},
  --   },
  --   event = "BufRead",
  --   config = require("user.plugins.configs.flit"),
  -- },
  {
    "rgroli/other.nvim",
    cmd = { "Other", "OtherClear" },
    opts = {
      mappings = {
        -- builtin mappings
        -- "golang",
        -- custom mapping
        {
          pattern = "/app/controllers/(.*)/(.*)/(.*)_controller.rb",
          target = "/spec/requests/%1/%2/%3_spec.rb",
        },
        {
          pattern = "/app/controllers/(.*)/(.*)_controller.rb",
          target = "/spec/requests/%1/%2_spec.rb",
        },
        {
          pattern = "/app/controllers/(.*)_controller.rb",
          target = "/spec/requests/%1_spec.rb",
        },
        {
          pattern = "/spec/requests/(.*)_spec.rb",
          target = "/app/controllers/%1_controller.rb",
        },
        {
          pattern = "/spec/requests/(.*)/(.*)_spec.rb",
          target = "/app/controllers/%1/%2_controller.rb",
        },
        {
          pattern = "/app/(.*)/(.*)/(.*).rb",
          target = "/spec/%1/%2/%3_spec.rb",
        },
        {
          pattern = "/spec/(.*)/(.*)/(.*)_spec.rb",
          target = "/app/%1/%2/%3.rb",
        },
        {
          pattern = "/app/(.*)/(.*).rb",
          target = "/spec/%1/%2_spec.rb",
        },
        {
          pattern = "/spec/(.*)/(.*)_spec.rb",
          target = "/app/%1/%2.rb",
        },
      },
    },
    config = require("user.plugins.configs.other"),
  },
  {
    "LeonHeidelbach/trailblazer.nvim",
    event = "BufRead",
    config = function()
      require("trailblazer").setup({
        -- your custom config goes here
        mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
          nv = {     -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
            motions = {
              new_trail_mark = "mm",
              track_back = "mb",
              peek_move_next_down = "mn",
              peek_move_previous_up = "mp",
              move_to_nearest = "ml",
              toggle_trail_mark_list = "ma",
            },
            actions = {
              delete_all_trail_marks = "mD",
              paste_at_last_trail_mark = "my",
              paste_at_all_trail_marks = "mY",
              set_trail_mark_select_mode = "mt",
              switch_to_next_trail_mark_stack = "m.",
              switch_to_previous_trail_mark_stack = "m,",
              set_trail_mark_stack_sort_mode = "ms",
            },
          },
          -- You can also add/move any motion or action to mode specific mappings i.e.:
          -- i = {
          --     motions = {
          --         new_trail_mark = '<C-l>',
          --         ...
          --     },
          --     ...
          -- },
        },
        trail_options = {
          newest_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
          cursor_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
          next_mark_symbol = "⚑",   -- disable this mark symbol by setting its value to ""
          previous_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
        },
      })
    end,
  },
}
