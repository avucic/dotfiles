command! -nargs=1 PassGen call PassGen('<args>')

function! PassGen(name)
    call system('ruby ~/Documents/psd.rb '.a:name . ' | pbcopy ')
endfunction
