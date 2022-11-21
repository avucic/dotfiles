local M = {}

function M.setup() end

function M.config()
  local telescope_tabs = require("user.core.utils").load_module("telescope-tabs")
  if not telescope_tabs then
    return {}
  end

  telescope_tabs.setup()
end

return M
