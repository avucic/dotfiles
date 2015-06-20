source ~/.vimrc
augroup terminal
  autocmd TermOpen * setlocal nospell
augroup END

tnoremap <esc><esc> <C-\><C-n>
" move from the neovim terminal window to somewhere else
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Open terminal and run lein figwheel
nmap <Leader>term <C-w>v:terminal<CR>lein figwheel<CR><C-\><C-n><C-w>p
" Evaluate anything from the visual mode in the next window
vmap <buffer> ,e y<C-w>wpi<CR><C-\><C-n><C-w>p
" Evaluate outer most form
nmap <buffer> ,e ^v%,e
" Evaluate buffer"
nmap <buffer> ,eb ggVG,e
" fix nvim bug
nmap <BS> <C-W>h

nmap     <Leader>v :tabedit ~/.nvimrc<CR>
