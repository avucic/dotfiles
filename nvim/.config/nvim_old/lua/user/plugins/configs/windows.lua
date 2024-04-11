return function()
  vim.o.winwidth = 10
  vim.o.winminwidth = 10
  vim.o.equalalways = false
  -- vim.o.winminwidth = 5
  require("windows").setup()
end
