return {
  {
    'nvim-neotest/neotest',
    keys = {
      { '<Leader>tt', function() require('neotest').run.run() end,                                          desc = 'Run nearest test' },
      { '<Leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,                        desc = 'Run test file' },
      { '<Leader>td', function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,  desc = 'Debug nearest test' },
      { '<Leader>ts', function() require('neotest').summary.toggle() end,                                   desc = 'Test summary' },
      { '<Leader>to', function() require('neotest').output.open({ enter = true }) end,                      desc = 'Test output' },
      { '<Leader>tO', function() require('neotest').output_panel.toggle() end,                              desc = 'Test output panel' },
      { '<Leader>tS', function() require('neotest').run.stop() end,                                         desc = 'Stop tests' },
    },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-jest',
      'olimorris/neotest-rspec',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-rspec')({
            rspec_cmd = function() return { 'bundle', 'exec', 'rspec' } end,
          }),
          require('neotest-jest')({
            jestCommand  = 'npm test --',
            env          = { CI = true },
            cwd          = function(_) return vim.fn.getcwd() end,
            isTestFile   = require('neotest-jest.jest-util').defaultIsTestFile,
          }),
        },
        status = { virtual_text = true },
        output = { open_on_run = false },
      })
    end,
  },
}
