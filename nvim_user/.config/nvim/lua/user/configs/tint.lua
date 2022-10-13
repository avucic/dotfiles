local M = {}

function M.config()
  local tint = require("user.core.utils").load_module("tint")

  if not tint then
    return {}
  end

  tint.setup()
  -- tint.refresh()
end

return M
