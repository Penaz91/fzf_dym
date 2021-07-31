"This file is part of the FZF-DYM Project.
"Copyright © 2021, Daniele Penazzo. All Rights Reserved.
"The use of this code is governed by the MIT license attached.
"See the LICENSE file for the full license.

"Created on: 2021-07-31

"Author: Penaz

function! s:remove_swapfile(matched_files)
    silent! redir => swapfile
        silent swapname
    redir END
    let swapfile = fnamemodify(swapfile[1:], ':p')

    return filter(a:matched_files, 'fnamemodify(v:val, ":p") != swapfile')
endfunction


function! fzf_dym#didyoumean()
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
