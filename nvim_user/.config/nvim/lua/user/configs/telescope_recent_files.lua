local M = {}

function M.setup() end

function M.config()
  local telescope = require("user.core.utils").load_module("telescope")
  if not telescope then
    return {}
  end

  telescope.load_extension("recent_files")
end

return M
