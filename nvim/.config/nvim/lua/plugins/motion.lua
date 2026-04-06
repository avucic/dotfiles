return {

  {
    "heilgar/bookmarks.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["m"] = { desc = "Bookmarks" }
          maps.n["ma"] = { "<cmd>BookmarkAdd<cr>", desc = "Add bookmark" }
          maps.n["md"] = { "<cmd>BookmarkRemove<cr>", desc = "Remove bookmark" }
          maps.n["ms"] = { ":BookmarkListSwitch ", desc = "Switch bookmark list" }
          maps.n["ml"] = { "<cmd>Bookmarks<cr>", desc = "Bookmark list" }
          maps.n["mC"] = { ":BookmarkListCreate ", desc = "Create Bookmark list" }
          maps.n["mD"] = { ":BookmarkListDelete ", desc = "Create Bookmark list" }
          maps.n["mL"] = { "<cmd>BookmarkListShow<cr>", desc = "Show Bookmark lists" }
          maps.n["mR"] = { ":BookmarkListRename ", desc = "Rename Bookmark list" }
        end,
      },
    },
    config = function()
      require("bookmarks").setup {
        -- your configuration comes here
        -- or leave empty to use defaults
        default_mappings = false,
        db_path = vim.fn.stdpath "data" .. "/bookmarks.db",
        mappings = {
          add = "ma", -- Add bookmark at current line
          delete = "md", -- Delete bookmark at current line
          list = "ml", -- List all bookmarks
        },
      }
      require("telescope").load_extension "bookmarks"
      -- vim.api.nvim_set_hl(0, "BookmarkHighlight", {})
    end,
    cmd = {
      "BookmarkAdd",
      "BookmarkRemove",
      "Bookmarks",
      "BookmarkListDelete",
      "BookmarkListShow",
      "BookmarkListCreate",
      "BookmarkListRename",
      "BookmarkListSwitch",
    },
    keys = {
      -- { "ma", "<cmd>BookmarkAdd<cr>", desc = "Add Bookmark" },
      -- { "md", "<cmd>BookmarkRemove<cr>", desc = "Remove Bookmark" },
      -- { "mn", desc = "Jump to Next Bookmark" },
      -- { "mp", desc = "Jump to Previous Bookmark" },
      -- { "mA", "<cmd>Bookmarks<cr>", desc = "List Bookmarks" },
      -- { "ms", desc = "Switch Bookmark List" },
    },
  },
  -- {
  --   "LeonHeidelbach/trailblazer.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     {
  --       "AstroNvim/astrocore",
  --       opts = function(_, opts)
  --         local maps = opts.mappings
  --         maps.n["m"] = { desc = "TrailBlazer" }
  --         maps.n["mm"] = { "<cmd>TrailBlazerNewTrailMark<cr>", desc = "Toggle mark" }
  --         maps.n["mp"] = { "<cmd>TrailBlazerPeekMovePreviousUp<cr>", desc = "Trail back" }
  --         maps.n["mn"] = { "<cmd>TrailBlazerPeekMoveNextDown<cr>", desc = "Trail next" }
  --         maps.n["ml"] = { "<cmd>TrailBlazerMoveToNearest<cr>", desc = "Trail nearest" }
  --         maps.n["mD"] = { "<cmd>TrailBlazerDeleteAllTrailMarks<cr>", desc = "Delete all marks" }
  --         maps.n["ma"] = { "<cmd>TrailBlazerToggleTrailMarkList<cr>", desc = "List all marks" }
  --       end,
  --     },
  --   },
  --   cmd = {
  --     "TrailBlazerNewTrailMark",
  --     "TrailBlazerTrackBack",
  --     "TrailBlazerPeekMovePreviousUp",
  --     "TrailBlazerPeekMoveNextDown",
  --     "TrailBlazerMoveToNearest",
  --     "TrailBlazerDeleteAllTrailMarks",
  --     "TrailBlazerToggleTrailMarkList",
  --   },
  --   config = function()
  --     require("trailblazer").setup {
  --       trail_options = {
  --         multiple_mark_symbol_counters_enabled = false,
  --         newest_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
  --         cursor_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
  --         next_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
  --         previous_mark_symbol = "⚑", -- disable this mark symbol by setting its value to ""
  --       },
  --       -- your custom config goes here
  --       -- mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
  --       --   nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
  --       --     motions = {
  --       --       new_trail_mark = "mm",
  --       --       track_back = "mb",
  --       --       peek_move_next_down = "mn",
  --       --       peek_move_previous_up = "mp",
  --       --       move_to_nearest = "ml",
  --       --       toggle_trail_mark_list = "ma",
  --       --     },
  --       --     actions = {
  --       --       delete_all_trail_marks = "mD",
  --       --       paste_at_last_trail_mark = "my",
  --       --       paste_at_all_trail_marks = "mY",
  --       --       set_trail_mark_select_mode = "mt",
  --       --       switch_to_next_trail_mark_stack = "m.",
  --       --       switch_to_previous_trail_mark_stack = "m,",
  --       --       set_trail_mark_stack_sort_mode = "ms",
  --       --     },
  --       --   },
  --       --   -- You can also add/move any motion or action to mode specific mappings i.e.:
  --       --   -- i = {
  --       --   --     motions = {
  --       --   --         new_trail_mark = '<C-l>',
  --       --   --         ...
  --       --   --     },
  --       --   --     ...
  --       --   -- },
  --       -- },
  --     }
  --   end,
  -- },
  -- {
  --   "chentoast/marks.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "ton/vim-bufsurf",
  --   event = "VeryLazy",
  --   dependencies = {
  --     {
  --       "AstroNvim/astrocore",
  --       opts = function(_, opts)
  --         local maps = opts.mappings
  --         maps.n["<c-i>"] = { "<Plug>(buf-surf-forward)", desc = "Buffer surf forward" }
  --         maps.n["<c-o>"] = { "<Plug>(buf-surf-back)", desc = "Buffer surf backward" }
  --       end,
  --     },
  --   },
  --   config = function()
  --     local ok, cybu = pcall(require, "cybu")
  --     if not ok then return end
  --     cybu.setup()
  --     vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
  --     vim.keymap.set("n", "J", "<Plug>(CybuNext)")
  --     vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
  --     vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)")
  --   end,
  -- },
  {
    "kwkarlwang/bufjump.nvim",
    config = function()
      require("bufjump").setup {
        forward_key = "<C-n>",
        backward_key = "<C-p>",
        on_success = nil,
      }
    end,
  },
}
