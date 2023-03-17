return function(_, opts)
  require("nvim-lightbulb").setup(opts)
  vim.cmd([[
     augroup LightBulb
              autocmd!
              autocmd CursorHold,CursorHoldI  *\(.md\|.diffs\)\@<! lua require'nvim-lightbulb'.update_lightbulb({priority = 10})
              autocmd BufLeave,WinLeave  *\(.md\|.diffs\)\@<! lua vim.fn.sign_unplace("nvim-lightbulb")
      augroup end
    ]])
end
