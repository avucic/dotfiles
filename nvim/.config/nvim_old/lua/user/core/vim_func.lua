vim.cmd([[
  function s:WipeBuffersWithoutFiles()
      let bufs=filter(range(1, bufnr('$')), 'bufexists(v:val) && '.
                                            \'empty(getbufvar(v:val, "&buftype")) && '.
                                            \'!filereadable(bufname(v:val))')
      if !empty(bufs)
          execute 'bwipeout' join(bufs)
      endif
  endfunction
  command BWnex call s:WipeBuffersWithoutFiles()
      ]])
