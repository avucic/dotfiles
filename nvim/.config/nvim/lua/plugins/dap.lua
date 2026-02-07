local function vscode_launch_config_exists()
  local cwd = vim.fn.getcwd()
  local filepath = cwd .. "/.vscode/launch.json"
  return vim.fn.filereadable(filepath) == 1
end

local function get_remote_root()
  -- Check for a buffer-local variable (e.g., set in a project's .nvim.lua file)
  if vim.b.dap_remote_root ~= nil then return vim.b.dap_remote_root end
  -- Check for a global variable
  if vim.g.dap_remote_root ~= nil then return vim.g.dap_remote_root end
  -- Default remote root
  return "/app"
end

local function get_container_name()
  -- Check for a buffer-local variable
  if vim.b.dap_container_name ~= nil then return vim.b.dap_container_name end
  -- Check for a global variable
  if vim.g.dap_container_name ~= nil then return vim.g.dap_container_name end

  vim.notify("Dap container is missing", "error")
end

return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  keys = {
    { "<leader>dl", function() require("dap").run_last() end, desc = "Last task" },
  },
  opts = {
    ensure_installed = { "js", "node2" }, -- Automatically install the adapter
  },
  config = function()
    local dap = require "dap"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "::1",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = {
          "${port}",
        },
      },
    }

    if not vscode_launch_config_exists() then
      local workspace_folder = vim.fn.getcwd()
      local remote_root = get_remote_root()
      local container_name = get_container_name()

      -- Lua DAP configuration for attaching to Docker Node
      local current_line = tostring(vim.fn.line ".")
      for _, adapter in pairs { "pwa-node", "pwa-chrome" } do
        require("dap").adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
          },
        }
      end
      for _, language in ipairs { "typescript", "typescriptreact", "javascript", "svelte" } do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Docker Node",
            address = "localhost",
            port = 9229,
            localRoot = vim.fn.getcwd(), -- or specify path
            remoteRoot = "/app",
            protocol = "inspector",
            restart = true,
            skipFiles = {
              "<node_internals>/**",
            },
          },

          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Chrome (React @ 4000)",
            port = 9222,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            url = "http://localhost:4000",
          },
          -- {
          --   type = "pwa-chrome",
          --   request = "launch",
          --   name = "Launch Chrome (React)",
          --
          --   url = "http://localhost:4000",
          --   webRoot = "${workspaceFolder}",
          --   sourceMaps = true,
          --
          --   -- 🔴 ABSOLUTELY REQUIRED on macOS
          --   userDataDir = vim.fn.stdpath "data" .. "/chrome-debug",
          --
          --   -- 🔴 Do NOT reuse existing Chrome
          --   runtimeArgs = {
          --     "--no-first-run",
          --     "--no-default-browser-check",
          --     "--disable-extensions",
          --   },
          -- },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest - file (Generic)",
            runtimeExecutable = "npx",
            runtimeArgs = function()
              return {
                "vitest",
                "run",
                "--no-cache",
                "--inspect-brk=9229",
                "--no-file-parallelism",
                "${relativeFile}",
              }
            end,
            port = 9229,
            cwd = workspace_folder,
            localRoot = workspace_folder,
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            skipFiles = {
              "<node_internals>/**",
              "**/node_modules/**",
            },
            resolveSourceMapLocations = {
              workspace_folder .. "/**/*.ts",
              workspace_folder .. "/**/*.js",
            },
            trace = true,
            smartStep = true,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest - current spec (Generic)",
            runtimeExecutable = "npx",
            runtimeArgs = function()
              return {
                "vitest",
                "run",
                "--no-cache",
                "--inspect-brk=9229",
                "--no-file-parallelism",
                "${relativeFile}:" .. current_line,
              }
            end,
            port = 9229,
            cwd = workspace_folder,
            localRoot = workspace_folder,
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            skipFiles = {
              "<node_internals>/**",
              "**/node_modules/**",
            },
            resolveSourceMapLocations = {
              workspace_folder .. "/**/*.ts",
              workspace_folder .. "/**/*.js",
            },
            trace = true,
            smartStep = true,
          },

          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest - current spec name (Generic)",
            runtimeExecutable = "npx",
            runtimeArgs = function()
              local test_name = vim.fn.input "Test name: "
              return {
                "vitest",
                "run",
                "--no-cache",
                "--inspect-brk=9229",
                "--no-file-parallelism",
                "-t",
                test_name,
                "${relativeFile}",
              }
            end,
            port = 9229,
            cwd = workspace_folder,
            localRoot = workspace_folder,
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            skipFiles = {
              "<node_internals>/**",
              "**/node_modules/**",
            },
            resolveSourceMapLocations = {
              workspace_folder .. "/**/*.ts",
              workspace_folder .. "/**/*.js",
            },
            trace = true,
            smartStep = true,
          },
        }
      end
    end
  end,
}
