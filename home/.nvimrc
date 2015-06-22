source ~/.vimrc
augroup terminal
  autocmd TermOpen * setlocal nospell
augroup END

augroup myvimrchooks
au!
  autocmd bufwritepost .nvimrc source $HOME/.nvimrc
augroup END

" move from the neovim terminal window to somewhere else
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

tnoremap <Esc><Esc> <C-\><C-n>

nmap     <Leader>v :tabedit ~/.nvimrc<CR>

" Useful maps
" hide/close all terminals
nnoremap <silent> ,th :call neoterm#close_all()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>
" Open terminal and run lein figwheel
nnoremap <C-w>t :botright split <bar> :resize 10 <bar> :terminal<CR>

nmap <Leader>term <C-w>v:terminal<CR>lein figwheel<CR><C-\><C-n><C-w>p
" Evaluate anything from the visual mode in the next window
vmap <buffer> ,e y<C-w>wpi<CR><C-\><C-n><C-w>p
" Evaluate outer most form
nmap <buffer> ,e ^v%,e
" Evaluate buffer"
nmap <buffer> ,eb ggVG,e
" fix nvim bug
nmap <BS> <C-W>h
