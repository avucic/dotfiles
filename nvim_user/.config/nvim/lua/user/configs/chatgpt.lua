local M = {}

function M.config()
  local chatgpt = require("user.core.utils").load_module("chatgpt")
  if not chatgpt then
    return {}
  end

  chatgpt.setup({
    yank_register = [[*]],
    keymaps = {
      close = { "<C-q>" },
      yank_last = "<C-y>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      toggle_settings = "<C-o>",
      cycle_windows = "<Tab>",
    },
  })
end

return M
