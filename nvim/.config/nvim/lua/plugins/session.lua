return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    keys = {
      { '<Leader>Ss', function() require('persistence').save() end,                desc = 'Save session' },
      { '<Leader>Sl', function() require('persistence').load() end,                desc = 'Load session (cwd)' },
      { '<Leader>Sr', function() require('persistence').load({ last = true }) end, desc = 'Restore last session' },
      { '<Leader>Sd', function() require('persistence').stop() end,                desc = 'Stop saving session' },
    },
    config = function()
      require('persistence').setup({
        dir = vim.fn.stdpath('state') .. '/sessions/',
      })
    end,
  },
}
