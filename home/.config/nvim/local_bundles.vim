" General  ------------------------------------------------------------------{{{
Plug 'sickill/vim-pasta' " Improve paste
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim' " Conventions for vim
Plug 'kassio/neoterm'
"}}}

" Vim Session  --------------------------------------------------------------{{{
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
"}}}

" Navigation/Folding  -------------------------------------------------------{{{
Plug 'scrooloose/nerdtree'
Plug 'EvanDotPro/nerdtree-symlink'
Plug 'ivalkeen/nerdtree-execute'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-unimpaired' " Navigate throught quicklist
Plug 'Lokaltog/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'mbbill/undotree'
Plug 'Konfekt/FastFold'
"}}}

" Auto complete  ------------------------------------------------------------{{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern','for': ['javascript', 'javascript.jsx']  }
Plug 'fishbullet/deoplete-ruby',{'for': 'ruby'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"}}}

" Look and feel/Visual  -----------------------------------------------------{{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'kshenoy/vim-signature' "vim marks
Plug 'steelsojka/color_highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"}}}

" Text ----------------------------------------------------------------------{{{
Plug 'tpope/vim-commentary'
Plug 'xolox/vim-notes'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'  "Write free text
Plug 'tpope/vim-abolish' " text inflection and case  manipulation
Plug 'junegunn/limelight.vim' "Not destriactive sections of text
Plug 'triglav/vim-visual-increment' " Increment numbers by visual selection
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
"}}}

" Syntax --------------------------------------------------------------------{{{
" Plug 'gcorne/vim-sass-lint'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/CSApprox'
Plug 'alpaca-tc/beautify.vim'
Plug 'sbdchd/neoformat'
"}}}

" Git  ----------------------------------------------------------------------{{{
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim' "Browse git commits
"}}}

" Search --------------------------------------------------------------------{{{
" Plug 'vim-scripts/grep.vim'
Plug 'rking/ag.vim'
Plug 'taiansu/nerdtree-ag'
Plug 'nelstrom/vim-visual-star-search'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"}}}

" HTML  ---------------------------------------------------------------------{{{
Plug 'Valloric/MatchTagAlways'
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'
"}}}

" CSS  ----------------------------------------------------------------------{{{
Plug 'groenewege/vim-less'
"}}}

" Javascript  ---------------------------------------------------------------{{{
Plug 'jelera/vim-javascript-syntax'
"}}}

" Lisp  ---------------------------------------------------------------------{{{
Plug 'vim-scripts/slimv.vim'
"}}}

" Ruby/Rails  ---------------------------------------------------------------{{{
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-bundler'
Plug 'slim-template/vim-slim'
Plug 'bruno-/vim-ruby-fold'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' } "Selecting ruby block
" Plug 'tpope/vim-rbenv',                           { 'for': 'ruby' }
" Plug 'vim-ruby/vim-ruby',                         { 'for': 'ruby' }
" Plug 'skalnik/vim-vroom',                         { 'for': 'ruby' }
" Plug 't9md/vim-ruby-xmpfilter',                   { 'for': 'ruby' }
" Plug 'tpope/vim-dispatch',                        { 'for': 'ruby' }
Plug 'jgdavey/vim-blockle', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
"}}}

" JSON  ---------------------------------------------------------------------{{{
Plug 'tpope/vim-jdaddy' "json mappings
"}}}
