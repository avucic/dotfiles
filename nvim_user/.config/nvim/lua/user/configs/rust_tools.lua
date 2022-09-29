local M = {}

function M.config()
  local rt = require("user.core.utils").load_module("rust-tools")
  if not rt then
    return {}
  end

  rt.setup()
end

return M
