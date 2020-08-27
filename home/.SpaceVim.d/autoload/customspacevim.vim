function! customspacevim#before() abort
endfunction

function! customspacevim#after() abort
  set showtabline=0
  let g:test#strategy = "neovim"
  " let g:CtrlSpaceSaveWorkspaceOnExit = 1
  " let g:CtrlSpaceSaveWorkspaceOnSwitch = 0
  " let g:CtrlSpaceIgnoredFiles = '\v(tmp|temp|work|vendors)[\/]'
"
  " let g:neoformat_html_jsbeautify = {
        " \ 'exe': 'js-beautify',
        " \ 'args': ['-s 4', '-E'],
        " \ 'replace': 1,
        " \ 'stdin': 1,
        " \ 'env': ["DEBUG=1"],
        " \ 'valid_exit_codes': [0, 23],
        " \ 'no_append': 1
        " \ }
  " let g:neoformat_enabled_html = ['jsbeautify']
  " let g:neoformat_basic_format_align = 1
  " let g:neoformat_basic_format_retab = 1
  " let g:neoformat_basic_format_trim = 1
  "
let g:neoformat_eelixir_htmlbeautify = {
          \ 'exe': 'html-beautify',
          \ 'args': ['--indent-size ' .shiftwidth()],
          \ 'stdin': 1,
          \ }

let g:neoformat_enabled_eelixir = ['htmlbeautify']

  "" Clipboard
  noremap YY "+y<CR>
  inoremap <leader>p "+gP<CR>
  noremap XX "+x<CR>
  "" jumping
  noremap H ^
  noremap L g_

  "" Escape insert mode
  inoremap jj <ESC>

  "" Common in insert mode
  inoremap jj <ESC>
  inoremap II <Esc>I
  inoremap AA <Esc>A
  inoremap OO <Esc>O

  inoremap  <Esc>
endfunction

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
