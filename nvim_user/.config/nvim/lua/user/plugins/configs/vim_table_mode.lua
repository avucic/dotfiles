local M = {}

function M.setup()
  -- let g:table_mode_realign_map = '<Leader>ntr'
  -- let g:table_mode_delete_row_map = '<Leader>ntdd'
  -- let g:table_mode_delete_column_map = '<Leader>ntdc'
  -- let g:table_mode_insert_column_before_map = '<Leader>ntiC'
  -- let g:table_mode_insert_column_after_map = '<Leader>ntic'
  -- let g:table_mode_add_formula_map = '<Leader>ntfa'
  -- let g:table_mode_eval_formula_map = '<Leader>ntfe'
  -- let g:table_mode_echo_cell_map = '<Leader>nt?'
  -- let g:table_mode_sort_map = '<Leader>nts'
  -- let g:table_mode_tableize_map = '<Leader>ntt'
  -- let g:table_mode_tableize_d_map = '<Leader>nT'

  vim.g.table_mode_disable_tableize_mappings = 1
  vim.g.table_mode_disable_mappings = 1
  -- vim.g.table_mode_corner_corner = "+"
  -- vim.g.table_mode_header_fillchar = "="
  vim.g.table_mode_always_active = 1
end

return M
