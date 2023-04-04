return {
  {
    -- TODO: require this
    "theHamsta/nvim-dap-virtual-text",
    event = "User AstroFile",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = require("user.plugins.configs.mason_nvim_dap"),
  },
}
