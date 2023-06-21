return function(_, opts)
  -- TODO: once mason introduce ruby debugger remove this
  local dap = require("dap")
  local port = os.getenv("RUBY_DEBUG_PORT") or "12345"
  dap.adapters.ruby = function(callback, config)
    local script
    if config.current_line then
      script = config.script .. ":" .. vim.fn.line(".")
    else
      script = config.script
    end
    callback({
      type = "server",
      host = "127.0.0.1",
      port = port,
      executable = {
        command = "bundle",
        args = {
          "exec",
          "rdbg",
          "-n",
          "--open",
          "--port",
          port,
          "-c",
          "--",
          "bundle",
          "exec",
          config.command,
          script,
        },
      },
    })
  end

  dap.configurations.ruby = {
    {
      type = "ruby",
      name = "debug current file",
      request = "attach",
      localfs = true,
      command = "ruby",
      script = "${file}",
    },
    {
      type = "ruby",
      name = "Attach with rdbg",
      request = "attach",
      localfs = true,
    },
    {
      type = "ruby",
      name = "Run current spec",
      request = "attach",
      localfs = true,
      command = "rspec",
      script = "${file}",
      current_line = true,
    },
  }
end
