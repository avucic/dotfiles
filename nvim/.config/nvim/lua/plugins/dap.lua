local function vscode_launch_config_exists()
  local cwd = vim.fn.getcwd()
  local filepath = cwd .. "/.vscode/launch.json"
  return vim.fn.filereadable(filepath) == 1
end

local function find_package_json_root()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(file, ":p:h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/package.json") == 1 then return dir end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return vim.fn.getcwd() -- fallback
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
      -- local remote_root = get_remote_root()
      -- local container_name = get_container_name()

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
          {
            -- use nvim-dap-vscode-js's pwa-chrome debug adapter
            type = "pwa-chrome",
            request = "launch",
            -- name of the debug action
            name = "Launch Chrome to debug client side code",
            -- default vite dev server url
            url = "http://localhost:4000",
            -- for TypeScript/Svelte
            sourceMaps = true,
            webRoot = find_package_json_root() .. "/src",
            protocol = "inspector",
            port = 9222,
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },

          -- {
          --   -- use nvim-dap-vscode-js's pwa-node debug adapter
          --   type = "pwa-node",
          --   -- attach to an already running node process with --inspect flag
          --   -- default port: 9222
          --   request = "attach",
          --   -- allows us to pick the process using a picker
          --   processId = require("dap.utils").pick_process,
          --   -- name of the debug action
          --   name = "Attach debugger to existing `node --inspect` process",
          --   -- for compiled languages like TypeScript or Svelte.js
          --   sourceMaps = true,
          --   -- resolve source maps in nested locations while ignoring node_modules
          --   resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          --   -- path to src in vite based projects (and most other projects as well)
          --   cwd = "${workspaceFolder}/src",
          --   -- we don't want to debug code inside node_modules, so skip it!
          --   skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
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
              local test_name = vim.g.vitest_last_spec_name
              if not test_name or test_name == "" or test_name == vim.NIL then
                test_name = vim.fn.input "Test name: "
              else
                test_name = vim.fn.input("Test name: ", test_name)
              end
              vim.g.vitest_last_spec_name = test_name

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
