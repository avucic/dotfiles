local M = {}

function M.setup() end

function M.config()
  require("nvim-treesitter.configs").setup({
    markid = { enable = true },
  })

  local tint = require("user.core.utils").load_module("tint")
  if tint then
    tint.refresh()
  end
end

return M
