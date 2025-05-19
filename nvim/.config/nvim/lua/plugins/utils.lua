return {
  {
    "voldikss/vim-browser-search",
    cmd = "BrowserSearch",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>sw"] = { "<cmd>BrowserSearch<cr>", desc = "Search Web" }
          maps.v["<Leader>sw"] = { "<cmd>BrowserSearch<cr>", desc = "Search Web" }
        end,
      },
    },
  },
  {
    "kraftwerk28/gtranslate.nvim",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.v["<leader>xg"] = { desc = "Translate" }
          maps.v["<leader>xge"] = { ":'<,'>Translate English<CR>", desc = "English" }
          maps.v["<leader>xgs"] = { ":'<,'>Translate Serbian<CR>", desc = "Serbian" }
        end,
      },
    },
    cmd = "Translate",
    opts = {
      default_to_language = "English",
    },
  },
}
