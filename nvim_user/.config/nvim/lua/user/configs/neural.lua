local M = {}

function M.config()
  local neural = require("user.core.utils").load_module("neural")

  if not neural then
    return {}
  end

  neural.setup({
    open_ai = {
      api_key = vim.env.OPENAI_API_KEY,
    },
    mappings = {
      swift = "<C-i>", -- Context completion
      prompt = "<c-CR>", -- Open prompt
    },
    ui = {
      icon = "",
    },
  })
end

return M
