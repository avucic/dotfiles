local M = {}

function M.config()
  require("tint").setup()

  local tint = require("user.core.utils").load_module("tint")

  if not tint then
    return {}
  end

  tint.setup()
end

return M
