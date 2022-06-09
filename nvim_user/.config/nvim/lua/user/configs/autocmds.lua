vim.cmd([[
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _spell
    autocmd!
    autocmd BufRead, BufNewFile * setlocal spell
  augroup end

  augroup _lsp
    autocmd! BufWritePre * if ( get(g:, 'autoformat_on_save') == 1 )
    \| execute 'lua vim.lsp.buf.formatting() '
    \| endif
  augroup end
]])

-- Remove all trailing whitespace on save
vim.api.nvim_exec(
  [[
  augroup TrimWhiteSpace
    au!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
  ]],
  false
)
-- Prevent new line to also start with a comment
vim.api.nvim_exec(
  [[
  augroup NewLineComment
    au!
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  augroup END
  ]],
  false
)

vim.api.nvim_exec(
  [[
  augroup laststatus_line
    au!
    au FileType * set laststatus=3
  augroup END
  ]],
  false
)

vim.cmd([[
  augroup _neorg
    au!
    autocmd BufWritePre *.norg :normal gg=G
  augroup end
]])
