-- return function(_, opts)
--   -- TODO: once mason introduce ruby debugger remove this
--   local dap = require("dap")
--   local port = os.getenv("RUBY_DEBUG_PORT") or "12345"
--   dap.adapters.ruby = function(callback, config)
--     local script
--     if config.current_line then
--       script = config.script .. ":" .. vim.fn.line(".")
--     else
--       script = config.script
--     end
--
--     local env_variables = {}
--     for k, v in pairs(config.env or {}) do
--       table.insert(env_variables, string.format("%s=%s", k, v))
--     end
--
--     callback({
--       type = "server",
--       host = "127.0.0.1",
--       port = port,
--       executable = {
--         command = "bundle",
--         env = env_variables,
--         args = {
--           "exec",
--           "rdbg",
--           "-n",
--           "--open",
--           "--port",
--           port,
--           "-c",
--           "--",
--           "bundle",
--           "exec",
--           config.command,
--           script,
--         },
--       },
--     })
--   end
--
--   dap.configurations.ruby = {
--     {
--       type = "ruby",
--       name = "debug current file",
--       request = "attach",
--       localfs = true,
--       command = "ruby",
--       script = "${file}",
--     },
--     {
--       type = "ruby",
--       name = "Attach with rdbg",
--       request = "attach",
--       localfs = true,
--     },
--     {
--       type = "ruby",
--       name = "Run current spec",
--       request = "attach",
--       localfs = true,
--       command = "rspec",
--       script = "${file}",
--       current_line = true,
--     },
--
--     {
--       type = "ruby",
--       name = "Run current spec with GUI (Capybara)",
--       request = "attach",
--       localfs = true,
--       command = "rspec",
--       script = "${file}",
--       current_line = true,
--       env = {
--         TEST_RUN_HEADLESS = false,
--       },
--     },
--   }
-- end

return function(_, opts)
  -- TODO: once mason introduce ruby debugger remove this
  local dap = require("dap")

  require("dap.ext.vscode").load_launchjs()

  dap.adapters.ruby = function(callback, config)
    local handle
    local port = os.getenv("RUBY_DEBUG_PORT") or "12345"
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)

    local pid_or_err
    local waiting = config.waiting or 500
    local host = config.server or "127.0.0.1"
    local args
    local script
    local cmd

    if config.current_line then
      script = config.script .. ":" .. vim.fn.line(".")
    else
      script = config.script
    end

    cmd = config.bundle or "rdbg"

    if config.bundle then
      args = { "exec", "rdbg", "-n", "--open", "--port", port, "-c", "--", "bundle", "exec", config.command, script }
    else
      args = { "--open", "--port", port, "-c", "--", config.command, script }
    end

    local env_variables = {}
    for k, v in pairs(config.env or {}) do
      table.insert(env_variables, string.format("%s=%s", k, v))
    end

    local opts = {
      stdio = { nil, stdout, stderr },
      args = args,
      env = env_variables,
      detached = false,
    }

    handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
      handle:close()
      stderr:close()
      stdout:close()
      if code ~= 0 then
        assert(handle, "rdbg exited with code: " .. tostring(code))
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

    stderr:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        print(chunk)
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

  -- dap.configurations.ruby = {
  --   {
  --     type = "ruby",
  --     name = "Run current spec",
  --     request = "attach",
  --     localfs = true,
  --     bundle = "/Users/vucinjo/.asdf/shims/bundle",
  --     command = "rspec",
  --     script = "${file}",
  --     current_line = true,
  --   },
  --   {
  --     type = "ruby",
  --     name = "Run current spec with GUI (Capybara)",
  --     request = "attach",
  --     localfs = true,
  --     bundle = "/Users/vucinjo/.asdf/shims/bundle",
  --     command = "rspec",
  --     script = "${file}",
  --     current_line = true,
  --     env = {
  --       TEST_RUN_HEADLESS = "false",
  --     },
  --   },
  --   {
  --     type = "ruby",
  --     name = "debug current file",
  --     request = "attach",
  --     localfs = true,
  --     command = "ruby",
  --     script = "${file}",
  --   },
  --   {
  --     type = "ruby",
  --     name = "Attach with rdbg",
  --     bundle = "/Users/vucinjo/.asdf/shims/bundle",
  --     request = "attach",
  --     localfs = true,
  --   },
  -- }
end
