return function(_, opts)
  -- TODO: once mason introduce ruby debugger remove this
  local dap = require("dap")

  require("dap.ext.vscode").load_launchjs()

  dap.adapters.ruby = function(callback, config)
    local port = config.debuggerPort or os.getenv("RUBY_DEBUG_PORT") or "12345"
    local host = config.debuggeHost or "127.0.0.1"

    dap.set_log_level("TRACE")
    print("DAP: Launching debugger with", port, host, vim.inspect(config.executable))
    callback({
      type = "server",
      port = port,
      host = host,
      enrich_config = function(config, on_config)
        local final_config = vim.deepcopy(config)
        local current_line = vim.fn.line(".")
        local script = final_config.script and final_config.script:gsub("${currentLine}", current_line)
        local executable = config.executable

        final_config.script = script

        if executable then
          for i, v in pairs(executable.args) do
            v = v:gsub("${currentLine}", current_line)
            executable.args[i] = v
          end
          final_config.executable = executable
        end

        print("DAP: Enriched config", vim.inspect(final_config))
        on_config(final_config)
      end,
      command = config.command,
      script = config.script,
      executable = config.executable,
    })
  end
end
