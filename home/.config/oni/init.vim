"     /\   | |    | |                      | |            \ \    / /        (_)
"    /  \  | | ___| | _____  __ _ _ __   __| | __ _ _ __   \ \  / /   _  ___ _  ___
"   / /\ \ | |/ _ \ |/ / __|/ _` | '_ \ / _` |/ _` | '__|   \ \/ / | | |/ __| |/ __|
"  / ____ \| |  __/   <\__ \ (_| | | | | (_| | (_| | |       \  /| |_| | (__| | (__
" /_/    \_\_|\___|_|\_\___/\__,_|_| |_|\__,_|\__,_|_|        \/  \__,_|\___|_|\___|
"
" Author: Aleksandar Vucic
" repo  : https://github.com/avstudio/dotfiles/

" Setup  --------------------------------------------------------------------{{{
let g:python_host_prog = $HOME. '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME. '/.pyenv/versions/neovim3/bin/python'
let g:ruby_host_prog = $HOME. '/.rbenv/shims/neovim-ruby-host'

" auto-install vim-plug
if empty(glob("$HOME/.config/nvim/autoload/plug.vim"))
    call system(expand("mkdir -p $HOME/.config/nvim/{autoload,plugged}"))
    call system(expand("git clone https://github.com/junegunn/vim-plug.git $HOME/.config/nvim/plugged/vim-plug"))
    call system(expand("ln -s ~/.config/nvim/plugged/vim-plug/plug.vim ~/.config/nvim/autoload"))
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'

" General {{{
Plug 'editorconfig/editorconfig-vim' " Conventions for vim
Plug 'tpope/vim-repeat'
" Plug 'kassio/neoterm'
" Plug 'aquach/vim-http-client'
" Plug 'Shougo/vimproc.vim', {'build' : 'make','do':':VimProcInstall'}
" Plug 'qpkorr/vim-bufkill'
"}}}

" Testing {{{
" Plug 'janko-m/vim-test'
" Plug 'tpope/vim-dispatch'
"}}}

" Vim Session {{{
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'dominickng/fzf-session.vim'
"}}}

" Navigation/Folding  {{{
Plug 'iberianpig/ranger-explorer.vim'
Plug 'rbgrouleff/bclose.vim'
" Plug 'tpope/vim-unimpaired' " Navigate throught quicklist
Plug 'Lokaltog/vim-easymotion'
" Plug 'majutsushi/tagbar'
Plug 'farmergreg/vim-lastplace'
"}}}

" Look and feel/Visual  {{{
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
"}}}

" Text {{{
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'  "Write free text
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug '$HOME/.config/nvim/plugin/vim-translator'

"" textobjects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'lucapette/vim-textobj-underscore'
Plug 'kana/vim-textobj-indent'
Plug 'whatyouhide/vim-textobj-erb'
"}}}

" Syntax {{{
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
"}}}

" Git  {{{
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim' "Browse git commits
"}}}

" Search and History {{{
Plug 'nelstrom/vim-visual-star-search'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'
"}}}

" HTML  {{{
Plug 'Valloric/MatchTagAlways'
Plug 'gorodinskiy/vim-coloresque'
Plug 'mattn/emmet-vim'
"}}}

" Javascript  {{{
Plug 'thinca/vim-textobj-function-javascript'
Plug 'inside/vim-textobj-jsxattr'
" Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
"}}}

" Ruby/Rails  {{{
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' } "Selecting ruby block
Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'jgdavey/vim-blockle', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'rlue/vim-fold-rspec'
Plug 'rorymckinley/vim-rubyhash'
"}}}

" JSON  {{{
" Plug 'tpope/vim-jdaddy' "json mappings
"}}}

" CSV  {{{
" Plug 'chrisbra/csv.vim'
"}}}

" Docker  {{{
Plug 'ekalinin/Dockerfile.vim'
"}}}
call plug#end()
filetype plugin indent on
" }}}

