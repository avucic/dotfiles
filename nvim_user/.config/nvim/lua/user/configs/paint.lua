local M = {}

function M.setup() end

function M.config()
  local paint = require("user.core.utils").load_module("paint")
  if not paint then
    return {}
  end

  paint.setup({
    highlights = {
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*(@%w+)",
        hl = "Constant",
      },
      {
        filter = { filetype = "lua" },
        pattern = "TODO:",
        hl = "@constant",
      },
    },
  })
end

return M
