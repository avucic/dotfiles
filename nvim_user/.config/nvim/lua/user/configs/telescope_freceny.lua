local M = {}

function M.config()
  local _sqlite = require("user.utils").load_module("sqlite.lua")

  require("telescope").load_extension("frecency")
end

return M
