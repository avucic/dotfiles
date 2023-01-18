local M = {}

M.config = function()
  local dap_utils  = require("user.core.utils").load_module("dap.utils")

  if not dap_utils then
    return {}
  end

  local go = require("user.configs.dap.go")
  local ruby = require("user.configs.dap.ruby")
  -- local rust = require("user.configs.dap.rust")

  local adapters = {
    go = go.adapter(),
    ruby = ruby.adapter(),
    -- codelldb = rust.codelldb_adapter(),
    -- rt_lldb = rust.adapter(),
  }
  local configurations = {
    go = go.configurations(),
    ruby = ruby.configurations(),
    -- rust = rust.configurations(),
  }

  return {
    adapters = adapters,
    configurations = configurations,
    dapui = {},
  }
end

return M
