local function toggle_dim()
  if vim.g.dim == nil then vim.g.dim = false end

  if vim.g.dim then
    Snacks.dim.disable()
  else
    Snacks.dim.enable()
  end

  vim.g.dim = not vim.g.dim
end

return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    keys = {
      { "<leader>ns", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>nS", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<c-w>Z", function() Snacks.zen.zen() end, desc = "Zen window" },
      { "<c-w>z", function() Snacks.zen.zoom() end, desc = "Zoom window" },
      { "<leader>f/", function() Snacks.picker.lines() end, desc = "Search buffer" },
      { "<leader>z=", function() Snacks.picker.spelling() end, desc = "Spelling" },
      { "<leader>f?", function() Snacks.picker.search_history() end, desc = "Search history" },
      { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>fW", function() Snacks.picker.grep_word() end, desc = "Grep Word" },
      { "<leader>f<cr>", function() Snacks.picker.resume() end, desc = "Picker resume" },
      { "<leader>f[", function() Snacks.explorer() end, desc = "File explorer" },

      { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep Word", mode = { "v" } },

      { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>s<cr>", function() Snacks.picker.resume() end, desc = "Picker resume" },
      { "<leader>sp", function() Snacks.picker() end, desc = "List Pickers" },
      { "<leader>s;", function() Snacks.picker.command_history() end, desc = "List command history" },
      { "<leader>u<tab>", toggle_dim, desc = "Dim" },
    },
    opts = {
      bigfile = { enabled = true },
      words = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      input = { enabled = true },
      picker = {
        -- layout = "verti",
        layout = "telescope",
        win = {
          -- input window
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n" } },
              -- ["<C-q>"] = { "close", mode = { "n", "i" } },
              ["g."] = { "toggle_hidden", mode = { "n" } },
              ["gi"] = { "toggle_ignored", mode = { "n" } },
              -- ["<c-tab>"] = { "cycle_win", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
