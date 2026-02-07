return {
  "sindrets/diffview.nvim",
  opts = {
    disable_defaults = true, -- Disable all default keymaps
    keymaps = {
      view = {
        -- This ensures that 'q' only executes the DiffviewClose command
        { "n", "<C-q>", "<cmd>tabc<cr>" },
        -- You can also optionally disable other default 'q' related mappings
        -- if you are using 'disable_defaults = false'
        -- { "n", "q", false }, -- Example of unmapping a default key
      },
      -- Repeat for other panels if necessary:
      file_panel = {
        { "n", "<C-q>", "<cmd>tabc<cr>", silent = true },
      },
      file_history_panel = {
        { "n", "<C-q>", "<cmd>tabc<cr>", silent = true },
      },
      default = { -- Apply to all Diffview windows if not specifically mapped
        { "n", "<C-q>", "<cmd>tabc<cr>", silent = true },
      },
    },
  },
}
