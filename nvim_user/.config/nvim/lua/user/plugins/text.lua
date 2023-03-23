return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
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
      -- inverses = {
      --   ["true"] = "false",
      --   ["yes"] = "no",
      --   ["on"] = "off",
      --   ["left"] = "right",
      --   ["up"] = "down",
      --   ["!="] = "==",
      -- },
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
    },
    config = require("user.plugins.configs.nvim_toggler"),
  },
}
