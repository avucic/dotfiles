local M = {}

function M.setup()
  -- vim.o.winwidth = 10
  -- vim.o.winminwidth = 5
  -- vim.o.equalalways = false
end

function M.config()
  vim.o.winminwidth = 5
  vim.o.equalalways = true
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
