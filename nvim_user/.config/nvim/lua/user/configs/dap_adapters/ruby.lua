local M = {}

M.adapter = function(callback, config)
  local handle
  local stdout = vim.loop.new_pipe(false)
  local pid_or_err
  local waiting = config.waiting or 500
  local port = config.port or config.debugPort or 38698
  local host = config.host or config.server or "127.0.0.1"
  local args

  if config.bundle == "bundle" then
    args = {
      "--open",
      "--port",
      port,
      "-c",
      "--",
      "bundle",
      "exec",
      config.command,
      config.script,
    }
  else
    args = { "--open", "--port", port, "-c", "--", config.command, config.script }
  end

  local opts = {
    stdio = { nil, stdout },
    args = args,
    detached = false,
  }

  if config.env then
    opts.env = require("user.core.utils").env_merge(config.env)
  end

  handle, pid_or_err = vim.loop.spawn("rdbg", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("rdbg exited with code", code)
    end
  end)

  assert(handle, "Error running rgdb: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)

  -- Wait for rdbg to start
  vim.defer_fn(function()
    callback({ type = "server", host = host, port = port })
  end, waiting)
end

return M
