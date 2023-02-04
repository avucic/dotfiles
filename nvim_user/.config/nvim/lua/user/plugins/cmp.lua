return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      --   "saadparwaiz1/cmp_luasnip",
      --   "hrsh7th/cmp-buffer",
      --   "hrsh7th/cmp-path",
      --   "hrsh7th/cmp-nvim-lsp",
      --
      "hrsh7th/cmp-emoji",
      -- "f3fora/cmp-spell",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.vsnip" } })
      require("codeium")
      require("crates")

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline_history" },
          { name = "cmdline" },
        },
      })
      table.insert(opts.sources, { name = "emoji", priority = 2000 })
      -- table.insert(opts.sources, { name = "spell" })
      table.insert(opts.sources, { name = "codeium", group_index = 1 })
      opts.duplicates.codeium = 1

      return opts
    end,
  },
  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    config = function()
      require("crates").setup()
    end,
  },
}
