-- let actions = require("oil.actions")

function Rename(file)
  vim.cmd("bdelete!")
  vim.cmd("edit " .. vim.fn.readfile(file)[1])
end

-- function Delete()
--   local file = vim.fn.expand("%:p")
--   if io.open(file, "r") == nil then
--     vim.cmd([[BWnex]])
--   end
-- end

return {
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
  {
    "is0n/fm-nvim",
    config = function()
      require("fm-nvim").setup({
        -- (Vim) Command used to open files
        edit_cmd = "edit",

        -- See `Q&A` for more info
        on_close = {
          function()
            vim.cmd([[ BWnex ]])
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

        -- Mappings used with the plugin
        mappings = {
          vert_split = "<C-v>",
          horz_split = "<C-h>",
          tabedit = "<C-t>",
          edit = "<C-e>",
        },
        cmds = {
          lazydocker_cmd = "lazydocker",
        },
      })
    end,
    cmd = {
      "Neomutt",
      "Lazygit",
      "Lazydocker",
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
