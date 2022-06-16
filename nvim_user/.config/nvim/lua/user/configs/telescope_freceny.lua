local M = {}

function M.config()
  local telescope = require("user.utils").load_module("telescope")
  if not telescope then
    return
  end

  telescope.load_extension("frecency")

end

return M
