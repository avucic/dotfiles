local M = {}

function M.setup() end

function M.config()
  local leap = require("user.core.utils").load_module("leap")
  if not leap then
    return {}
  end

  -- leap.add_default_mappings()
end

return M
