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
        ["key"] = "value",
        ["value"] = "key",
        ["if"] = "unless",
        ["unless"] = "if",
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
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
    end,
  },
}
