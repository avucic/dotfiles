"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: init.vim                                                       "
" Maintainer: Aleksandar Vucic  <vucinjo@gmail.com>                          "
"        URL: http://github.com/avstudio/dotfiles                            "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"01. General:{{{
set nocompatible
filetype off

set tags=./tags,tags
set clipboard=unnamed
set spell spelllang=en_us

filetype plugin indent on    " required
augroup myvimrchooks
au!
  autocmd bufwritepost init.vim source $HOME/.config/nvim/init.vim
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END


let mapleader="\<Space>"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" nvim specific
" **************************************************************************
set backupdir=/tmp
augroup terminal
  autocmd TermOpen * setlocal nospell
augroup END
"}}}

"02. Plugins:{{{
call plug#begin()
" General {{{2
Plug 'tpope/vim-sensible'
Plug 'editorconfig/editorconfig-vim'
Plug 'xolox/vim-notes',                           { 'on':  'Note' }
Plug 'xolox/vim-misc'
Plug 'triglav/vim-visual-increment'
Plug 'chriskempson/base16-vim'
Plug 'rking/ag.vim',                              { 'on':  'Ag' }
Plug 'taiansu/nerdtree-ag'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree',                       { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs',                   { 'on':  'NERDTreeToggle' }
Plug 'junegunn/vim-easy-align'
Plug 'edkolev/tmuxline.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-jdaddy'
Plug 'matchit.zip'
Plug 'MatchTag'
Plug 'Valloric/MatchTagAlways'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
" Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'
Plug 'mkitt/tabline.vim'
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'
Plug 'sjl/gundo.vim'
Plug 'tommcdo/vim-exchange'
Plug 'nelstrom/vim-qargs'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-abolish' " text inflection and case  manipulation
Plug 'benekastah/neomake'
Plug 'kshenoy/vim-signature' "vim marks
Plug 'gregsexton/gitv'
" Plug 'jeetsukumaran/vim-buffergator'



