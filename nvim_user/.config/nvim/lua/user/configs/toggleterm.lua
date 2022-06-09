local M = {}

function M.config()
  local settings = {
    open_mapping = [[<c-t>]],
    persist_size = true,
    shade_terminals = true,
    shading_factor = -8,
  }

  return settings
end

return M
