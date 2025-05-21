--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
local function get_pkg_path(pkg, path)
  pcall(require, "mason")
  local root = vim.env.MASON or (vim.fn.stdpath "data" .. "/mason")
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  return ret
end

return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  opts = {
    ensure_installed = { "js", "node2" }, -- Automatically install the adapter
  },
  config = function()
    local dap = require "dap"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
          "${port}",
        },
      },
    }

    for _, language in ipairs { "typescript", "typescriptreact", "javascript", "svelte" } do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Current Test File",
          autoAttachChildProcesses = true,
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          runtimeExecutable = "node",
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          args = { "run", "${relativeFile}" },
          smartStep = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Current Test by name",
          autoAttachChildProcesses = true,
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          runtimeExecutable = "node",
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          args = function() return { "run", "${relativeFile}", "-t", vim.fn.input "Name: " } end,
          -- args = {
          --   "-t", -- Jest flag for test name pattern
          --   "PUT YOUR TEST NAME PATTERN HERE", -- Replace with the actual test name or pattern
          --   "${file}", -- Optional: run tests only in the current file
          --   "--runInBand", -- Recommended for debugging
          -- },
          smartStep = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },

        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
        },
      }
    end
  end,
}
