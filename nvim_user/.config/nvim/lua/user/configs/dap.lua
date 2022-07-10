local M = {}

M.config = function()
  local util = require("user.core.utils")

  local dap = util.load_module("dap")
  if not dap then
    return
  end

  local dapui = util.load_module("dapui")
  if not dapui then
    return
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    dap.repl.close()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end

  dapui.setup()

  dap.adapters.ruby = require("user.configs.dap_adapters.ruby").config()
  dap.adapters.go = require("user.configs.dap_adapters.go").config()
  -- dap.adapters.go = { type = "server", host = "127.0.0.1", port = 38697 }
end

return M
