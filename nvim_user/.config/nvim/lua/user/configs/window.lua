local M = {}

function M.config()
  local window = require("user.core.utils").load_module("nvim-window")
  if not window then
    return {}
  end

  window.setup({
    -- A group to use for overwriting the Normal highlight group in the floating
    -- window. This can be used to change the background color.
    normal_hl = "@constant",

    -- The border style to use for the floating window.
    border = "single",
  })
end

return M
