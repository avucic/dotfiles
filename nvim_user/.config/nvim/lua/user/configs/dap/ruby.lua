local M = {}

M.configurations = function()
  return {
    {
      type = "ruby",
      name = "Attach with rdbg",
      request = "attach",
      localfs = true,
    },
    {
      type = "ruby",
      name = "Debug current file",
      request = "launch",
      localfs = true,
      command = "ruby",
      script = "${file}",
    },
    {
      type = "ruby",
      name = "Run spec current file",
      request = "launch",
      localfs = true,
      command = "rspec",
      script = "${file}",
    },
    {
      type = "ruby",
      name = "Run current spec",
      request = "launch",
      localfs = true,
      command = "rspec",
      script = "${file}",
      current_line = true,
    },
  }
end

M.adapter = function()
  return function(callback, config)
    if config.request == "attach" then
      callback({
        type = "server",
        port = "12345",
      })
    else
      local script
      if config.current_line then
        script = config.script .. ":" .. vim.fn.line(".")
      else
        script = config.script
      end
      callback({
        type = "server",
        port = "${port}",
        executable = {
          command = "bundle",
          args = {
            "exec",
            "rdbg",
            "--stop-at-load",
            "--open",
            "--host",
            "127.0.0.1",
            "--port",
            "${port}",
            "--command",
            "--",
            "bundle",
            "exec",
            config.command,
            script,
          },
        },
      })
    end
  end
end

return M
