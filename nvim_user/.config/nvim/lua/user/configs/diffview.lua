local M = {}

function M.config()
  local diffview = require("user.utils").load_module("diffview")

  diffview.setup({
    keymaps = {
      file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
      file_panel = { q = "<Cmd>DiffviewClose<CR>" },
      view = { q = "<Cmd>DiffviewClose<CR>" },
    },
  })
end

return M
