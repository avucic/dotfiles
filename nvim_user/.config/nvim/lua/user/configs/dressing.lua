local M = {}

function M.config()
  return {
    input = {
      prompt_align = "center",
      relative = "win", -- or 'editor'
    },
  }
end

return M