" Plug 'Shougo/neocomplcache.vim'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'ervandew/supertab'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'bendavis78/vim-polymer'
Plug 'Lokaltog/vim-easymotion'
" Plug 'cazador481/fakeclip.neovim'
" Plug 'taiansu/nerdtree-ag'
Plug 'kassio/neoterm', { 'commit': '9e33da0a' }
"}}}
" Ruby {{{2
Plug 'tpope/vim-rbenv',                           { 'for': 'ruby' }
Plug 'tpope/vim-rails',                           { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec',                      { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby',                         { 'for': 'ruby' }
Plug 'tpope/vim-haml',                            { 'for': 'ruby' }
Plug 'skalnik/vim-vroom',                         { 'for': 'ruby' }
Plug 'tpope/vim-rake',                            { 'for': 'ruby' }
Plug 't9md/vim-ruby-xmpfilter',                   { 'for': 'ruby' }
Plug 'tpope/vim-dispatch',                        { 'for': 'ruby' }
Plug 'bruno-/vim-ruby-fold',                      { 'for': 'ruby' }
Plug 'nelstrom/vim-markdown-folding',             { 'for': 'ruby' }
Plug 'jgdavey/vim-blockle',                       { 'for': 'ruby' }
Plug 'tpope/vim-endwise',                         { 'for': 'ruby' }
"}}}
" JavaScript {{{2
Plug 'pangloss/vim-javascript',                   { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script',                  { 'for': 'coffee' }
Plug 'elzr/vim-json',                             { 'for': 'json' }
Plug 'jQuery'
"}}}
" HTML {{{2
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/html5.vim'
Plug 'indenthtml.vim'
"}}}
" Clojure {{{2
Plug 'guns/vim-clojure-static',                   { 'for': 'clojure' }
Plug 'tpope/vim-classpath',                       { 'for': 'clojure' }
Plug 'guns/vim-sexp',                             { 'for': 'clojure' }
Plug 'gberenfield/cljfold.vim',                   { 'for': 'clojure' }
Plug 'tpope/vim-fireplace',                       { 'for': 'clojure' }
"}}}
" Php {{{2
Plug  'StanAngeloff/php.vim',                     { 'for': 'php' }
"}}}
" Syntax highlight{{{2
Plug 'cakebaker/scss-syntax.vim'
Plug 'slim-template/vim-slim'
Plug 'groenewege/vim-less'
Plug 'Markdown'
"}}}

call plug#end()
"}}}                                                                "

" 03. Theme/Colors:{{{
set t_Co=256              " enable 256-color mode.
" let base16colorspace=256
" set term=screen-256color
set background=dark
syntax enable             " enable syntax highlighting (previously syntax on).

if has("gui_running")
  colorscheme  base16-twilight
elseif &t_Co == 256
  colorscheme  base16-twilight
endif

" set guifont=Monaco:h14
set guifont=Monaco\ for\ Powerline:h12:w

" Prettify Markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
endif

" vin indent guideline
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1
" }}}                                                           "

" 04. Vim UI:{{{
set number                " show line numbers
set numberwidth=5         " make the number gutter 6 characters wide
set cul                   " highlight current line
set laststatus=2          " last window always has a statusline
"set nohlsearch            " Don't continue to highlight searched phrases.
set hlsearch              " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set showmatch
set visualbell
" set hlsearch
set cpoptions+=$          " Mark editable area and dollar sign et the end
set laststatus=2
set hidden                " allow to move to the next buffer even file is changed
" }}}                                                                "

" 05. Text Formatting/Layout:{{{
set autoindent            " auto-indent
set tabstop=2             " tab spacing
set softtabstop=2         " unify
set shiftwidth=2          " indent/outdent by 2 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smartindent           " automatically insert one extra level of indentation
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text
set pastetoggle=<F2>      " toggle paste formating
set formatoptions+=r      " continue comments
set listchars=tab:▸\ ,eol:¬
" set cursorline

"folding settings
set foldenable            " enable folding
set foldmethod=marker
" " set foldmethod=expr
" " set foldexpr=GetFold()
" set foldnestmax=10        " deepest fold is 10 levels
" set foldlevel=99          " close all folds by default
set foldlevelstart=2
"
nmap <Leader>ff :call <SID>ToggleFold()<CR>
function! s:ToggleFold()
    if &foldmethod == 'marker'
        let &l:foldmethod = 'syntax'
    else
        let &l:foldmethod = 'marker'
    endif
    echo 'foldmethod is now ' . &l:foldmethod
endfunction

if has("gui_macvim")
  set macmeta            "meta key combinations for VIM on OS X
end

if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  " map > <C-W>>
  " map < <C-W><
endif

" search for visually hightlighted text
vnoremap <C-r> "0y<Esc>:%s/<C-r>0//g<left><left>

" split
set splitbelow
set splitright
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
" }}}                                                 "

" 06. Custom Mappings:{{{
nmap     <Leader>v :tabedit ~/.config/nvim/init.vim<CR>
" new line
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" cursor
nmap <silent> <Leader>cl <Esc>:set                  cursorline! <CR>a
nmap <silent> <Leader>cc      :set   cursorcolumn!              <CR>
nmap <silent> <Leader>cn      :set nocursorcolumn nocursorline  <CR>

" code formatting
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd BufNewFile,BufRead *.slim set ft=slim

"=== pry ===
" quickfix list for breakpoints
nmap <Leader>i :Ag binding.pry<CR>
" …also, Insert Mode as bpry<space>
iabbr bpry require'pry';binding.pry
" And admit that the typos happen:
iabbr bpry require'pry';binding.pry
" Add the pry debug line with \bp (or <Space>bp, if you did: map <Space> <Leader> )
map <Leader>bp orequire'pry';binding.pry<esc>:w<cr>
" Alias for one-handed operation:
map <Leader><Leader>p <Leader>bp
"===========================

" quick search fom visual
vnoremap // y/<C-R>"<CR>"
" search and replace from visual
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left><Paste>
" next/prev quicklist item
nmap <c-b> :cprevious<CR>
nmap <c-n> :cnext<CR>

" folding
nnoremap <Leader><Space> za
" Bubble single lines
nmap     <C-Up> ddkP
nmap     <C-Down> ddp
" Bubble multiple lines
vmap     <C-Up> xkP`[V`]
vmap     <C-Down> xp`[V`]
" command line navigation
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
" cnoremap <Leader>b <S-Left>
" cnoremap <Leader>f <S-Right>
map      <Leader>p $p                             " paste at the end of line
map      <Leader>P ^ph                            " paste at the begining of line
map      <Leader>pp $<space>p                     " paste at the end of line and make one space
nnoremap <esc> :noh<return><esc>                  " clear highlight
nmap     <Leader>bb :ls<CR>:buffer<Space>         " show buffers
nnoremap <Leader>s :StripWhitespace<return><esc>  " clear whitespace
noremap % v%                                      "jump to a matching opening or closing parenthesis and select

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
" nnoremap <C-S-tab> :tabprevious<CR>
" nnoremap <C-tab>   :tabnext<CR>
" nnoremap <C-t>     :tabnew<CR>
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>
" }}}                                                       "

