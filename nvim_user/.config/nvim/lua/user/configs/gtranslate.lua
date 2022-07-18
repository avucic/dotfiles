local M = {}

function M.config()
  local gtranslate = require("user.core.utils").load_module("gtranslate")

  if gtranslate then
    gtranslate.setup({
      default_to_language = "English",
    })
  end
end

return M
