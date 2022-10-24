local M = {}

function M.config()
  local settings = {
    open_mapping = [[<c-\>]],
    persist_size = true,
    shade_terminals = true,
    shading_factor = -8,
    highlights = {
      -- highlights which map to a highlight group name and a table of it's values
      -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
      Normal = {
        guibg = "#ff6600",
      },
      NormalFloat = {
        link = "Normal",
      },
      -- FloatBorder = {
      --   guifg = "<VALUE-HERE>",
      --   guibg = "<VALUE-HERE>",
      -- },
    },
  }

  return settings
end

return M
