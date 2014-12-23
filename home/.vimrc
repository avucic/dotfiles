  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set rtp+=~/.vim/bundle/Vundle.vim
set tags=./tags,tags
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'godlygeek/tabular'
Plugin 'edkolev/tmuxline.vim'
Plugin 'bling/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-bundler'
Bundle "mattn/emmet-vim"
Bundle "tpope/vim-commentary"
Bundle 'matchit.zip'
Bundle 'MatchTag'
Bundle 'Valloric/MatchTagAlways'
Bundle 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'breuckelen/vim-resize'


" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Programming
Bundle "jQuery"
" Language Additions
" Ruby
Bundle 'tpope/vim-rails'
Plugin 'thoughtbot/vim-rspec'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-cucumber'
Bundle 't9md/vim-ruby-xmpfilter'
Bundle 'tpope/vim-dispatch'
Bundle 'bruno-/vim-ruby-fold'
" JavaScript
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'leshill/vim-json'
" HTML
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'othree/html5.vim'
Bundle 'indenthtml.vim'

" Clojure
" Bundle 'vim-scripts/VimClojure'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace.git'
Bundle 'tpope/vim-classpath.git'
" Bundle 'guns/vim-clojure-highlight'
" Bundle 'kien/rainbow_parentheses.vim'
Bundle 'guns/vim-sexp'

" Syntax highlight
Bundle "cucumber.zip"
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

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et

" xmpfilter
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)

nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

" autocmd vimenter * NERDTree

" Enable omnicompletion (to use, hold Ctrl+X then Ctrl+O while in Insert mode.
set ofu=syntaxcomplete#Complete
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
"set guifont=Monaco:h14
set guifont=Monaco\ for\ Powerline:h14
" Prettify JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd Syntax json sou ~/.vim/syntax/json.vim

" Prettify Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" Prettify Markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
  highlight ColorColumn ctermbg=red
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

" vin indent guideline
let g:indent_guides_start_level =2
let g:indent_guides_guide_size =1
" Vim Airline
let g:airline_powerline_fonts = 1
" Nerdtree
set guioptions-=L         " remove scrollbar for NERDTree

" UtilSnipets
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res == 0
    if pumvisible()
      return "\<C-N>"
    else
      return "\<TAB>"
    endif
  endif

  return ""
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Vim UI                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                " show line numbers
set numberwidth=6         " make the number gutter 6 characters wide
set cul                   " highlight current line
set laststatus=2          " last window always has a statusline
"set nohlsearch            " Don't continue to highlight searched phrases.
set hlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set showmatch
" set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set visualbell
set nocompatible          " be iMproved, required
" set hlsearch
set cpoptions+=$          " Mark editable area and dollar sign et the end
set laststatus=2
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
" set cursorline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Custom Commands                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
map <leader>w <Plug>(easymotion-w)
" remove arrows
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
" shortcut to switching between splts
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" folding
nnoremap <Space> za

set splitbelow
set splitright
