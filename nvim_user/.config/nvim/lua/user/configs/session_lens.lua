local M = {}

function M.config()
  local sessionLens = require("user.core.utils").load_module("session-lens")
  if not sessionLens then
    return {}
  end

  sessionLens.setup({--[[your custom config--]]
  })

  -- require("telescope").load_extension("session-lens")
end

return M
