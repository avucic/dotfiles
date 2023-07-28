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
          ["<C-l>"] = "actions.refresh",
          ["h"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["<c-h>"] = "actions.toggle_hidden",
        },
      })
    end,
  },
  -- {
  --   "lvim-tech/lvim-shell",
  --   lazy = false,
  --   config = function()
  --     local lvim_shell = require("lvim-shell")
  --
  --     -- Ranger
  --     _G.Ranger = function(dir)
  --       dir = dir or "."
  --       lvim_shell.float("ranger --choosefiles=/tmp/lvim-shell " .. dir, "l")
  --     end
  --     vim.cmd("command! -nargs=? -complete=dir Ranger :lua _G.Ranger(<f-args>)")
  --     vim.keymap.set("n", "<C-c>r", function()
  --       vim.cmd("Ranger")
  --     end, { noremap = true, silent = true, desc = "Ranger" })
  --
  --     -- Vifm
  --     _G.Vifm = function(dir)
  --       dir = dir or "."
  --       lvim_shell.float("vifm --choose-files /tmp/lvim-shell " .. dir, "l")
  --     end
  --     vim.cmd("command! -nargs=? -complete=dir Vifm :lua _G.Ranger(<f-args>)")
  --     vim.keymap.set("n", "<C-c>v", function()
  --       vim.cmd("Ranger")
  --     end, { noremap = true, silent = true, desc = "Vifm" })
  --
  --     -- Lazygit
  --     _G.Lazygit = function(dir)
  --       dir = dir or "."
  --       lvim_shell.float("lazygit -w " .. dir, "l")
  --     end
  --     vim.cmd("command! -nargs=? -complete=dir Lazygit :lua _G.Lazygit(<f-args>)")
  --     vim.keymap.set("n", "<C-c>g", function()
  --       vim.cmd("Lazygit")
  --     end, { noremap = true, silent = true, desc = "Lazygit" })
  --   end,
  -- },
  -- {
  --   "lvim-tech/lvim-fm",
  --   dependencies = { "lvim-tech/lvim-shell" },
  --   config = function()
  --     require("lvim-fm").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  --   cmd = {
  --     "LvimFileManager",
  --   },
  -- },
}
