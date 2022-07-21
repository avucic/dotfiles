local M = {}

function M.config()
  vim.g.scratch_filetype = "markdown"
  vim.g.scratch_persistence_file = "~/.cache/nvim/scratch"
end

return M
