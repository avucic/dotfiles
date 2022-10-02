local M = {}

function M.config()
  local focus = require("user.core.utils").load_module("focus")

  if not focus then
    return {}
  end

  focus.setup({
    excluded_filetypes = {
      "toggleterm",
      -- "term",
      "terminal",
      -- "neo-tree",
      -- "Neotree",
      "TelescopePrompt",
      -- "harpoon",
      -- "minimap",
      "fterm",
      "term",
    },
    excluded_buftypes = {
      "help",
      -- "vifm",
      -- "nofile",
      -- "prompt",
      -- "popup",
      -- "VsplitVifm",
      -- "toggleterm",
      -- "terminal",
      -- "term",
      "prompt",
      "popup",
      "TelescopePrompt",
      "terminal",
    },
    compatible_filetrees = { "neo-tree" },
    treewidth = 40,
    bufnew = false,
    cursorline = true,
    autoresize = true,
    number = false,
    signcolumn = false,
  })
end

return M
