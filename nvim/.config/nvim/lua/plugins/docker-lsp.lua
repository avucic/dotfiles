return {
  -- {
  --   "spcontainers/lspcontainers.nvim",
  -- },
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        -- Ruby example with Solargraph running inside container
        solargraph = {
          cmd = {
            "docker",
            "exec",
            "-i",
            "your_container_name",
            "bundle",
            "exec",
            "solargraph",
            "stdio",
          },
          root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
        },
      },
    },
  },
}
