local M = {}

function M.setup() end

function M.config()
  local legendary = require("user.core.utils").load_module("legendary")
  if not legendary then
    return {}
  end

  legendary.setup({ include_builtin = true, auto_register_which_key = true })
end

return M
