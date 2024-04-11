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
  -- {
  --   "phaazon/hop.nvim",
  --   branch = "v2", -- optional but strongly recommended
  --   event = "BufReadPre",
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     local hop = require("hop")
  --     hop.setup({ keys = "etovxqpdygfblzhckisuran" })
  --
  --     local directions = require("hop.hint").HintDirection
  --
  --     vim.keymap.set("", "s", function()
  --       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
  --     end, { remap = true })
  --     vim.keymap.set("", "S", function()
  --       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
  --     end, { remap = true })
  --
  --     vim.keymap.set("", "f", function()
  --       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  --     end, { remap = true })
  --     vim.keymap.set("", "F", function()
  --       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  --     end, { remap = true })
  --
  --     vim.keymap.set("", "t", function()
  --       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  --     end, { remap = true })
  --     vim.keymap.set("", "T", function()
  --       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  --     end, { remap = true })
  --   end,
  -- },
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
      rememberBuffers = false,
      keybindings = {
        ["<cr>"] = "open_file()",
        ["<esc>"] = "close_window()",
        t = "open_file_tabnew()",
        q = "close_window()",
        ["<c-v>"] = "open_file_vs()",
        ["<c-s>"] = "open_file_sp()",
      },

      mappings = {
        -- {
        --   pattern = "/app/components/(.*).html.erb$",
        --   target = "/app/components/%1.rb",
        --   context = "component",
        -- },
        {
          pattern = "/app/components/(.*)/component.rb",
          target = {
            {
              target = "/app/components/%1/component.html.erb",
              context = "html",
            },
            {
              target = "/spec/components/%1/component_spec.rb",
              context = "spec",
            },
          },
        },
        {
          pattern = "/app/components/(.*)/component.html.erb$",
          target = {
            {
              target = "/app/components/%1/component.rb",
              context = "component",
            },
            {
              target = "/spec/components/%1/component_spec.rb",
              context = "spec",
            },
          },
        },
        {
          pattern = "/app/controllers/(.*)_controller.rb",
          target = {
            {
              target = "/spec/requests/%1_spec.rb",
              context = "request_spec",
            },
            {
              target = "/app/views/%1/index.html.erb",
              context = "views",
            },
          },
        },
        {
          pattern = "/spec/requests/(.*)_spec.rb",
          target = "/app/controllers/%1_controller.rb",
          context = "request_spec",
        },
        {
          pattern = "/spec/(.*)_spec.rb",
          target = "/app/%1.rb",
          context = "spec",
        },
        {
          pattern = "/app/(.*).rb",
          target = "/spec/%1_spec.rb",
          context = "file",
        },
        {
          pattern = "/lib/(.*).rb",
          target = "/spec/lib/%1_spec.rb",
          context = "file",
        },
        {
          pattern = "/spec/lib/(.*)_spec.rb",
          target = "/lib/%1.rb",
          context = "spec",
        },
        {
          pattern = "/lib/(.*).rake",
          target = "/spec/lib/%1_spec.rb",
          context = "file",
        },
        {
          pattern = "/spec/lib/(.*)_spec.rb",
          target = "/lib/%1.rake",
          context = "spec",
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
          nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
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
          next_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
          previous_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
        },
      })
    end,
  },
}
