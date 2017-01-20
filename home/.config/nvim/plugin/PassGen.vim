command! -nargs=1 PassGen call PassGen('<args>')

function! PassGen(name)
    echo system('ruby ~/Documents/psd.rb '.a:name)
endfunction
