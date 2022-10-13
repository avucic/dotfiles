" call matchadd('foo', '\[\ \]', 0, 11, {'conceal': ''})
" call matchadd('foo', '\[x\]', 0, 12, {'conceal': ''})


" Custom conceal
" syntax match todoCheckbox "\[\ \]" conceal cchar=
" syntax match todoCheckbox "\[x\]" conceal cchar=
"
" hi def link todoCheckbox Todo
"
" highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
"
" setlocal cole=1
