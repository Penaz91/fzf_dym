"This file is part of the FZF-DYM Project.
"Copyright © 2021, Daniele Penazzo. All Rights Reserved.
"The use of this code is governed by the MIT license attached.
"See the LICENSE file for the full license.

"Created on: 2021-07-24

"Author: Penaz

" Normal double-loading skip
if exists("g:loaded_fzf_dym")
    finish
endif

let g:loaded_fzf_dym = 1

if !get(g:, "loaded_fzf")
    echohl WarningMsg | echom "FZF-DYM: FZF is not loaded, please check your configuration" | echohl None
    finish
endif

augroup fzf_dym
    autocmd BufNewFile * call fzf_dym#didyoumean()
augroup end