" System Setting  -----------------------------------------------------------{{{
let mapleader="\<Space>"
"" Copy/Paste/Cut
"if has('unnamedplus')
"set clipboard=unnamed,unnamedplus
"endif
set clipboard=unnamedplus
"if has('macunix')
"" pbcopy for OSX copy/paste
"vmap <C-x> :!pbcopy<CR>
"vmap <C-c> :w !pbcopy<CR><CR>
"endif

set autoread
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
"" Directories for swp files
call system('mkdir $HOME/.config/nvim/swap')
set directory=~/.config/nvim/swap//

" ======================== oni ===============================================
set nocompatible              " be iMproved, required
filetype off                  " required

set number
set noswapfile
set smartcase
set ignorecase

" Enable GUI mouse behavior
set mouse=a

" If using Oni's externalized statusline, hide vim's native statusline,
set noshowmode
set noruler
set laststatus=0
set noshowcmd
" ==============================================================================
"}}}

" Visual Settings -----------------------------------------------------------{{{
syntax on
set ruler
set number
"" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
    set colorcolumn=81
endif
set undofile
set undodir=~/.config/nvim/undo/
" }}}

" Folding  ------------------------------------------------------------------{{{
function! MyFoldText() " {{{
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines '
endfunction " }}}

set foldtext=MyFoldText()

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

autocmd FileType vim setlocal fdc=1
set foldlevel=99
autocmd FileType vim,zsh setlocal foldmethod=marker
autocmd FileType vim,zsh setlocal foldlevel=0

autocmd FileType html setlocal fdl=99

autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}

autocmd FileType coffee setl foldmethod=indent
autocmd FileType html setl foldmethod=expr
autocmd FileType html setl foldexpr=HTMLFolds()
autocmd FileType javascript,typescript,json,xml,ruby setl foldmethod=syntax
"}}}

" System Mappings  ----------------------------------------------------------{{{
"" Clipboard
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" cnoreabbrev W! w!
" cnoreabbrev Q! q!
" cnoreabbrev Qall! qall!
" cnoreabbrev Wq wq
" cnoreabbrev Wa wa
" cnoreabbrev wQ wq
" cnoreabbrev WQ wq
" cnoreabbrev W w
" cnoreabbrev Q q
" cnoreabbrev Qall qall

"" Escape insert mode
inoremap jj <ESC>

"" join line in insert mode
inoremap JJ <c-o>J<ESC>

"" Common in insert mode
inoremap jj <ESC>
inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>O
inoremap DD <Esc>dd
inoremap UU <Esc>u

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

vmap < <gv
vmap > >gv

"" Jumping
nnoremap Q <nop>
noremap H ^
noremap L g_
noremap ; :
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
noremap % v%

"" Clean search (highlight)
nnoremap <silent><esc> :nohl \| ccl<return><esc>

"" Search for visually hightlighted text
vnoremap <C-r> "0y<Esc>:%S/<C-r>0//gc<left><left><left>
vnoremap // y/<C-R>"<CR>

"" Diff
nnoremap <leader>dc :q<cr>:diffoff<cr>

"" Command line navigation
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Buffer navigation
nmap <leader>bn :enew<cr>
map <Tab> :bnext<cr>
map <S-Tab> :bprevious<cr>
nmap <M-W> :BD<CR>

"" Tabs navigation
map <Leader><Tab> gt<cr>
map <Leader><S-Tab> gT<cr>
nnoremap td  :tabclose<CR>
nnoremap ts  :tab split <CR>
nnoremap <silent> <S-t> :tabnew<CR>

"" Switching windows
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

"" Terminal
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <C-\><C-n><C-w>l
command! -nargs=* HT split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>
noremap <Esc><Esc> :TermClose * bd!

" Session management
nnoremap ,so :SLoad<Space>
nnoremap ,ss :Session<Space>
nnoremap ,S :Sessions<CR>
nnoremap ,ds :SDelete<Space>
nnoremap ,sc :SQuit<CR>

"}}}

" Ruby  ---------------------------------------------------------------------{{{
" let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1

" augroup vimrc-ruby
"   autocmd!
"   autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
"   autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
" augroup END

