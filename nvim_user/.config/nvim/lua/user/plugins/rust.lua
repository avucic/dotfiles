return {
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    config = function()
      require("crates").setup()
    end,
    ft = "toml",
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = require("user.plugins.configs.rust_tools"),
  },
}
