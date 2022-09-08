local M = {}

function M.config()
  local notes = require("user.core.utils").load_module("neo-tree")

  if not notes then
    return {}
  end

  notes.setup({})
end

return M
