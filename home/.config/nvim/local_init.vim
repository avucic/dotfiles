" General {{{
" =============================================
" set guifont=Monaco:h12
set guifont=Monaco\ for\ Powerline:h12:w

" split
set splitbelow
set splitright
set nowrap
" color
colorscheme  base16-twilight

let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
endif
" Folding
set foldlevelstart=99
set foldmethod=syntax
set foldlevel=1
autocmd FileType .vim set foldmethod=marker
" }}}

" Code formatting {{{
" =============================================
au filetype xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd bufnewfile,bufread *.slim set ft=slim
autocmd bufnewfile,bufread *.svg set ft=xml
"}}}

" Keymaps {{{
" =============================================
" Folding
nnoremap <Leader>fs :set foldmethod=syntax<CR>
nnoremap <Leader>fm :set foldmethod=marker<CR>
nnoremap <Leader>fi :set foldmethod=indent<CR>

"jump to a matching opening or closing parenthesis and select
noremap % v%
" Edit vim config
nmap     <Leader>nn :tabedit $MYVIMRC<CR>

" clear higlight
nnoremap <esc> :noh<return><esc>

" search for visually hightlighted text
vnoremap <C-r> "0y<Esc>:%s/<C-r>0//g<left><left>

" clear white space
nnoremap <Leader>s :FixWhitespace<return><esc>

"" Clean search (highlight)
nnoremap <esc> :noh<return><esc>

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

" Toggle buffer
nmap     <Leader>bb :ls<CR>:buffer<Space>         " show buffers

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

" cursor
nmap <silent> <Leader>cl <Esc>:set                  cursorline! <CR>a
nmap <silent> <Leader>cc      :set   cursorcolumn!              <CR>
nmap <silent> <Leader>cn      :set nocursorcolumn nocursorline  <CR>

" nvim specific
" **************************************************************************
" move from the neovim terminal window to somewhere else
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <C-\><C-n><C-w>l
tnoremap <Esc><Esc> <C-\><C-n>
"}}}

" Plugns {{{
" =============================================

" Vim Airline
" ------------------------------------------------------------------------------
" let g:airline_powerline_fonts   = 1
let g:airline_theme='base16'

" Nerdtree
" ------------------------------------------------------------------------------
nmap <leader>[ :NERDTreeToggle<cr>

" Tagbar
" ------------------------------------------------------------------------------
nmap <Leader>] :TagbarToggle<CR>

" vim-expand-regon
" ------------------------------------------------------------------------------
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Undotree
" ------------------------------------------------------------------------------
nmap <Leader>hh :UndotreeToggle<CR>

" Splitjoin plugin keybinding
" ------------------------------------------------------------------------------
nmap sj :SplitjoinSplit<cr> nmap sk :SplitjoinJoin<cr>

" Deoplete
" ------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_list = 1000
set completeopt=menuone,preview
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
let g:UltiSnipsExpandTrigger="<c-j>"
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0
" ultisnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"

" vim-notes
" ------------------------------------------------------------------------------
let g:notes_directories = ['~/Google\ Drive/Notes/']

" SuperTab
" ------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

" EasyAlign
" ------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Neoterm
" ------------------------------------------------------------------------------
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
tnoremap <Esc> <C-\><C-n>
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

" Limelight
" ------------------------------------------------------------------------------
let g:limelight_conceal_guifg = 'DarkGray'
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

" Goyo (distraction-free)
" ------------------------------------------------------------------------------
let g:goyo_width="80%"
nnoremap <Leader>g :Goyo<CR>
function! s:goyo_enter()
  set scrolloff=999
endfunction
function! s:goyo_leave()
  set scrolloff=5
endfunction

" IndentLine
" ------------------------------------------------------------------------------
let g:indentLine_enabled = 0
let g:indentLine_color_dark = 1
nmap <Leader>i :IndentLinesToggle<CR>

" Syntastic Sass
" ------------------------------------------------------------------------------
let g:syntastic_sass_checkers=["sasslint"]
let g:syntastic_scss_checkers=["sasslint"]
let g:ruby_host_prog = '/home/rotsen/.rubies/ruby-2.3.1/bin/ruby'
"}}}
