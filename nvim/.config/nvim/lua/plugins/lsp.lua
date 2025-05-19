return {
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts) require("lsp_signature").setup(opts) end,
  -- },
  {
    "dnlhc/glance.nvim",
    lazy = true,
    config = function(_, opts)
      local actions = require("glance").actions

      require("glance").setup {
        zindex = 1000,

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        detached = false,
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["<space>"] = actions.enter_win "preview", -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            ["<c-j>"] = actions.close,
            ["<c-k>"] = actions.close,
            ["<c-l>"] = actions.close,
            ["<c-h>"] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["q"] = actions.close,
            ["<c-j>"] = actions.close,
            ["<c-k>"] = actions.close,
            ["<c-l>"] = actions.close,
            ["<c-h>"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<space>"] = actions.enter_win "list", -- Focus list window
          },
        },
      }

      vim.cmd [[hi GlancePreviewMatch NONE]] -- Fix search highlight
    end,
    cmd = { "Glance" },
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = function()
      require("tsc").setup {
        run_as_monorepo = true,
        use_trouble_qflist = false,
      }
    end,
  },

  -- {
  --   "kosayoda/nvim-lightbulb",
  --   lazy = true,
  --   dependencies = {
  --     { "AstroNvim/astrolsp", opts = {} },
  --   },
  --   opts = {
  --     -- LSP client names to ignore
  --     -- Example: {"sumneko_lua", "null-ls"}
  --     -- ignore = { "zk" },
  --     sign = {
  --       enabled = true,
  --       -- Priority of the gutter sign
  --       priority = 100,
  --     },
  --     float = {
  --       enabled = false,
  --       -- Text to show in the popup float
  --       text = "💡",
  --       -- Available keys for window options:
  --       -- - height     of floating window
  --       -- - width      of floating window
  --       -- - wrap_at    character to wrap at for computing height
  --       -- - max_width  maximal width of floating window
  --       -- - max_height maximal height of floating window
  --       -- - pad_left   number of columns to pad contents at left
  --       -- - pad_right  number of columns to pad contents at right
  --       -- - pad_top    number of lines to pad contents at top
  --       -- - pad_bottom number of lines to pad contents at bottom
  --       -- - offset_x   x-axis offset of the floating window
  --       -- - offset_y   y-axis offset of the floating window
  --       -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
  --       -- - winblend   transparency of the window (0-100)
  --       win_opts = {
  --         height = 4,
  --         with = 4,
  --       },
  --     },
  --     virtual_text = {
  --       enabled = false,
  --       -- Text to show at virtual text
  --       text = "💡",
  --       -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
  --       hl_mode = "combine",
  --     },
  --     status_text = {
  --       enabled = true,
  --       -- Text to provide when code actions are available
  --       text = "💡",
  --       -- Text to provide when no actions are available
  --       text_unavailable = "",
  --     },
  --     autocmd = {
  --       enabled = false,
  --       -- see :help autocmd-pattern
  --       pattern = { "*" },
  --       -- pattern = { "*" },
  --       -- see :help autocmd-events
  --       events = { "CursorHold", "CursorHoldI" },
  --     },
  --   },
  --   -- event = { "CursorHold", "CursorHoldI" },
  --   event = "LspAttach",
  --   config = function(_, opts)
  --     require("nvim-lightbulb").setup(opts)
  --     vim.cmd [[
  --    augroup LightBulb
  --             autocmd!
  --             autocmd CursorHold,CursorHoldI  *\(.md\|.diffs\)\@<! lua require'nvim-lightbulb'.update_lightbulb({priority = 10})
  --             autocmd BufLeave,WinLeave  *\(.md\|.diffs\)\@<! lua vim.fn.sign_unplace("nvim-lightbulb")
  --     augroup end
  --   ]]
  --   end,
  -- },
}
