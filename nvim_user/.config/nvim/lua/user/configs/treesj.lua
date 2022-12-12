local M = {}

function M.config()
  local treesj = require("user.core.utils").load_module("treesj")
  if not treesj then
    return {}
  end

  treesj.setup({
    use_default_keymaps = false,
  })
end

return M
