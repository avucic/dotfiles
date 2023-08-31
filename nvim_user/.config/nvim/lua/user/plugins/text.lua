return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufRead", -- TODO: laizy
    init = function()
      vim.g["VM_leader"] = "<m-\\>"
      vim.g["VM_default_mappings"] = 1
    end,
  },
  {
    "Vonr/align.nvim",
  },
  {
    "nguyenvukhang/nvim-toggler", -- Invert text in vim, purely with lua.
    -- event = "BufRead",
    opts = {
      -- your own inverses
      inverses = {
        ["build"] = "create",
        ["create"] = "build",
        ["after"] = "before",
        ["before"] = "after",
        ["required"] = "optional",
        ["optional"] = "required",
        -- ["true"] = "false",
        -- ["yes"] = "no",
        -- ["on"] = "off",
        -- ["left"] = "right",
        -- ["up"] = "down",
        -- ["!="] = "==",
      },
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
    },
    config = require("user.plugins.configs.nvim_toggler"),
  },
}
