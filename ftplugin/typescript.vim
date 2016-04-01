"add .ts to typescript file path
setlocal suffixesadd+=.ts
setlocal suffixesadd+=.tsx
setlocal commentstring=//\ %s

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=0 -buffer -complete=customlist,jsdoc#insert JsDoc call jsdoc#insert()

nnoremap <silent> <buffer> <Plug>(jsdoc) :call jsdoc#insert()<CR>
map <Space>d <plug>jsdoc<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