" let g:tagbar_type_ruby = {
"       \ 'kinds' : [
"       \ 'm:modules',
"       \ 'c:classes',
"       \ 'd:describes',
"       \ 'C:contexts',
"       \ 'f:methods',
"       \ 'F:singleton methods'
"       \ ]
"       \ }

" nmap <silent> ,t :TestNearest<CR>
" nmap <silent> ,tt :TestFile<CR>
" nmap <silent> ,ta :TestSuite<CR>
" nmap <silent> ,l :TestLast<CR>
" nmap <silent> ,g :TestVisit<CR>

" command! Troutes :T bundle exec rake routes
" command! Rc :T bundle exec rails c
" command! -nargs=+ Troute :T bundle exec rake routes | grep <args>
" command! Tmigrate :T bundle exec rake db:migrate
" command! Tseed :T bundle exec rake db:reset && rake db:seed_fu
"}}}

" Docker --------------------------------------------------------------------{{{
command! -nargs=+ D :T docker <args>
command! -nargs=+ Drun :T docker run  <args>
"}}}

" Javascript  ---------------------------------------------------------------{{{
" vim vue
let g:vue_disable_pre_processors=1
" autocmd BufEnter *.vue :setlocal filetype=vue
" autocmd FileType vue call SyntaxRange#Include('<script>', '</script>', 'javascript', 'NonText')
" autocmd FileType vue set filetype javascript.vue
"}}}

" Plugin Settings  ----------------------------------------------------------{{{

"" Tagbar
nmap <leader>] :TagbarToggle<CR>

"" GoogleSearch
command! -nargs=1 Google call GoogleSearch(<f-args>)
vnoremap <leader>g/ "gy<Esc> :call GoogleSearch()<CR>

"" Fugitive Git
noremap <Leader>gl :Glog<CR>
" noremap <Leader>ga :Gwrite<CR>
" noremap <Leader>ge :Gedit<CR>
" noremap <Leader>gc :Gcommit<CR>
" noremap <Leader>gsh :Gpush<CR>
" noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
" noremap <Leader>gr :Gremove<CR>

"" Open current line on GitHub
nnoremap <Leader>go :.Gbrowse<CR>

"" vim-expand-regon
vmap v  <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"" Splitjoin plugin keybinding
nmap sj :SplitjoinSplit<cr> nmap sk :SplitjoinJoin<cr>

"" EasyAlign
vmap <cr> <Plug>(EasyAlign)

"" Neoterm
let g:neoterm_default_mod = 'rightbelow'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_size = 15
let g:neoterm_open_in_all_tabs = 0
let g:neoterm_autoinsert = 1
nnoremap <silent> ,sf :TREPLSendFile<cr>
nnoremap <silent> ,sl :TREPLSendLine<cr>
vnoremap <silent> ,s  :TREPLSendSelection<cr>
nnoremap <silent> ,cl :call neoterm#clear()<cr>
nnoremap <silent> ,k  :call neoterm#kill()<cr>
nnoremap <silent> ,c  :call neoterm#close()<cr>

"" Goyo (distraction-free)
nnoremap <Leader>gg :Goyo<CR>

"" IndentLine
noremap <Leader>i :IndentLinesToggle<CR>

"" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s  <Plug>(easymotion-overwin-f)
vmap s <Plug>(easymotion-bd-f)
nmap t <Plug>(easymotion-t2)

"" vim-http-client
autocmd FileType rest map <buffer> <cr> :HTTPClientDoRequest<cr>

"" Ranger Explorer
nnoremap <silent><Leader>e :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>er :RangerOpenProjectRootDir<CR>

"NERDCommenter
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '{/*', 'rightAlt': '*/}' } }
nnoremap gc :call NERDComment(0,"toggle")<CR>
vnoremap gc :call NERDComment(0,"toggle")<CR>

let g:ft = ''
function! NERDCommenter_before()
    if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
            endif
        endif
    endif
endfunction
function! NERDCommenter_after()
    if g:ft == 'vue'
        setf vue
        let g:ft = ''
    endif
