local M = {}

local extension_path = "~/.vscode/extensions/vadimcn.vscode-lldb-1.8.1"
local codelldb_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/adapter/codelldb"
-- local function adapter(callback, config)
--   local program = config.program
--     or function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
--     end
-- end

M.adapter = function()
  return {
    type = "server",
    port = "${port}",
    host = "127.0.0.1",
    executable = {
      command = codelldb_path,
      args = { "--liblldb", liblldb_path, "--port", "${port}" },
    },
  }
end

-- M.codelldb_adapter = function()
--   return function(callback, config)
--     callback({
--       type = "server",
--       port = "${port}",
--       executable = {
--         command = codelldb_path,
--         args = { "--port", "${port}" },
--       },
--     })
--   end
-- end

M.configurations = function()
  return {
    -- {
    --   name = "Rust debug",
    --   type = "rt_lldb",
    --   request = "launch",
    --   -- program = function()
    --   --   vim.fn.jobstart("cargo build")
    --   --   -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    --   --   return vim.fn.getcwd() .. "/target/debug/dropongo"
    --   -- end,
    --   cwd = "${workspaceFolder}",
    --   stopOnEntry = true,
    --   showDisassembly = "never",
    -- },
    {
                name = "Rust tools debug",
                type = "rt_lldb",
                request = "launch",
                program = json.executable,
                args = args.executableArgs or {},
                cwd = args.workspaceRoot,
                stopOnEntry = false,

                -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                --
                --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                --
                -- Otherwise you might get the following error:
                --
                --    Error on launch: Failed to attach to the target process
                --
                -- But you should be aware of the implications:
                -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                runInTerminal = false,
              }
  }
end

return M
