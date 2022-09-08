local M = {}

function M.config()
  local colortils = require("user.core.utils").load_module("colortils")

  if not colortils then
    return {}
  end

  colortils.setup()
end

return M
