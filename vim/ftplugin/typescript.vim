let s:cpo_save = &cpo
set cpo-=C

setlocal commentstring=//\ %s

" Set 'formatoptions' to break comment lines but not other lines,
" " and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions-=t formatoptions+=croql

" setlocal foldmethod=syntax

let &cpo = s:cpo_save
unlet s:cpo_save

function! TsIncludeExpr(file)
  if (filereadable(a:file))
    return l:file
  else
    let l:file2=substitute(a:file,'$','/index.ts','g')
    return l:file2
  endif
endfunction

set path+=./node_modules/**,node_modules/**
set include=import\_s.\\zs[^'\"]*\\ze
set includeexpr=TsIncludeExpr(v:fname)
set suffixesadd=.ts

command! -nargs=0 -buffer -complete=customlist,jsdoc#insert JsDoc call jsdoc#insert()

nnoremap <silent> <buffer> <Plug>(jsdoc) :call jsdoc#insert()<CR>
map <Space>d <plug>jsdoc<CR>
