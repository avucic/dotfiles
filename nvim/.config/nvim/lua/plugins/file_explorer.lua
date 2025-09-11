return {
  {
    "simonmclean/triptych.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-tree/nvim-web-devicons", -- optional for icons
      "antosha417/nvim-lsp-file-operations", -- optional LSP integration
    },
    opts = {
      mappings = {
        toggle_hidden = "g.",
      },
    }, -- config options here
    keys = {
      -- { "<leader>e", ":Triptych<CR>" },
    },
    cmd = {
      "Triptych",
    },
  },
}
