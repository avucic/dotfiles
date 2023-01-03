local M = {}
local function get_arguments()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = "Args: " }, function(input)
        args = vim.split(input or "", " ")
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = "Args: " }, function(input)
      args = vim.split(input or "", " ")
    end)
    return args
  end
end

M.configurations = function()
  return {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug (Arguments)",
      request = "launch",
      program = "${file}",
      args = get_arguments,
    },
    {
      type = "go",
      name = "Debug Package",
      request = "launch",
      program = "${fileDirname}",
    },
    {
      type = "go",
      name = "Attach",
      mode = "local",
      request = "attach",
      processId = require("dap.utils").pick_process,
    },
    {
      type = "go",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }
end

M.adapter = function()
  local port = "${port}"
  return {
    type = "server",
    port = port,
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:" .. port },
    },
    options = {
      initialize_timeout_sec = 20,
    },
  }
end

return M
