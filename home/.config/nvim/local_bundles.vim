" General
Plug 'sickill/vim-pasta' " Improve paste
Plug 'editorconfig/editorconfig-vim' " Conventions for vim
Plug 'kassio/neoterm', { 'commit': '9e33da0a' }

" Navigate
Plug 'tpope/vim-unimpaired' " Navigate throught quicklist
Plug 'Lokaltog/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'mbbill/undotree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern','for': ['javascript', 'javascript.jsx']  }
Plug 'fishbullet/deoplete-ruby',{'for': 'ruby'}
" Plug 'Konfekt/FastFold'

" Search
Plug 'rking/ag.vim'
Plug 'taiansu/nerdtree-ag'
Plug 'nelstrom/vim-visual-star-search'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" File manipulation
Plug 'EvanDotPro/nerdtree-symlink'
Plug 'ivalkeen/nerdtree-execute'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim' "Browse git commits

" Look and feel
Plug 'chriskempson/base16-vim'
Plug 'kshenoy/vim-signature' "vim marks
Plug 'steelsojka/color_highlight'

" Text
Plug 'xolox/vim-notes'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'  "Write free text
Plug 'tpope/vim-abolish' " text inflection and case  manipulation
Plug 'junegunn/limelight.vim' "Not destriactive sections of text
Plug 'triglav/vim-visual-increment' " Increment numbers by visual selection
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'

" Syntax
" Plug 'gcorne/vim-sass-lint'
Plug 'alpaca-tc/beautify.vim'
Plug 'sbdchd/neoformat'

" HTML
Plug 'Valloric/MatchTagAlways'

" CSS
Plug 'groenewege/vim-less'

" Ruby and Rails
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

" JSON
Plug 'tpope/vim-jdaddy' "json mappings
