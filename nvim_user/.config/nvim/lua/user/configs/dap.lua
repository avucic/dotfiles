local M = {}

M.config = function()
  -- local util = require("user.core.utils")
  --
  -- local dap = util.load_module("dap")
  -- if not dap then
  --   return
  -- end

  -- local dapui = util.load_module("dapui")
  -- if not dapui then
  --   return
  -- end
  --
  -- dap.listeners.after.event_initialized["dapui_config"] = function()
  --   dapui.open()
  --   dap.repl.close()
  -- end
  -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --   dapui.close()
  --   dap.repl.close()
  -- end
  -- dap.listeners.before.event_exited["dapui_config"] = function()
  --   dapui.close()
  --   dap.repl.close()
  -- end
  --
  -- dapui.setup()
  --
  local ruby_adapter = require("user.configs.dap_adapters.ruby").adapter
  local go_adapter = require("user.configs.dap_adapters.go").adapter
  local rust_adapter_config = require("user.configs.dap_adapters.rust").config

  return {
    adapters = {
      ruby = ruby_adapter,
      go = go_adapter,
      codelldb = rust_adapter_config,
    },
    configurations = {},
    dapui = {},
  }
end

return M
