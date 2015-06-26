"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                         "
" Maintainer: Aleksandar Vucic  <vucinjo@gmail.com>                          "
"        URL: http://github.com/avstudio/dotfiles                            "
"                                                                            "
"                                                                            "
" Sections:                                                                  "
"   01. General ................. General Vim behavior                       "
"   02. Events .................. General autocmd events                     "
"   03. Theme/Colors ............ Colors, fonts, etc.                        "
"   04. Vim UI .................. User interface behavior                    "
"   05. Text Formatting/Layout .. Text, tab, indentation related             "
"   06. Custom Commands ......... Any custom command aliases                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         " get rid of Vi compatibility mode. SET FIRST!
" execute pathogen#infect()
filetype off
" set the runtime path to include Vundle and initialize
if has("nvim")
  set rtp+=~/.nvim/bundle/Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
end

set tags=./tags,tags
set clipboard=unnamed
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
" Plugin 'sjl/vitality.vim'                          "fix courser for vim
Plugin 'chriskempson/base16-vim'
Plugin 'rking/ag.vim' " search Plugin
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'junegunn/vim-easy-align'
Plugin 'edkolev/tmuxline.vim'
Plugin 'bling/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-bundler'
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-unimpaired"
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-jdaddy'
Bundle 'matchit.zip'
Bundle 'MatchTag'
Bundle 'Valloric/MatchTagAlways'
Bundle 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'mkitt/tabline.vim'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tommcdo/vim-exchange.git'
Bundle 'nelstrom/vim-qargs'
Bundle 'nelstrom/vim-visual-star-search'
Plugin 'tpope/vim-abolish' " text inflection and case  manipulation
Plugin 'mattn/googletranslate-vim' " text inflection and case  manipulation
" Bundle 'jeetsukumaran/vim-buffergator'

Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/neosnippet'
Plugin 'SirVer/ultisnips'

" Bundle 'AndrewRadev/splitjoin.vim'
" Bundle 'bendavis78/vim-polymer'
Bundle 'Lokaltog/vim-easymotion'

" Programming
Bundle "jQuery"
" Language Additions
" Ruby
Bundle 'tpope/vim-rails'
Plugin 'thoughtbot/vim-rspec'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'skalnik/vim-vroom'
Bundle 'tpope/vim-rake'
Bundle 't9md/vim-ruby-xmpfilter'
Bundle 'tpope/vim-dispatch'
Bundle 'bruno-/vim-ruby-fold'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'jgdavey/vim-blockle.git'
" JavaScript
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'elzr/vim-json'
" HTML
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'othree/html5.vim'
Bundle 'indenthtml.vim'

" Clojure
" Bundle 'vim-scripts/VimClojure'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-classpath.git'
Bundle 'guns/vim-sexp'
Bundle 'gberenfield/cljfold.vim'

" Syntax highlight
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'slim-template/vim-slim'
Plugin 'groenewege/vim-less'
Bundle "Markdown"

call vundle#end()            " required
filetype plugin indent on    " required

augroup myvimrchooks
au!
  autocmd bufwritepost .vimrc source $HOME/.vimrc
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Events                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set spell spelllang=en_us
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Theme/Colors                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
set background=dark

if has("gui_running")
  colorscheme  base16-twilight
elseif &t_Co == 256
  colorscheme  base16-twilight
  " colorscheme twilight256
endif
" set guifont=Monaco:h14
set guifont=Monaco\ for\ Powerline:h12

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
" Vim Airline
let g:airline_powerline_fonts   = 1
" Nerdtree
set guioptions-=L         " remove scrollbar for NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Vim UI                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
else
  set lazyredraw
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Text Formatting/Layout                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" set cursorline

"folding settings
set foldenable            " enable folding
set foldmethod=syntax
" set foldmethod=expr
" set foldexpr=GetFold()
set foldnestmax=10        " deepest fold is 10 levels
set foldlevel=99          " close all folds by default
set foldlevelstart=99
set splitbelow
set splitright

if has("gui_macvim")
  set macmeta            "meta key combinations for VIM on OS X
end

set listchars=tab:▸\ ,eol:¬

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Custom Commands                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

 map <silent> <Leader>cl      :set                  cursorline! <CR>
imap <silent> <Leader>cl <Esc>:set                  cursorline! <CR>a
 map <silent> <Leader>cc      :set   cursorcolumn!              <CR>
imap <silent> <Leader>cc <Esc>:set   cursorcolumn!              <CR>a
 map <silent> <Leader>ct      :set   cursorcolumn!  cursorline! <CR>
imap <silent> <Leader>ct <Esc>:set   cursorcolumn!  cursorline! <CR>a
 map <silent> <Leader>co      :set   cursorcolumn   cursorline  <CR>
imap <silent> <Leader>co <Esc>:set   cursorcolumn   cursorline  <CR>a
 map <silent> <Leader>cn      :set nocursorcolumn nocursorline  <CR>
imap <silent> <Leader>cn <Esc>:set nocursorcolumn nocursorline  <CR>a

if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  " map > <C-W>>
  " map < <C-W><
endif

" split keys
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
" open aka terminal split
nmap <C-w>d :bot split<CR>
nnoremap <C-w>d :bot split <bar> :resize 10<CR>

nnoremap <Space> za
nmap     <Leader>v :tabedit ~/.vimrc<CR>
nmap     <Leader>g :GundoToggle<CR>

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

" vim-expand-regon
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Splitjoin plugin keybinding
nmap sj :SplitjoinSplit<cr> nmap sk :SplitjoinJoin<cr>


" Nerdtree
" nmap <leader>[ :NERDTreeTabsToggle<cr>
nmap <leader>[ :NERDTreeToggle<cr>

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

" Tagbar
nmap <Leader>] :TagbarToggle<CR>
nmap <Leader>]] :TagbarOpenAutoClose<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" blockle
let g:blockle_mapping = '<Leader>bb'

" NeoComplete
let g:acp_enableAtStartup                        = 0
let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_smart_case            = 1
let g:neocomplcache_min_syntax_length            = 3
let g:neocomplcache_force_overwrite_completefunc = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <S-tab>     <Plug>(neosnippet_expand_or_jump)

let g:UltiSnipsExpandTrigger         = "<s-tab>"
let g:UltiSnipsListSnippets          = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger    = "<s-tab>"
let g:UltiSnipsJumpBackwardTrigger   = "<c-k>"
" Make sure my plugins override the default ones:
let g:UltiSnipsDontReverseSearchPath = "1"

" xmpfilter
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)
nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

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

" Make Ctrl-P plugin a lot faster for Git projects
" nnoremap <c-p> :CtrlPMixed<cr>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0
