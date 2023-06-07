return {
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
        telescope = require("telescope.themes").get_dropdown({
          layout_config = { width = 0.4 },
        }),
      },
    },
  },
  {
    "echasnovski/mini.nvim",
    config = function(_opts)
      -- require("mini.jump").setup()
      require("mini.move").setup()
      require("mini.ai").setup()
    end,
    event = "BufEnter",
  },

  {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZMinimalist",
      "TZFocus",
      "TZAtaraxis",
      "TZNarrow",
    },
    opts = {
      modes = {
        -- configurations per mode
        ataraxis = {
          shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
          backdrop = 0,   -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
          minimum_writing_area = {
            -- minimum size of main window
            width = 70,
            height = 44,
          },
          quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
          padding = {
            -- padding windows
            left = 52,
            right = 52,
            top = 0,
            bottom = 0,
          },
          callbacks = {
            -- run functions when opening/closing Ataraxis mode
            open_pre = nil,
            open_pos = nil,
            close_pre = nil,
            close_pos = nil,
          },
        },
        minimalist = {
          ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
          options = {
            -- options to be disabled when entering Minimalist mode
            number = false,
            relativenumber = false,
            showtabline = 0,
            signcolumn = "no",
            statusline = "",
            cmdheight = 1,
            laststatus = 0,
            showcmd = false,
            showmode = false,
            ruler = false,
            numberwidth = 1,
          },
          callbacks = {
            -- run functions when opening/closing Minimalist mode
            open_pre = nil,
            open_pos = nil,
            close_pre = nil,
            close_pos = nil,
          },
        },
        narrow = {
          --- change the style of the fold lines. Set it to:
          --- `informative`: to get nice pre-baked folds
          --- `invisible`: hide them
          --- function() end: pass a custom func with your fold lines. See :h foldtext
          folds_style = "informative",
          run_ataraxis = true, -- display narrowed text in a Ataraxis session
          callbacks = {
            -- run functions when opening/closing Narrow mode
            open_pre = function()
              vim.wo.foldmethod = "manual"
            end,
            open_pos = nil,
            close_pre = nil,
            close_pos = function()
              vim.wo.foldmethod = "expr"
              -- vim.opt.foldmethod = "expr"
              -- vim.cmd[[set foldmethod=expr]]
            end,
          },
        },
        focus = {
          callbacks = {
            -- run functions when opening/closing Focus mode
            open_pre = nil,
            open_pos = nil,
            close_pre = nil,
            close_pos = nil,
          },
        },
      },
      integrations = {
        tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
        kitty = {
          -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
          enabled = false,
          font = "+3",
        },
        twilight = false, -- enable twilight (ataraxis)
        lualine = false,  -- hide nvim-lualine (ataraxis)
      },
    },
    config = require("user.plugins.configs.true_zen"),
  },
  {
    "gorbit99/codewindow.nvim",
    opts = {
      exclude_filetypes = {
        "neo-tree",
      },
    },
    config = require("user.plugins.configs.codewindow"),
  },

  {
    "nyngwang/NeoZoom.lua",
    opts = {
      {
        -- top_ratio = 0,
        -- left_ratio = 0.225,
        -- width_ratio = 0.775,
        -- height_ratio = 0.925,
        -- border = 'double',
        -- disable_by_cursor = true, -- zoom-out/unfocus when you click anywhere else.
        -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
        exclude_buftypes = { "terminal" },
        presets = {
          {
            filetypes = { "dapui_.*", "dap-repl" },
            config = {
              top_ratio = 0.25,
              left_ratio = 0.6,
              width_ratio = 0.4,
              height_ratio = 0.65,
            },
            callbacks = {
              function()
                vim.wo.wrap = true
              end,
            },
          },
        },
        -- popup = {
        --   -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
        --   -- This way you won't see two windows of the same buffer
        --   -- got updated at the same time.
        --   enabled = true,
        --   exclude_filetypes = {},
        --   exclude_buftypes = {},
        -- },
      },
    },
    config = require("user.plugins.configs.neozoom"),
    cmd = { "NeoZoomToggle" },
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      -- "anuvyklack/animation.nvim",
    },
    opts = {
      {
        ignore = {
          buftype = { "quickfix", "filetree" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "filetree" },
        },
      },
    },
    config = require("user.plugins.configs.windows"),
    cmd = {
      "WindowsMaximize",
      "WindowsEqualize",
      "WindowsMaximizeVertically",
      "WindowsMaximizeHorizontally",
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    requires = { "junegunn/fzf" },
    ft = "qf",
  },

  {
    "junegunn/fzf",
    ft = "qf",
  },
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-alt-substitute",
    opts = true,
    -- lazy-loading with `cmd =` does not work well with incremental preview
    event = "CmdlineEnter",
  },
}