" 07. Plugin specific Commands and Mappings:{{{
" vim-expand-regon
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Splitjoin plugin keybinding
nmap sj :SplitjoinSplit<cr> nmap sk :SplitjoinJoin<cr>

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 1
let g:neomake_warning_sign = {
  \ 'text': '⚠',
  \ 'texthl': 'WarningMsg',
  \ }

let g:neomake_error_sign = {
  \ 'text': '✗',
  \ 'texthl': 'ErrorMsg',
  \ }

" Nerdtree
set guioptions-=L         " remove scrollbar for NERDTree
nmap <leader>[ :NERDTreeToggle<cr>

" Vim Airline
let g:airline_powerline_fonts   = 1
let g:airline_theme='base16'

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

" Tagbar
nmap <Leader>] :TagbarToggle<CR>
nmap <Leader>]] :TagbarOpenAutoClose<CR>

" vim-notes
let g:notes_directories = ['~/Google\ Drive/Notes/']

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" blockle
let g:blockle_mapping = '<Leader>bb'

" deoplete config
let g:deoplete#enable_at_startup = 1
set completeopt=menuone,preview
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<c-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" tern
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0

" Neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
" open  terminal split
" nmap <C-w>d :bot split<CR>
" nnoremap <C-w>d :bot split <bar> :resize 10<CR>
:tnoremap <Esc> <C-\><C-n>
" nnoremap <C-w>t  :below 10sp term://$SHELL<cr>i
" Open terminal and run lein figwheel
" nnoremap <Leader>tt :Topen<CR>
nnoremap <silent> <Leader>tf :TREPLSendFile<cr>
nnoremap <silent> <Leader>ts :TREPLSend<cr>
vnoremap <silent> <Leader>ts :TREPLSend<cr>
" run set test lib
nnoremap <silent> <Leader>rt :call neoterm#test#run('all')<cr>
nnoremap <silent> <Leader>rf :call neoterm#test#run('file')<cr>
nnoremap <silent> <Leader>rn :call neoterm#test#run('current')<cr>
nnoremap <silent> <Leader>rr :call neoterm#test#rerun()<cr>

" Useful maps
" hide/close terminal
nnoremap <silent> <Leader>th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> <Leader>tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <Leader>tc :call neoterm#kill()<cr>

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

" Git commands
command! -nargs=+ Tg :T git <args>

" xmpfilter
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)
nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

" Make Ctrl-P plugin a lot faster for Git projects
" nnoremap <c-p> :CtrlPMixed<cr>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

" gundo
nmap     <Leader>g :GundoToggle<CR>

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gD :Git diff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete
set diffopt+=vertical

" vim gutter
let g:gitgutter_max_signs=9999


" nvim specific
" **************************************************************************
" move from the neovim terminal window to somewhere else
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <C-\><C-n><C-w>l

tnoremap <Esc><Esc> <C-\><C-n>

nmap <Leader>term <C-w>v:terminal<CR>lein figwheel<CR><C-\><C-n><C-w>p
" Evaluate anything from the visual mode in the next window
vmap <buffer> ,e y<C-w>wpi<CR><C-\><C-n><C-w>p
" Evaluate outer most form
nmap <buffer> ,e ^v%,e
" Evaluate buffer"
nmap <buffer> ,eb ggVG,e
" fix nvim bug
nmap <BS> <C-W>h
" }}}                                                       "
