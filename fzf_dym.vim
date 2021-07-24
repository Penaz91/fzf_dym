" FZF-DYM
" A simple plugin that presents a list of similar files in case
" you didn't type the whole name
"
" Last Change: 2021 Jul 24
" Maintainer: Penaz
" License: MIT

" Normal double-loading skip
if exists("g:loaded_fzf_dym")
    finish
endif

let g:loaded_fzf_dym = 1

function! s:remove_swapfile(matched_files)
    silent! redir => swapfile
        silent swapname
    redir END
    let swapfile = fnamemodify(swapfile[1:], ':p')

    return filter(a:matched_files, 'fnamemodify(v:val, ":p") != swapfile')
endfunction


function! s:didyoumean()
    if filereadable(expand("%"))
        " Another BufNewFile event might have handled this already.
        return
    endif

    try
        let matching_files = split(glob(expand("%")."*", 0), '\n')
        if !len(matching_files)
            let matching_files = split(glob(expand("%")."*", 1), '\n')
        endif
        let matching_files = s:remove_swapfile(matching_files)
        if empty(matching_files)
            return
        endif
    catch
        return
    endtry

    function! s:DYMHandle(item)
        let empty_buffer_nr = bufnr("%")
        execute ":e " . a:item
        execute ":silent bd " . empty_buffer_nr
    endfunction

    call fzf#run(fzf#wrap({
                \ 'source': matching_files,
                \ 'sink': function('s:DYMHandle'),
                \ 'options': ['--prompt', 'Did you mean: ', '--preview', 'bat --color always {}'],
                \ }, v:true))
endfunction

autocmd BufNewFile * call s:didyoumean()
