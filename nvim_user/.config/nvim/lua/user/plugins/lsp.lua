-- ["mason-tool-installer"] = { -- overrides `require("mason-tool-installer").setup(...)`
--   ensure_installed = {
--     "prettier",
--     "stylua",
--     "gopls",
--     -- "marksman",
--     "zk",
--     "eslint",
--     "rustfmt",
--     "codelldb",
--   },
-- },

return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "sumneko_lua",
        "solargraph",
        "gopls",
        "tsserver",
        "html",
        "cssls",
        "yamlls",
        "sqlls",
        "eslint",
        "vimls",
        "marksman",
        "zk",
        "svelte",
        "zls",
        "taplo",
        -- "grammarly"
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = require("user.plugins.configs.mason_null_ls"),
  },

  {
    "dnlhc/glance.nvim",
    config = function()
      require("user.configs.glance").config()
    end,
    opts = function()
      local actions = require("glance").actions

      return {
        height = 18, -- Height of the window
        border = {
          enable = false, -- Show window borders. Only horizontal borders allowed
          top_char = "―",
          bottom_char = "―",
        },
        list = {
          position = "right", -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
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
            ["<space>"] = actions.enter_win("preview"), -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<space>"] = actions.enter_win("list"), -- Focus list window
          },
        },
        hooks = {},
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = "│",
        },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      }
    end,
    cmd = { "Glance" },
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = { "IncRename" },
    opts = {
      preview_empty_name = true,
    },
    config = require("user.plugins.configs.inc_rename"),
  },
  {
    "ray-x/lsp_signature.nvim", -- lsp arguments
  },
  {
    "kosayoda/nvim-lightbulb",
    opts = {
      -- LSP client names to ignore
      -- Example: {"sumneko_lua", "null-ls"}
      -- ignore = { "zk" },
      sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 100,
      },
      float = {
        enabled = false,
        -- Text to show in the popup float
        text = "💡",

        -- Available keys for window options:
        -- - height     of floating window
        -- - width      of floating window
        -- - wrap_at    character to wrap at for computing height
        -- - max_width  maximal width of floating window
        -- - max_height maximal height of floating window
        -- - pad_left   number of columns to pad contents at left
        -- - pad_right  number of columns to pad contents at right
        -- - pad_top    number of lines to pad contents at top
        -- - pad_bottom number of lines to pad contents at bottom
        -- - offset_x   x-axis offset of the floating window
        -- - offset_y   y-axis offset of the floating window
        -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
        -- - winblend   transparency of the window (0-100)
        win_opts = {
          height = 4,
          with = 4,
        },
      },
      virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "💡",
        -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
        hl_mode = "blend",
      },
      status_text = {
        enabled = true,
        -- Text to provide when code actions are available
        text = "💡",
        -- Text to provide when no actions are available
        text_unavailable = "",
      },
      autocmd = {
        enabled = false,
        -- see :help autocmd-pattern
        pattern = { "*" },
        -- pattern = { "*" },
        -- see :help autocmd-events
        events = { "CursorHold", "CursorHoldI" },
      },
    },
    event = { "CursorHold", "CursorHoldI" },
    config = require("user.plugins.configs.lightbulb"),
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    init = function()
      vim.g.lsp_format_modifications_silence = 1
    end,
  },
}
