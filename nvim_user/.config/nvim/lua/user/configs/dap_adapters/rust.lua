local M = {}

-- local function adapter(callback, config)
--   local program = config.program
--     or function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
--     end
-- end

function M.config()
  return {
    type = "server",
    port = "${port}",
    executable = {
      command = "/Users/vucinjo/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/adapter/codelldb",
      args = { "--port", "${port}" },
    },
  }

  -- dap.configurations.rust = {
  --   {
  --     name = "Rust debug",
  --     type = "codelldb",
  --     request = "launch",
  --     program = function()
  --       vim.fn.jobstart("cargo build")
  --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
  --     end,
  --     cwd = "${workspaceFolder}",
  --     stopOnEntry = true,
  --     showDisassembly = "never",
  --   },
  -- }
end

return M
