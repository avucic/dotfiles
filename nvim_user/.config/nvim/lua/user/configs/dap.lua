local M = {}

M.setup = function()
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

  require("user.configs.dap_adapters.ruby").setup(dap)
  require("user.configs.dap_adapters.go").setup(dap)
  require("user.configs.dap_adapters.rust").setup(dap)
end

return M
