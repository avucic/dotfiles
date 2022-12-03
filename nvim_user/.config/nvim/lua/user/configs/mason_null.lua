local M = {}

function M.config()
  local mason = require("user.core.utils").load_module("mason-null-ls")
  if not mason then
    return {}
  end
  return {
    ensure_installed = {},
  }
end

return M
