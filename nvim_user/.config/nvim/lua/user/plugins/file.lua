-- let actions = require("oil.actions")
return {
  -- {
  --   "kelly-lin/ranger.nvim",
  --   config = function()
  --     require("ranger-nvim").setup({
  --       enable_cmds = true,
  --       replace_netrw = true,
  --       ui = {
  --         border = "double",
  --         height = 0.7,
  --         width = 0.7,
  --         x = 0.5,
  --         y = 0.5,
  --       },
  --     })
  --   end,
  --   cmd = { "Ranger" },
  -- },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["q"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          -- ["h"] = "actions.parent",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["<c-h>"] = "actions.toggle_hidden",
        },
      })
    end,
  },
  -- {
  --   "lmburns/lf.nvim",
  --   config = function()
  --     -- This feature will not work if the plugin is lazy-loaded
  --     vim.g.lf_netrw = 1
  --
  --     require("lf").setup({
  --       escape_quit = false,
  --       border = "rounded",
  --     })
  --
  --     -- vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
  --
  --     vim.api.nvim_create_autocmd({
  --       event = "User",
  --       pattern = "LfTermEnter",
  --       callback = function(a)
  --         vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true })
  --       end,
  --     })
  --   end,
  --   cmd = { "Lf" },
  --   -- requires = { "toggleterm.nvim" },
  -- },
  {
    "is0n/fm-nvim",
    config = function()
      require("fm-nvim").setup({
        -- (Vim) Command used to open files
        edit_cmd = "edit",

        -- See `Q&A` for more info
        on_close = {
          function()
            vim.cmd("BWnex")
          end,
        },
        on_open = {},

        -- UI Options
        ui = {
          -- Default UI (can be "split" or "float")
          default = "float",

          float = {
            -- Floating window border (see ':h nvim_open_win')
            border = "double",

            -- Highlight group for floating window/border (see ':h winhl')
            float_hl = "Normal",
            border_hl = "FloatBorder",

            -- Floating Window Transparency (see ':h winblend')
            blend = 0,

            -- Num from 0 - 1 for measurements
            height = 0.8,
            width = 0.8,

            -- X and Y Axis of Window
            x = 0.5,
            y = 0.5,
          },

          split = {
            -- Direction of split
            direction = "topleft",

            -- Size of split
            size = 24,
          },
        },

        -- Terminal commands used w/ file manager (have to be in your $PATH)
        cmds = {
          vifm_cmd = "vifm",
          taskwarrior_cmd = "taskwarrior-tui",
        },

        -- Mappings used with the plugin
        mappings = {
          vert_split = "<C-v>",
          horz_split = "<C-h>",
          tabedit = "<C-t>",
          edit = "<C-e>",
          ESC = "<ESC>",
        },

        -- Path to broot config
        broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson",
      })
    end,
    cmd = {
      "Neomutt",
      "Lazygit",
      "Joshuto",
      "Ranger",
      "Broot",
      "Gitui",
      "Xplr",
      "Vifm",
      "Skim",
      "Nnn",
      "Fff",
      "Twf",
      "Fzf",
      "Fzy",
      "Lf",
      "Fm",
    },
  },
}
