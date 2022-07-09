local M = {}

function M.config()
  local vstask = require("user.core.utils").load_module("vstask")
  if vstask then
    vstask.setup({
      terminal = "toggleterm",
    })
  end
end

return M
