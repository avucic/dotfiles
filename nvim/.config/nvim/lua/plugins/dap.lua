-- return {
--   {
--     "mfussenegger/nvim-dap",
--     dependencies = {
--       {
--         "jay-babu/mason-nvim-dap.nvim",
--         opts = function(_, opts)
--           opts.ensure_installed =
--             require("astrocore").list_insert_unique(opts.ensure_installed or {}, { "js", "node2" })
--         end,
--       },
--       {
--         "suketa/nvim-dap-ruby",
--         config = function() require("dap-ruby").setup() end,
--         keys = {
--           { "<leader>dl", function() require("dap").run_last() end, desc = "Last task" },
--         },
--       },
--       {
--         "mxsdev/nvim-dap-vscode-js",
--         dependencies = { "mason-org/mason.nvim" },
--         opts = function()
--           local mr = require "mason-registry"
--           local pkg = mr.get_package "js-debug-adapter"
--
--           return {
--             debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
--             adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
--             -- debugger_path = pkg.install_path .. "/js-debug",
--             -- adapters = {
--             --   "pwa-node",
--             --   "pwa-chrome",
--             --   "pwa-msedge",
--             --   "node-terminal",
--             --   "pwa-extensionHost",
--             -- },
--           }
--         end,
--       },
--     },
--   },
-- }

-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

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

return {
  {
    "suketa/nvim-dap-ruby",
    config = function() require("dap-ruby").setup() end,
    keys = {
      { "<leader>dl", function() require("dap").run_last() end, desc = "Last task" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    opts = {
      ensure_installed = { "js", "node2" }, -- Automatically install the adapter
    },
    config = function()
      local dap = require "dap"
      local debug_host = vim.env.DAP_HOST or "localhost"
      local debug_port = tonumber(vim.env.DAP_PORT) or 9229

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = {
            "${port}",
          },
        },
      }
      if not vscode_launch_config_exists() then
        for _, adapter in pairs { "node", "pwa-chrome" } do
          require("dap").adapters[adapter] = {
            type = "server",
            host = debug_host,
            port = debug_port,
            executable = {
              command = "js-debug-adapter",
              args = { debug_port },
            },
          }
        end
        for _, language in ipairs { "typescript", "typescriptreact", "javascript", "svelte" } do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to Docker Node",
              address = debug_host,
              port = debug_port,
              localRoot = "${workspaceFolder}",
              remoteRoot = "/app",
              sourceMaps = true,
              skipFiles = {
                "<node_internals>/**",
              },
            },

            {
              type = "pwa-chrome",
              request = "attach",
              name = "Attach Chrome (React @ 4000)",
              port = debug_port,
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
              port = debug_port,
              -- skip files from vite's hmr
              skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
            },
          }
        end
      end
    end,
  },
}
