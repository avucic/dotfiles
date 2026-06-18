return {
  -- ── overseer ──────────────────────────────────────────────────────────────────
  {
    'stevearc/overseer.nvim',
    cmd  = { 'OverseerRun', 'OverseerToggle' },
    keys = {
      { '<Leader>tr', '<cmd>OverseerRun<cr>',    desc = 'Run task' },
      { '<Leader>tR', '<cmd>OverseerToggle<cr>', desc = 'Task list' },
    },
    config = function() require('overseer').setup() end,
  },

  -- ── vim-dadbod (database UI) ──────────────────────────────────────────────────
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd  = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection' },
    keys = { { '<Leader>oD', '<cmd>DBUI<cr>', desc = 'Database UI' } },
    dependencies = {
      { 'tpope/vim-dadbod',                    lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', lazy = true },
    },
  },

}
