local M = {}

function M.config()
  local silicon = require("user.core.utils").load_module("silicon")
  if not silicon then
    return {}
  end

  silicon.setup()

  vim.api.nvim_create_user_command("Silicon", silicon.visualise_api, { desc = "Generate code image" })
end

return M
