return {
  {
    "avucic/window_picker",
    dir = "./custom/window_picker",
    virtual = true,
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["gw"] = { "<cmd>lua require('plugins.custom.window_picker').pick()<cr>" }
          maps.n["<c-w>p"] = { "<cmd>lua require('plugins.custom.window_picker').pick()<cr>", desc = "Pick window" }
          maps.n["<c-w>d"] = {
            "<cmd>lua require('plugins.custom.window_picker').pick({delete = true })<cr>",
            desc = "Pick to delete",
          }
        end,
      },
    },
  },
  {
    "avucic/open_in_finder",
    virtual = true,
    dir = "./custom/open_in_finder",
    lazy = true,
    config = function() require("plugins.custom.open_in_finder").setup() end,
    cmd = {
      "OpenFile",
      "OpenFolderInFinder",
    },
  },

  {
    "avucic/gen_pass",
    virtual = true,
    dir = "./custom/gen_pass",
    config = function() require("plugins.custom.gen_pass").setup() end,
    cmd = {
      "GenPass",
      "OpenFolderInFinder",
    },
  },
  {
    "avucic/date_picker",
    virtual = true,
    lazy = true,
    dir = "./custom/date_picker",
    config = function() require("plugins.custom.date_picker").setup() end,
  },

  {
    "avucic/apply_macro_to_visual_selection",
    virtual = true,
    lazy = true,
    dir = "./custom/apply_macro_to_visual_selection",
    config = function() require("plugins.custom.apply_macro_to_visual_selection").setup() end,
  },
  {
    "avucic/oil_explorer_bookmarks",
    virtual = true,
    lazy = true,
    dir = "./custom/oil_explorer_bookmarks.lua",
    cmd = { "OilBookmarks" },
    config = function() require("plugins.custom.oil_explorer_bookmarks").setup() end,
  },

  {
    "avucic/paste-markdown-url",
    build = "pip3 install requests beautifulsoup4 lxml",
    config = function() require "paste-markdown-url" end,
    ft = "markdown",
    cmd = { "PasteMDLink" },
  },
}
