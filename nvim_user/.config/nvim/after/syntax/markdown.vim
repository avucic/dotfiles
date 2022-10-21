hi MyStrikethrough gui=strikethrough
call matchadd('MyStrikethrough', '\~\~\zs.\+\ze\~\~')
call matchadd('Conceal',  '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
call matchadd('Conceal',  '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})

call matchadd('Conceal',  '\[\ \]', 10, -1, {'conceal':''})
call matchadd('Conceal',  '\[x\]', 10, -1, {'conceal':''})
call matchadd('Conceal',  '\[-\]', 10, -1, {'conceal':'☒'})
call matchadd('Conceal',  '\[\.\]', 10, -1, {'conceal':'⊡'})
call matchadd('Conceal',  '\[o\]', 10, -1, {'conceal':'⬕'})
call matchadd('@MarkdownTag',  '\v#([a-zA-Z_-]\/?)+')


sign define codeblock linehl=@MarkdownCodeBlockBG

function! MarkdownBlocks()
    let l:continue = 0
    execute "sign unplace * file=".expand("%")

    " iterate through each line in the buffer
    for l:lnum in range(1, len(getline(1, "$")))
        " detect the start fo a code block
        if getline(l:lnum) =~ "^```.*$" || l:continue
            " continue placing signs, until the block stops
            let l:continue = 1
            " place sign
            execute "sign place ".l:lnum." line=".l:lnum." name=codeblock file=".expand("%")
            " stop placing signs
            if getline(l:lnum) =~ "^```$"
                let l:continue = 0
            endif
        endif
    endfor
endfunction

" Use signs to highlight code blocks
" Set signs on loading the file, leaving insert mode, and after writing it
" call MarkdownBlocks()
" au InsertLeave *.md call MarkdownBlocks()
" au BufEnter *.md call MarkdownBlocks()
" au BufWritePost *.md call MarkdownBlocks()
" call matchadd('Conceal',  '\*', 10, -1, {'conceal':'◉'})
" call matchadd('Conceal',  '[-*+]{1}', 10, -1, {'conceal':'◉'})


" call matchadd('Conceal',  '\v(\s+)?(-|\*)+(\s+)?', 10, -1, {'conceal':'•'})


" syn match  mkdListItem    "^\s*[-*+]\s\+"   contains=mkdListTab,mkdListBullet2
" syn match  mkdListItem    "^\s*\d\+\.\s\+"  contains=mkdListTab
" syn match  mkdListTab     "^\s*\*"          contained contains=mkdListBullet1
" syn match  mkdListBullet1 "\*"              contained conceal cchar=•
" syn match  mkdListBullet2 "[-*+]"           contained conceal cchar=•

" call matchadd('mkdListItem   ', "^\s*[-*+]\s\+"   contains=mkdListTab,mkdListBullet2
" call matchadd('mkdListItem   ', "^\s*\d\+\.\s\+"  contains=mkdListTab
" call matchadd('mkdListTab    ', "^\s*\*"          contained contains=mkdListBullet1
" call matchadd('mkdListBullet1', "\*"              contained conceal cchar=•
" call matchadd('mkdListBullet2', "[-*+]"           contained conceal cchar=•




" call matchadd('Conceal',  '^\s*[-*+]\s\+', 10, -1, {'conceal':'◉ '})

" call matchadd('Conceal',  '\[o\]', 10, -1, {'conceal':'⬕'})

" syn match  mkdListItem                                 "^\s*[-*+]\s\+"                                                                       contains=mkdListTab,mkdListBullet2
" syn match  mkdListItem                                 "^\s*\d\+\.\s\+"                                                                      contains=mkdListTab
" syn match  mkdListTab                                  "^\s*\*"                                                                              contained contains=mkdListBullet1
" syn match  mkdListBullet1                              "\*"                                                                                  contained conceal cchar=•
" syn match  mkdListBullet2                              "[-*+]"                                                                               contained conceal cchar=•
" syn region mkdNonListItemBlock                         start="\n\(\_^\_$\|\s\{4,}[^ ]\|\t+[^\t]\)\@!" end="^\(\s*\([-*+]\|\d\+\.\)\s\+\)\@=" contains=@mkdNonListItem,@Spell


" call matchadd('foo', '\[\ \]', 0, 11, {'conceal': ''})
" call matchadd('MarkdownTag', '#tag', 0, 12, {'conceal': ''})


" setlocal cole=1
" syn match MarkdownTag '#idea'
" " hi MarkdownTag ctermfg=darkgreen
" hi def link MarkdownTag SpecialComment

" call matchadd('Conceal',  '^\s*\*', 10, -1, {'conceal':'◉ '})

" ; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
" ; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
" ; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=☒
" ; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
" ; " syntax match TodoCheckbox '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕
" call matchadd('MarkdownTag', '#tag', 0, 12, {'conceal': ''})
