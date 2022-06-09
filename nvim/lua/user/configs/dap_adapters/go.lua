local M = {}

local util = require("user.utils")
-- local job = util.load_module("plenary.job")
-- local uv = vim.loop

function M.config()
  return function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local host = config.host or "127.0.0.1"
    local port = config.port or "38697"
    local addr = string.format("%s:%s", host, port)
    local env = {
      CGO_ENABLED = 0,
    }
    local opts = {
      stdio = { nil, stdout },
      args = { "-arch", "arm64", "dlv", "dap", "-l", addr },
      detached = true,
    }

    if config.env then
      for k, v in pairs(config.env) do
        env[k] = v
      end
      opts.env = require("user.utils").env_merge(env)
    end

    handle, pid_or_err = vim.loop.spawn("arch", opts, function(code)
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
    end, 100)
  end
end

return M
