local M = {}
function M.config()
  local wp = require("user.core.utils").load_module("window-picker")

  wp.setup({
    autoselect_one = true,
    include_current = false,
    other_win_hl_color = "#e35e4f",
  })
end
return M
