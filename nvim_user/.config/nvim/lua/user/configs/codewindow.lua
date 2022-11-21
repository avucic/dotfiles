local M = {}

function M.setup() end

function M.config()
  local codewindow = require("user.core.utils").load_module("codewindow")
  if not codewindow then
    return {}
  end

  codewindow.setup({
    exclude_filetypes = {
      "neo-tree",
    },
  })

  vim.api.nvim_create_user_command("ToggleMiniMap", codewindow.toggle_minimap, { desc = "Toggle Minimap" })
end

return M
