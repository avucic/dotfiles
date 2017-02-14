"     /\   | |    | |                      | |            \ \    / /        (_)
"    /  \  | | ___| | _____  __ _ _ __   __| | __ _ _ __   \ \  / /   _  ___ _  ___
"   / /\ \ | |/ _ \ |/ / __|/ _` | '_ \ / _` |/ _` | '__|   \ \/ / | | |/ __| |/ __|
"  / ____ \| |  __/   <\__ \ (_| | | | | (_| | (_| | |       \  /| |_| | (__| | (__
" /_/    \_\_|\___|_|\_\___/\__,_|_| |_|\__,_|\__,_|_|        \/  \__,_|\___|_|\___|
"
" Author: Aleksandar Vucic
" repo  : https://github.com/avstudio/dotfiles/
" inspiration and credits for some parts goes to: https://github.com/mhartington/dotfiles/

" General  ------------------------------------------------------------------{{{
set autoread
call system('mkdir $HOME/.config/nvim/backup')
call system('mkdir $HOME/.config/nvim/swap')
set directory=~/.config/nvim/swap//
if has('persistent_undo')
    let &undodir = expand("$HOME/.config/nvim/undo")
    set undofile
endif

set splitbelow
set splitright
set nowrap
set spell spelllang=en_us
autocmd BufWritePre * %s/\s\+$//e "remove white space
augroup terminal
    autocmd TermOpen * setlocal nospell
augroup END
"}}}

" Color, themes, etc.--------------------------------------------------------{{{

" set relativenumber number
set guifont=Monaco\ for\ Powerline\ Nerd\ Font\ Complete:h12
colorscheme  base16-twilight
if has("termguicolors")
    set termguicolors
endif
let g:terminal_color_0= "#1e1e1e" "Black
let g:terminal_color_1= "#cf6a4c" "Red
let g:terminal_color_2= "#8f9d6a" "Green
let g:terminal_color_3= "#cda869" "Yellow
let g:terminal_color_4= "#7587a6" "Blue
let g:terminal_color_5= "#9b859d" "Magenta
let g:terminal_color_6= "#afc4db" "Cyan
let g:terminal_color_7= "#c3c3c3" "white
let g:terminal_color_8= "#838184" "Bright black
let g:terminal_color_9= "#9b703f" "Bright red
let g:terminal_color_10= "#9b859c" "Bright green
let g:terminal_color_11= "#8f9d6a" "Bright yellow
let g:terminal_color_12= "#7587a6" "Bright Blue
let g:terminal_color_13= "#9b859d" "Bright Magenta
let g:terminal_color_14= "#7587a6" "Bright Cyan
let g:terminal_color_15= "#ffffff" "Bright white
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
    set colorcolumn=81
endif
" Highlight color
highlight ExtraWhitespace ctermbg=red guibg=red
highlight FoldColumn guifg=Grey
" Code formatting
au filetype xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd bufnewfile,bufread *.slim set ft=slim
autocmd bufnewfile,bufread *.svg set ft=xml
"}}}

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
" Space to toggle folds.
nnoremap <Space><Space> za
vnoremap <Space><Space> za
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

autocmd FileType html setlocal fdl=99

autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}

autocmd FileType coffee setl foldmethod=indent
autocmd FileType html setl foldmethod=expr
let g:xml_syntax_folding = 1
autocmd FileType html setl foldexpr=HTMLFolds()
autocmd FileType javascript,typescript,json,xml,ruby setl foldmethod=syntax
"}}}

" System Keymaps  -----------------------------------------------------------{{{

" Edit vim config
nmap     <Leader>nn :tabedit $MYVIMRC<CR>
nmap     <Leader>nr :so $MYVIMRC<CR>

"Jumping
nnoremap Q <nop>
noremap H ^
noremap L g_
noremap ; :
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
" inoremap <c-f> <c-x><c-f>
noremap % v%

"" Clean search (highlight)
nnoremap <esc> :noh<return><esc>

" search for visually hightlighted text
vnoremap <C-r> "0y<Esc>:%s/<C-r>0//g<left><left>
vnoremap // y/<C-R>"<CR>

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
map <Leader><Tab> gt<cr>
map <Leader><S-Tab> gT<cr>
nnoremap td  :tabclose<CR>
nnoremap ts  :tab split <CR>

" Buffer navigation
nmap <leader>bn :enew<cr>
map <Tab> :bnext<cr>
map <S-Tab> :bprevious<cr>
nmap bq :bp <BAR> bd #<CR>
nmap bl :ls<CR>
noremap <leader>c :bp\|bd #<CR>
noremap <leader>q :q<CR>

