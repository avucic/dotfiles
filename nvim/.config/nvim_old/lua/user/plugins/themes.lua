return {
  {
    "AstroNvim/astrotheme",
    opts = require("user.plugins.configs.astrotheme"),
  },
  { "yorik1984/newpaper.nvim" },
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "lighter"
    end,
    config = function()
      require("material").setup()
    end,
  },
  {
    lazy = false,
    "shaunsingh/nord.nvim",
  },
}
