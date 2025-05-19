local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  "n",
  "<c-a>",
  -- function() require("codecompanion").prompt "commit_message" end,
  function()
    vim.notify "Fetching ai message..."
    require("codecompanion").prompt "commit_message"
  end,
  { desc = "AI commit message", buffer = bufnr }
)
