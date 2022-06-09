local M = {}

function M.config()
  local focus = require("user.utils").load_module("focus")

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
      "TelescopePrompt",
      "terminal",
    },
    compatible_filetrees = { "neo-tree" },
    minwidth = 20,
    -- width = 175,
    treewidth = 40,
    bufnew = false,
    cursorline = true,
    autoresize = true,
    number = false,
    signcolumn = false,
  })
end

return M
