local M = {}

function M.config()
  local windows = require("user.core.utils").load_module("windows")
  if not windows then
    return {}
  end

  windows.setup({
    ignore = { --        |windows.ignore|
      buftype = { "quickfix", "filetree" },
      filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "filetree" },
    },
  })
end

return M
