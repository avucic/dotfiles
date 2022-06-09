local M = {}

function M.config()
  local present, navigator = pcall(require, "Navigator")
  if not present then
    return
  end

  local navigator = require("user.utils").load_module("Navigator")

  navigator.setup()

  -- local map = vim.api.nvim_set_keymap
  -- local default_options = { noremap = true, silent = true }
  -- -- tmux navigation
  -- -- map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>", default_options)
  -- -- map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", default_options)
  -- -- map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>", default_options)
  -- -- map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", default_options)
  -- map("n", "<C-h>", "<CMD>NavigatorLeft<CR>", default_options)
  -- map("n", "<C-l>", "<CMD>NavigatorRight<CR>", default_options)
  -- map("n", "<C-k>", "<CMD>NavigatorUp<CR>", default_options)
  -- map("n", "<C-j>", "<CMD>NavigatorDown<CR>", default_options)
  -- map("n", "<C-p>", "<CMD>NavigatorPrevious<CR>", default_options)

  -- vim.navigator = navigator
end

return M
