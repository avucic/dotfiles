local M = {}

function M.config()
  local telescope = require("user.core.utils").load_module("telescope")
  -- local _vim_bookmarks = require("user.core.utils").load_module("vim_bookmarks")

  telescope.load_extension("vim_bookmarks")
end

return M
