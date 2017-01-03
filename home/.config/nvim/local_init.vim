" 01. General {{{
" =============================================
" Map leader to ,
let mapleader="\<Space>"
set clipboard=unnamed

" color
if !exists('g:not_finish_vimplug')
  colorscheme  base16-twilight
endif
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
endif

" clear higlight
nnoremap <esc> :noh<return><esc>

" open custom init file
nmap     <Leader>v :tabedit ~/.config/nvim/local_init.vim<CR>

" search for visually hightlighted text
vnoremap <C-r> "0y<Esc>:%s/<C-r>0//g<left><left>

" split
set splitbelow
set splitright

" clear white space
nnoremap <Leader>s :StripWhitespace<return><esc>  " clear whitespace

" command line navigation
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

"tabs navigation
nnoremap <C-t> :tabnew<Space>
inoremap <C-t> <Esc>:tabnew<Space>
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Toggle buffer
nmap     <Leader>bb :ls<CR>:buffer<Space>         " show buffers

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate
"}}}

" 03. Plugns {{{
" =============================================
" Vim Airline
let g:airline_powerline_fonts   = 1
let g:airline_theme='base16'

" cursor
nmap <silent> <Leader>cl <Esc>:set                  cursorline! <CR>a
nmap <silent> <Leader>cc      :set   cursorcolumn!              <CR>
nmap <silent> <Leader>cn      :set nocursorcolumn nocursorline  <CR>

" Nerdtree
nmap <leader>[ :NERDTreeToggle<cr>

" Tagbar
nmap <Leader>] :TagbarToggle<CR>

" vim-expand-regon
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Undotree
nmap     <Leader>h :UndotreeToggle<CR>

" Splitjoin plugin keybinding
nmap sj :SplitjoinSplit<cr> nmap sk :SplitjoinJoin<cr>

" Easymotion
" map <Leader> <Plug>(easymotion-prefix)
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" deoplete config
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_list = 1000
set completeopt=menuone,preview
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<c-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" tern
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0

" ultisnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
let g:UltiSnipsJumpBackwardTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"

" vim-notes
let g:notes_directories = ['~/Google\ Drive/Notes/']

" Neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
:tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <Leader>tf :TREPLSendFile<cr>
nnoremap <silent> <Leader>ts :TREPLSend<cr>
vnoremap <silent> <Leader>ts :TREPLSend<cr>
" run set test lib
nnoremap <silent> <Leader>rt :call neoterm#test#run('all')<cr>
nnoremap <silent> <Leader>rf :call neoterm#test#run('file')<cr>
nnoremap <silent> <Leader>rn :call neoterm#test#run('current')<cr>
nnoremap <silent> <Leader>th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> <Leader>tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <Leader>tc :call neoterm#kill()<cr>
"}}}
