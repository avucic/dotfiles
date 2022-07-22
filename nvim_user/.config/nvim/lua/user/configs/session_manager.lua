local M = {}

function M.config()
  return {
    autosave_last_session = true,
    autosave_ignore_filetypes = {
      "toggleterm",
    },
  }
end

return M
