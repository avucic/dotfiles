" call matchadd('foo', '\[\ \]', 0, 11, {'conceal': ''})
" call matchadd('MarkdownTag', '#tag', 0, 12, {'conceal': ''})


" Custom conceal
" syntax match todoCheckbox "\[\ \]" conceal cchar=
" syntax match todoCheckbox "\[x\]" conceal cchar=
" syntax match todoCheckbox "*" conceal cchar=◉

" highlight todoCheckbox   ctermfg=cyan guifg=#00ffff
" highlight todoCheckbox ctermfg=red  guifg=#ff0000

"
" hi def link todoCheckbox Todo
"
" highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
"
" setlocal cole=1
" syn match MarkdownTag '#idea'
" " hi MarkdownTag ctermfg=darkgreen
" hi def link MarkdownTag SpecialComment
