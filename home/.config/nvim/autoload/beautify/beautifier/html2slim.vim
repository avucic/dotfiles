let s:source = {
            \ 'hooks' : {},
            \ 'option' : '',
            \ }
function! beautify#beautifier#html2slim#define() "{{{
    if !exists('s:html2slim')
        let s:html2slim = copy(s:source)
        let s:html2slim.name = 'html2slim'

        let s:erb2slim  = copy(s:source)
        let s:erb2slim.name = 'erb2slim'
        let s:erb2slim.option = '--erb'
    endif

    return [s:html2slim, s:erb2slim]
endfunction"}}}

let g:beautify#beautifier#html2slim#bin =
            \ get(g:, 'beautify#beautifier#html2slim#bin', 'html2slim')

function! s:system(commands) "{{{
    return system(join(a:commands), ' ')
endfunction"}}}

function! s:source.beautify(context) "{{{
    let temp_file = a:context.get_tempfile()
    let temp_file2 = a:context.get_tempfile()
    let option = self.option
    call s:system([g:beautify#beautifier#html2slim#bin, temp_file,temp_file2,option])
    return join(readfile(temp_file2),"\n")
endfunction"}}}

function! s:source.available() "{{{
    if executable(g:beautify#beautifier#html2slim#bin)
        return 1
    else
        return 'gem install html2slim'
    endif
endfunction"}}}
