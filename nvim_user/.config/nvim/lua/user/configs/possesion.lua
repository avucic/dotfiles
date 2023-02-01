local M = {}

function M.setup() end

function M.config()
  local possession = require("user.core.utils").load_module("nvim-possession")
  if not possession then
    return {}
  end

  possession.setup({
    autoswitch = {
      enable = true, -- default false
    },
  })
end

return M
