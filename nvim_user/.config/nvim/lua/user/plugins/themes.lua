return {
  {
    "AstroNvim/astrotheme",
    opts = require("user.plugins.configs.astrotheme")
  },

  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "lighter"
    end,
    config = function()
      require("material").setup()
    end,
  },
}
