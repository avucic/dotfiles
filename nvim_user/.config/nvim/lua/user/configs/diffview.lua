local M = {}

function M.config()
  local diffview = require("user.core.utils").load_module("diffview")
  -- local actions = require("user.core.utils").load_module("diffview.actions")
  local actions = require("diffview.actions")

  diffview.setup({
    keymaps = {
      file_history_panel = {
        q = "<Cmd>DiffviewClose<CR>",
      },
      file_panel = {
        q = "<Cmd>DiffviewClose<CR>",
        ["d"] = actions.restore_entry,
      },
      view = {
        q = "<Cmd>DiffviewClose<CR>",
      },
    },
  })
end

return M
