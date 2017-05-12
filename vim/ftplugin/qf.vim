let s:save_cpo = &cpo
set cpo&vim

let b:undo_ftplugin = "setl fo< com< ofu<"

" text wrapping is pretty much useless in the quickfix window
setlocal nowrap

" relative line numbers don't make much sense either
" but absolute numbers do
setlocal norelativenumber
setlocal number

" we don't want quickfix buffers to pop up when doing :bn or :bp
set nobuflisted

" are we in a location list or a quickfix list?
let b:isLoc = len(getloclist(0)) > 0 ? 1 : 0

" open entry in a new horizontal window
nnoremap <buffer> s <C-w><CR>
" open entry in a new vertical window.
nnoremap <buffer> v <C-w><CR><C-w>L<C-w>p<C-w>J<C-w>p
" open entry in a new tab.
nnoremap <buffer> t <C-w><CR><C-w>T
" open entry and come back
nnoremap <buffer> o <CR><C-w>p
" open entry and close the location/quickfix window.
nnoremap <buffer> w :call ToggleWrap()<CR>
if b:isLoc == 1
    nnoremap <buffer> c <CR>:lclose<CR>
else
    nnoremap <buffer> c <CR>:cclose<CR>
endif

let &cpo = s:save_cpo
