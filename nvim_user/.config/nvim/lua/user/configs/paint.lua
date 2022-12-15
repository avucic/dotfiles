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
        filter = function()
          return true
        end,
        pattern = "TODO:",
        hl = "@text.note",
      },

      {
        filter = function()
          return true
        end,
        pattern = "NOTE:",
        hl = "@text.note",
      },
    },
  })
end

return M
