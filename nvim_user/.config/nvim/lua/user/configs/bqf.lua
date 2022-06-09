local M = {}
function M.config()
  local bqf = require("user.utils").load_module("bqf")

  bqf.setup({
    func_map = {
      prevfile = "<c-p>",
      nextfile = "<c-n>",
    },
  })
end

return M
