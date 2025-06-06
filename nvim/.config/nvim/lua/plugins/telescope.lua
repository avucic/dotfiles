local actions = require "telescope.actions"
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<c-c>"] = actions.close,
            ["<esc>"] = false,
          },
          n = {
            ["q"] = actions.close,
            ["<c-c>"] = actions.close,
            ["<esc>"] = false,
          },
        },
      },
    },
  },
}
