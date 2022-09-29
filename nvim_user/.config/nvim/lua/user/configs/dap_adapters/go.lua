local M = {}

local util = require("user.core.utils")
-- local job = util.load_module("plenary.job")
-- local uv = vim.loop

local function adapter(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local host = config.host or "127.0.0.1"
  local port = config.port or "38697"
  local addr = string.format("%s:%s", host, port)
  local use_arch = config.useArch or false
  local attach = config.request == "attach"
  local env = {
    CGO_ENABLED = 0,
  }

  if attach == true then
    callback({
      type = "server",
      host = host,
      port = port,
      mode = "remote",
    })
    return
  end

  local opts = {
    stdio = { nil, stdout },
    args = {},
    detached = true,
  }
  if use_arch == true then
    opts.args = { "-arch", "arm64", "dlv" }
  end

  table.insert(opts.args, "dap")
  table.insert(opts.args, "-l")
  table.insert(opts.args, addr)

  if config.env then
    for k, v in pairs(config.env) do
      env[k] = v
    end
    opts.env = require("user.core.utils").env_merge(env)
  end

  local spawn_command

  if use_arch == true then
    spawn_command = "arch"
  else
    spawn_command = "dlv"
  end

  handle, pid_or_err = vim.loop.spawn(spawn_command, opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)

  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    callback({ type = "server", host = "127.0.0.1", port = port })
  end, 3000)
end

function M.setup(dap)
  dap.adapters.go = adapter
end

return M
