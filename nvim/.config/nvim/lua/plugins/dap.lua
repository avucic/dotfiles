return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<Leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      { '<Leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end, desc = 'Conditional breakpoint' },
      { '<Leader>dc', function() require('dap').continue() end,   desc = 'Continue' },
      { '<Leader>dn', function() require('dap').step_over() end,  desc = 'Step over' },
      { '<Leader>di', function() require('dap').step_into() end,  desc = 'Step into' },
      { '<Leader>do', function() require('dap').step_out() end,   desc = 'Step out' },
      { '<Leader>dl', function() require('dap').run_last() end,   desc = 'Run last' },
      { '<Leader>du', function() require('dapui').toggle() end,   desc = 'Toggle UI' },
      { '<Leader>dq', function() require('dap').terminate() end,  desc = 'Terminate' },
    },
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'suketa/nvim-dap-ruby',
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'mason-org/mason.nvim' },
        config = function()
          require('mason-nvim-dap').setup({
            ensure_installed       = { 'js', 'node2' },
            automatic_installation = false,
          })
        end,
      },
    },
    config = function()
      local dap   = require('dap')
      local dapui = require('dapui')

      vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DapBreakpoint',         linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected',  { text = '●', texthl = 'DapBreakpointRejected',  linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint',            { text = '◉', texthl = 'DapLogPoint',            linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped',             { text = '→', texthl = 'DapStopped',             linehl = 'DapStoppedLine', numhl = 'DapStopped' })

      vim.api.nvim_set_hl(0, 'DapBreakpoint',         { fg = '#f38ba8' })
      vim.api.nvim_set_hl(0, 'DapBreakpointCondition',{ fg = '#f9e2af' })
      vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#6c7086' })
      vim.api.nvim_set_hl(0, 'DapLogPoint',           { fg = '#89b4fa' })
      vim.api.nvim_set_hl(0, 'DapStopped',            { fg = '#f9e2af', bold = true })
      vim.api.nvim_set_hl(0, 'DapStoppedLine',        { bg = '#2a2b3c' })

      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config']  = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config']  = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config']      = function() dapui.close() end

      require('dap-ruby').setup()

      local debug_host = vim.env.DAP_HOST or 'localhost'
      local debug_port = tonumber(vim.env.DAP_PORT) or 9229

      local function vscode_launch_exists()
        return vim.fn.filereadable(vim.fn.getcwd() .. '/.vscode/launch.json') == 1
      end
      local function find_package_json_root()
        local file = vim.api.nvim_buf_get_name(0)
        local dir  = vim.fn.fnamemodify(file, ':p:h')
        while dir ~= '/' do
          if vim.fn.filereadable(dir .. '/package.json') == 1 then return dir end
          dir = vim.fn.fnamemodify(dir, ':h')
        end
        return vim.fn.getcwd()
      end

      dap.adapters['pwa-node'] = {
        type       = 'server',
        host       = debug_host,
        port       = debug_port,
        executable = { command = 'js-debug-adapter', args = { tostring(debug_port) } },
      }

      if not vscode_launch_exists() then
        for _, adapter in ipairs({ 'node', 'pwa-chrome' }) do
          dap.adapters[adapter] = {
            type       = 'server',
            host       = debug_host,
            port       = debug_port,
            executable = { command = 'js-debug-adapter', args = { debug_port } },
          }
        end
        for _, lang in ipairs({ 'typescript', 'typescriptreact', 'javascript', 'svelte' }) do
          dap.configurations[lang] = {
            {
              type       = 'pwa-node',
              request    = 'attach',
              name       = 'Attach to Docker Node',
              address    = debug_host,
              port       = debug_port,
              localRoot  = '${workspaceFolder}',
              remoteRoot = '/app',
              sourceMaps = true,
              skipFiles  = { '<node_internals>/**' },
            },
            {
              type       = 'pwa-chrome',
              request    = 'attach',
              name       = 'Attach Chrome (React @ 4000)',
              port       = debug_port,
              webRoot    = '${workspaceFolder}',
              sourceMaps = true,
              protocol   = 'inspector',
              url        = 'http://localhost:4000',
            },
            {
              type       = 'pwa-chrome',
              request    = 'launch',
              name       = 'Launch Chrome',
              url        = 'http://localhost:4000',
              sourceMaps = true,
              webRoot    = find_package_json_root() .. '/src',
              protocol   = 'inspector',
              port       = debug_port,
              skipFiles  = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*' },
            },
          }
        end
      end
    end,
  },
}
