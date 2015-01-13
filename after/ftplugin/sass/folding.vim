function! GetSassFold()
      if getline(v:lnum) =~ '^\s*\/\/\/.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*$'
            let my_cljnum = v:lnum
            let my_cljmax = line("$")

            while (1)
                  let my_cljnum = my_cljnum + 1
                  if my_cljnum > my_cljmax
                        return "<1"
                  endif

                  let my_cljdata = getline(my_cljnum)

                  " If we match an empty line, stop folding
                  if my_cljdata =~ '^$'
                        return "<1"
                  else
                        return "="
                  endif
            endwhile
      else
            return "="
      endif
endfunction

function! TurnOnSassFolding()
      setlocal foldexpr=GetSassFold()
      setlocal foldmethod=expr
endfunction

autocmd FileType sass call TurnOnSassFolding()
