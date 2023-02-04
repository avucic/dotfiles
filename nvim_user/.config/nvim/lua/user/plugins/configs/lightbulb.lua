return function(_, opts)
  require("nvim-lightbulb").setup(opts)
  vim.cmd(
    [[autocmd CursorHold,CursorHoldI *\(.md\|.diffs\)\@<! lua require'nvim-lightbulb'.update_lightbulb({priority = 10})]]
  )
end
