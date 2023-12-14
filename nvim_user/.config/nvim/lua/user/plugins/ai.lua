return {
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    -- config = function()
    --   vim.keymap.set("v", "<leader>gn", ":Gen<CR>")
    --   vim.keymap.set("n", "<leader>gn", ":Gen<CR>")
    --   require("gen").model = "mistral:instruct"
    --   require("gen").container = "ollama"
    -- end,
  },
  {
    "dense-analysis/neural",
    config = require("user.plugins.configs.neural"),
    dependencies = {
      "MunifTanjim/nui.nvim",
      "ElPiloto/significant.nvim",
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    opts = {
      yank_register = [[*]],
      keymaps = {
        close = { "<C-q>" },
        yank_last = "<C-y>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
      },
    },
    config = require("user.plugins.configs.chatgpt"),
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
    },
  },
}
