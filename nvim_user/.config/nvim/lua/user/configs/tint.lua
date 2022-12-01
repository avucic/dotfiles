local M = {}

function M.config()
  local tint = require("user.core.utils").load_module("tint")

  if not tint then
    return {}
  end

  tint.setup({
    -- highlight_ignore_patterns = { "Telescope*", "filetree" },
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)
      local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
      local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

      -- Do not tint `terminal` or floating windows, tint everything else
      return floating or buftype == "terminal" or buftype == "nofile" or buftype == "prompt"
    end,
  })
  -- tint.refresh()
end

return M