endfunction

"" vim-blockle
let g:blockle_mapping = '<leader>rb'

"" Vim Translator
let g:translate_cmd = 'trans -b -t sr-Latn+en'
vmap T   <Plug>Translate
vmap R   <Plug>TranslateReplace
command! -nargs=1 Trans call translator#translate_word(<f-args>)

"" vim-test
let test#strategy = {
            \'nearest': 'neovim',
            \'file':    'neovim',
            \'suite':   'neovim',
            \}
" let g:test#preserve_screen = 1

"" Gitgutter
let g:gitgutter_max_signs=9999

"" vim-notes
let g:notes_directories = ['~/Google\ Drive/Notes/']

"" Goyo (distraction-free)
let g:goyo_width="80%"
function! s:goyo_enter()
    set scrolloff=999
endfunction
function! s:goyo_leave()
    set scrolloff=5
endfunction

"" IndentLine
let g:indentLine_enabled = 0
let g:indentLine_color_dark = 1

"" Emmet
let g:user_emmet_expandabbr_key='<c-j>'

"" fzf-session
let g:fzf_session_path = "~/.config/nvim/session"

"" FZF
let g:fzf_session_path = "~/.config/nvim/session"
imap <c-f><c-k> <plug>(fzf-complete-word)
imap <c-f><c-f> <plug>(fzf-complete-path)
imap <c-f><c-j> <plug>(fzf-complete-file-ag)
imap <c-f><c-l> <plug>(fzf-complete-line)
nnoremap <silent><c-p> :exe 'Files' . <SID>fzf_root()<CR>
nnoremap <silent><Leader>l :Lines<CR>
" Search for word under the cursor
nnoremap <silent><leader>fl :Lines <C-r>=expand('<cword>')<CR><CR>
" nnoremap <silent><leader>// :Find <C-r>=expand('<cword>')<CR><CR>
nnoremap <silent><leader>fw :Find <C-r>=expand('<cword>')<CR><CR>
noremap <leader>f :Find<space>

" Search for visual selected text
vnoremap <silent><leader>f y:Lines <C-R><C-R>"<CR>
nnoremap <silent> <leader><cr> :Buffers<CR>
nnoremap <silent> <leader>a :Windows<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap q/ :QHist<CR>
nnoremap q: :CmdHist<CR>
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!.DS_Store"'
let g:fzf_action = {
            \ 'ctrl-q': 'wall | BD ',
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

let g:fzf_files_options =
            \ '--preview "highlight -O ansi {} --force || cat {}" '.
            \ '--bind down:preview-down,up:preview-up '.
            \ '--preview-window "right:50%:hidden" --bind "?:toggle-preview"'
command! CmdHist call fzf#vim#command_history({'down': '40'}) " Better command history with q:
command! QHist call fzf#vim#search_history({'down': '40'}) " Better search history
command! -bang -nargs=* Find
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

"" Ale
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <silent> <leader>a? :ALEDetail<cr>
nmap <Leader>ta :ALEToggle<CR>
"" Ale
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_cache_executable_check_failures = 1
let g:ale_set_highlights = 1
"let g:ale_statusline_format = ['E?%d', 'W?%d', 'OK']
" let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = '? Error'
let g:ale_echo_msg_warning_str = '? Warning'
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_completion_enabled = 0

"}}}

" Functions  ----------------------------------------------------------------{{{
function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

if !exists('s:fzf_root')
    fun! s:fzf_root()
        let path = finddir(".git", expand("%:p:h").";")
        return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
    endfun
endif

if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif

if !exists('*GoogleSearch')
    function GoogleSearch(...)
        silent! exec "!open \"http://google.com/search?q=" . (a:0 > 0 ? a:1 : @g) . "\" > /dev/null"
        redraw!
    endfunction
endif
"}}}
"
" Auto commands ------------------------------------------------------------{{{
"augroup autoindent
"au!
"autocmd BufWritePre * :normal migg=G`i
"augroup End
"}}}
