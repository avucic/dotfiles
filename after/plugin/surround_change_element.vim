function! s:ChangeElement()
  execute "normal! vat\<esc>"
  call setpos('.', getpos("'<"))
  let restore = @"
  normal! yi>
  let attributes = substitute(@", '^[^ ]*', '', '')
  let @" = restore
  let dounmapb = 0
  if !maparg(">","c")
    let dounmapb = 1
    " Hide from AsNeeded
    exe "cn"."oremap > <CR>"
  endif
  let tag = input('<', '')
  if dounmapb
    silent! cunmap >
  endif
  let tag = substitute(tag, '>*$', '', '')
  exe "normal cst<" . tag . attributes . ">"
endfunction
nnoremap cse :call <SID>ChangeElement()<cr>
