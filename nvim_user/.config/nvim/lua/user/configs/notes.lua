local M = {}

function M.config()
  local notes = require("user.core.utils").load_module("neo-tree")

  notes.setup({})
end

return M
