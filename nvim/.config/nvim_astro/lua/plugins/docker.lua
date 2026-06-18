return {
  {
    "mgierada/lazydocker.nvim",
    cmd = "LazyDocker", -- Allows lazy-loading by defining a command
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.n["<leader>od"] = { function() require("lazydocker").open() end, desc = "LazyDocker" }
        end,
      },
    },
  },
}
