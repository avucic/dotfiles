function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" https://gist.github.com/mkhoeini/e113eb08275638d739dbee65e649679d
function! customspacevim#before() abort
  let g:vimwiki_list = [{'path': '~/Work/Wiki/', 'path_html': '~/Work/Wiki/html/'}]
endfunction

function! customspacevim#after() abort
  set showtabline=0
  set diffopt+=vertical
  set modifiable
  set autoindent
  set autochdir&
  set cmdheight=2
  " Don't let Vim's "Found a swap file" message block input
  set shortmess=A
  " set updatetime=300

  let g:test#strategy = "neovim"
  let g:neoformat_eelixir_htmlbeautify = {
        \ 'exe': 'html-beautify',
        \ 'args': ['--indent-size ' .shiftwidth()],
        \ 'stdin': 1,
        \ }

  let g:neoformat_enabled_eelixir = ['htmlbeautify']

  "" ExMode
  map q: <Nop>
  nnoremap Q <nop>

  "" Clipboard
  noremap YY "+y<CR>
  inoremap <leader>p "+gP<CR>
  noremap XX "+x<CR>
  "" jumping
  noremap H ^
  noremap L g_

  "" Escape insert mode
  inoremap jj <ESC>

  "" Common in insert mode
  inoremap jj <ESC>
  inoremap II <Esc>I
  inoremap AA <Esc>A
  inoremap OO <Esc>O

  " inoremap  <Esc>


  " Spacevim
  nnoremap <silent> <space>fve :e ~/.Spacevim.d/autoload/customspacevim.vim <CR>
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " fix for auto pairs
  " let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
  " inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>

  " Coc
  let g:coc_global_extensions = [
        \ 'coc-emoji',
        \ 'coc-json',
        \ 'coc-neosnippet',
        \ 'coc-syntax',
        \ 'coc-omni',
        \ 'coc-tsserver',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-solargraph',
        \ 'coc-rls',
        \ 'coc-yaml',
        \ 'coc-highlight',
        \ 'coc-snippets',
        \ 'coc-lists',
        \ 'coc-yank',
        \ 'coc-tailwindcss',
        \ 'coc-prettier',
        \ 'coc-eslint',
        \ 'coc-elixir',
        \ 'coc-fzf-preview'
        \ ]

  nnoremap <silent> <space>ld :call <SID>show_documentation()<CR>

  "" Elixir
  let g:mix_format_on_save = 1

  " Vimspector
  let g:vimspector_enable_mappings = 'HUMAN'
  nnoremap <silent> <space>dB :call vimspector#ClearBreakpoints()<CR>
  nnoremap <silent> <space>dc :call vimspector#Continue()<CR>
  nnoremap <silent> <space>db :call vimspector#ToggleBreakpoint()<CR>
  nnoremap <silent> <space>dl :call vimspector#Launch()<CR>
  nnoremap <silent> <space>do :call vimspector#StepOver()<CR>
  nnoremap <silent> <space>di :call vimspector#StepInto()<CR>
  nnoremap <silent> <space>dO :call vimspector#StepOut()<CR>
  nnoremap <silent> <space>dk :call vimspector#Reset()<CR>
  nnoremap <silent> <space>dr :call vimspector#Restart()<CR>
  nnoremap <expr> <space>dee ':VimspectorEval '.expand('<cword>').'<CR>'
  nnoremap <space>de :VimspectorEval 

  " CtrsSpace
  let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
  let g:CtrlSpaceSaveWorkspaceOnExit = 1
  " vim-zoom
  nmap <space>wm <Plug>(zoom-toggle)

  "" fzf-preview
  let g:fzf_preview_command = 'bat --theme=base16 --color=always  {-1}'
  let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading -w .'

  nnoremap <silent> <c-p> :CocCommand fzf-preview.GitFiles<CR>
  nnoremap <silent> <space>ff :CocCommand fzf-preview.ProjectFiles<CR>
  nnoremap <silent> <space>fr :CocCommand fzf-preview.ProjectMruFiles<CR>
  nnoremap <silent> <space>bb :CocCommand fzf-preview.Buffers<CR>
  nnoremap <silent> <space>yh :CocCommand fzf-preview.Yankround<CR>
  nnoremap <silent> <space>s/ :CocCommand fzf-preview.ProjectGrep<CR>

  "vista
  let g:vista#executives = ['coc']
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#enable_icon = 0
  let g:vista_sidebar_position = 'vertical topleft'
  " let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  nnoremap <silent> <space>fT :Vista!!<CR>

  " vim-fugitive
  let g:fugitive_pty = 0 " fix hasky linter on commit
  " Fugitive Conflict Resolution
  nnoremap dol :diffget //2<CR>
  nnoremap dor :diffget //3<CR>
  nnoremap <silent> <space>gl :Glog -10 -- %<CR>
  " Blamer
  call BlamerShow()
endfunction
