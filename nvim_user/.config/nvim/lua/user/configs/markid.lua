local M = {}

function M.setup() end

function M.config()
  require("nvim-treesitter.configs").setup({
    markid = { enable = true },
  })
end

return M
