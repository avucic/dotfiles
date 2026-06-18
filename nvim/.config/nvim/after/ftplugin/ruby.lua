local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set('n', '<Leader>mtt', function()
  require('overseer').run_action(nil, 'rspec - current spec')
end, { desc = 'Run current spec', buffer = bufnr })
