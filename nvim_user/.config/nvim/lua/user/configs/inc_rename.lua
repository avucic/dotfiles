local M = {}

function M.config()
  local inc_rename = require("user.core.utils").load_module("inc_rename")
  if not inc_rename then
    return {}
  end

  inc_rename.setup({
    preview_empty_name = true,
  })
end

return M
