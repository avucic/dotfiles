local M = {}

M.config = function()
  local util = require("user.utils")

  if not util.modul_exists("dap") then
    return
  end

  local dap = util.load_module("dap")
  local dapui = util.load_module("dapui")

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
end

return M
