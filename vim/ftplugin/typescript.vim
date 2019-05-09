let g:LanguageClient_diagnosticsEnable=0

let s:cpo_save = &cpo
set cpo-=C

setlocal commentstring=//\ %s

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
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

nnoremap <silent> <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <buffer> gvd :vs<CR>:call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <buffer> gsd :sp<CR>:call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <buffer> <Space>yt :call LanguageClient#textDocument_hover()<CR>

set shiftwidth=2  " Use indents of 2 spaces
set tabstop=2     " An indentation every four columns
set softtabstop=2 " Let backspace delete indent
set expandtab     " Spaces instead of tabs

let b:ale_fixers = ['prettier']
let g:ale_linters.typescript = ['eslint', 'tsserver', 'jscs', 'jshint', 'standard', 'xo']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%% code%]'
let g:ale_typescript_prettier_eslint_options = '--single-quote --trailing-comma all'
let g:ale_typescript_prettier_options = '--single-quote --trailing-comma all'
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 0
let b:color_column = 80
