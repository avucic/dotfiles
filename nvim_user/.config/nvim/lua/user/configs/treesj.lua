local M = {}

function M.config()
  local treesj = require("user.core.utils").load_module("treesj")
  if not treesj then
    return {}
  end

  treesj.setup({
    use_default_keymaps = false,
    max_join_length = 200,
  })
end

return M
