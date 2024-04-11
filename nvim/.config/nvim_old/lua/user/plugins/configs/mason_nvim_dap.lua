local Job = require("plenary.job")
local dap = require("dap")

return function(c, opts)
  require("dap.ext.vscode").load_launchjs()

  dap.adapters.ruby = function(callback, config)
    local port = config.debugPort or os.getenv("RUBY_DEBUG_PORT") or "12345"
    local host = config.debugHost or "127.0.0.1"
    local current_line = vim.fn.line(".")
    local script = config.script and config.script:gsub("${currentLine}", current_line)
    local executable = config.executable

    if config.request == "launch" then
      local command = executable and executable.command or "rdbg"
      local args = executable and executable.args or {}

      for i, v in pairs(executable.args) do
        v = v:gsub("${currentLine}", current_line)
        executable.args[i] = v
      end

      Job:new({
        command = command,
        detached = true,
        args = args,
        on_stdout = function(j, return_val)
          print("DEBUGGER stdout", return_val)
        end,

        on_stderr = function(j, return_val)
          print("DEBUGGER stderr", return_val)
        end,
      }):sync() -- or start()

      print("RUBY DEBUGGER", vim.inspect(opts), vim.inspect(executable))

      vim.defer_fn(function()
        callback({ type = "server", host = host, port = port })
      end, 100)
    else
      print("RUBY DEBUGGER", port, host)
      callback({ type = "server", host = host, port = port })
    end
  end
  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  -- local dap = require("dap")
  -- local mason_registry = require("mason-registry")
  -- local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
  -- local codelldb_path = codelldb_root .. "adapter/codelldb"
  -- local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
  -- dap.adapters.rust = {
  --   type = "server",
  --   port = "${port}",
  --   host = "127.0.0.1",
  --   executable = {
  --     command = codelldb_path,
  --     args = { "--liblldb", liblldb_path, "--port", "${port}" },
  --   },
  -- }
  -- dap.adapters.rust = {
  --   type = "executable",
  --   command = "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib", -- adjust as needed, must be absolute path
  --   name = "lldb",
  -- }
end
