local M = {}

M.config = function()
  local go = require("user.configs.dap.go")
  local ruby = require("user.configs.dap.ruby")

  local adapters = {
    go = go.adapter(),
    ruby = ruby.adapter(),
  }
  local configurations = {
    go = go.configurations(),
    ruby = ruby.configurations(),
  }

  return {
    adapters = adapters,
    configurations = configurations,
    dapui = {},
  }
end

return M