" cursor
nmap <silent> <Leader>cl <Esc>:set                  cursorline! <CR>a
nmap <silent> <Leader>cc      :set   cursorcolumn!              <CR>
nmap <silent> <Leader>cn      :set nocursorcolumn nocursorline  <CR>

" Diff
nnoremap <leader>dc :q<cr>:diffoff<cr>

" Terminal
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <C-\><C-n><C-w>l
" tnoremap <Esc><Esc> <C-\><C-n>
"}}}

" Ruby  ---------------------------------------------------------------------{{{

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>
"}}}

" Plugins  ------------------------------------------------------------------{{{
"Git
noremap <Leader>gl :Glog<CR>

" Vim Airline
let g:airline_powerline_fonts   = 1
let g:airline_theme='base16'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Nerdtree
nmap <leader>[ :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1
let g:WebDevIconsOS = 'Darwin'
let g:NERDTreeMinimalUI=1
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" Tagbar
nmap <Leader>] :TagbarToggle<CR>

" vim-expand-regon
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Undotree
" nmap <Leader>hh :UndotreeToggle<CR>

" Splitjoin plugin keybinding
nmap sj :SplitjoinSplit<cr> nmap sk :SplitjoinJoin<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_list = 1000
set completeopt=menuone,preview
let g:SuperTabClosePreviewOnPopupClose = 1 " close the preview window when you're not using it
let g:UltiSnipsExpandTrigger="<c-j>"
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete'
\]
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
" ultisnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd FileType vim set omnifunc=syntaxcomplete#Complete

" vim-notes
let g:notes_directories = ['~/Google\ Drive/Notes/']

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" EasyAlign
vmap <Enter> <Plug>(EasyAlign) " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
nmap ga <Plug>(EasyAlign) " Start interactive EasyAlign for a motion/text object (e.g. gaip)

"Neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_size = 15
nnoremap <silent> <Leader>tf :TREPLSendFile<cr>
nnoremap <silent> <Leader>ts :TREPLSend<cr>
vnoremap <silent> <Leader>ts :TREPLSend<cr>
nnoremap <silent> <Leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <Leader>tc :call neoterm#kill()<cr>
nnoremap <silent> <Leader>th :call neoterm#close()<cr>
" run set test lib
nnoremap <silent> <Leader>rt :call neoterm#test#run('all')<cr>
nnoremap <silent> <Leader>rf :call neoterm#test#run('file')<cr>
nnoremap <silent> <Leader>rn :call neoterm#test#run('current')<cr>
nnoremap <silent> <Leader>rc :T rails c<cr>

" Limelight
" let g:limelight_conceal_guifg = 'DarkGray'
" nmap <Leader>l <Plug>(Limelight)
" xmap <Leader>l <Plug>(Limelight)

" Goyo (distraction-free)
let g:goyo_width="80%"
nnoremap <Leader>g :Goyo<CR>
function! s:goyo_enter()
    set scrolloff=999
endfunction
function! s:goyo_leave()
    set scrolloff=5
endfunction

" IndentLine
let g:indentLine_enabled = 0
let g:indentLine_color_dark = 1
nmap <Leader>i :IndentLinesToggle<CR>

" Syntastic
let g:syntastic_sass_checkers=["sasslint"]
let g:syntastic_scss_checkers=["sasslint"]
let g:ruby_host_prog = '/home/rotsen/.rubies/ruby-2.3.1/bin/ruby'
let g:syntastic_svg_checkers = []

" Emmet
let g:user_emmet_expandabbr_key='<Tab>'

" Neoformat
noremap <leader><leader>f :Neoformat<CR>

" FZF
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
fun! s:fzf_root()
    let path = finddir(".git", expand("%:p:h").";")
    return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun
nnoremap <silent><c-p> :exe 'Files ' . <SID>fzf_root()<CR>
nnoremap <silent><leader>/ :Lines<CR>
nnoremap <silent><leader>// :Lines <C-r>=expand('<cword>')<CR><CR> " Search for word under the cursor
vnoremap <silent><leader>/ y:Lines <C-R><C-R>"<CR> " Search for visual selected text
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>

let g:fzf_files_options =
            \ '--preview "highlight -O ansi {} --force || cat {}" '.
            \ '--bind ctrl-d:preview-down,ctrl-u:preview-up '.
            \ '--preview-window "right:50%:hidden" --bind "?:toggle-preview"'

command! CmdHist call fzf#vim#command_history({'down': '40'}) " Better command history with q:
nnoremap q: :CmdHist<CR>
command! QHist call fzf#vim#search_history({'down': '40'}) " Better search history
nnoremap q/ :QHist<CR>

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Neoformat
noremap <leader>f :Neoformat<CR>

" Syntastic
let g:syntastic_check_on_open = 0
nnoremap <leader>se :SyntasticCheck<CR> :SyntasticToggleMode<CR>
"}}}
