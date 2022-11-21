local M = {}

function M.config()
  local windows = require("user.core.utils").load_module("windows")
  if not windows then
    return {}
  end

  windows.setup()
end

return M
