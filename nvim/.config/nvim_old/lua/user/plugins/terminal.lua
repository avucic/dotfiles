return {
  {
    "samjwill/nvim-unception", -- open files from terminal into existing neovim instace
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = require("user.plugins.configs.toggleterm").opts(),
  },
}
