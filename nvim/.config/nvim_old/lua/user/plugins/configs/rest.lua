return function(_, opts)
  require("rest-nvim").setup(opts)

  --   vim.cmd([[
  --   augroup _keybinding
  --     au!
  --     autocmd FileType http nnoremap <buffer> <CR> <plug>RestNvim<CR>
  --     autocmd FileType http nnoremap <buffer> <S-CR> <plug>RestNvimLast<CR>
  --     autocmd FileType http nnoremap <buffer> P <plug>RestNvimPreview<CR>
  --   augroup end
  -- ]])
end
