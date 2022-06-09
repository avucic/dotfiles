local M = {}

function M.config()
  vim.api.nvim_exec(
    [[
  function LazyGitNativation()
    echom &filetype
    echom &filetype
    echom &filetype
    if &filetype ==# 'toggleterm'
      tnoremap <Esc> <Esc>
      tnoremap <C-v><Esc> <Esc>
    endif
  endfunction

  augroup _lazygit
    au!
    autocmd TermEnter * call LazyGitNativation()
  augroup END
  ]],
    false
  )
end

return M
