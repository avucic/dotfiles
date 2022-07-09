local M = {}

function M.config()
  require("user.core.utils").load_module("lualine")

  local function get_hl_by_name(name)
    return string.format("#%06x", vim.api.nvim_get_hl_by_name(name.group, true)[name.prop])
  end

  local function get_hl_prop(group, prop, default)
    local status_ok, color = pcall(get_hl_by_name, { group = group, prop = prop })
    if status_ok then
      default = color
    end
    return default
  end

  local config = {
    sections = {
      lualine_a = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          color = { bg = "NONE", fg = get_hl_prop("GitSignsAdd", "foreground", "#98c379") },
        },
      },
    },
  }

  return config
end

return M
