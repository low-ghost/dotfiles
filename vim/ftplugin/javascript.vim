" let g:flow#flowpath = 'flow'

" if !exists("b:flow_init")
" python << endpython
" import vim
" current = vim.current
" buf = current.buffer;
" first_line = buf[0]
" if first_line == '// @flow' or first_line == '/* @flow */':
"   vim.command("let b:flow_init = 1")
" endpython
" endif

syntax match jsEqual "===" conceal cchar=≡ containedin=jsOperator
syntax match jsNotEqual "!==" conceal cchar=≢ containedin=jsOperator
syntax match jsGtEq ">=" conceal cchar=≥ containedin=jsOperator
syntax match jsLtEq "<=" conceal cchar=≤ containedin=jsOperator
syntax match jsFlow "flow" conceal cchar=λ containedin=jsFuncCall
syntax match jsAndAnd "&&" conceal cchar=∧ containedin=jsOperator
syntax match jsAndAnd "||" conceal cchar=‖ containedin=jsOperator
hi! link Conceal jsStorageClass

let g:javascript_conceal_NaN = "ℕ"
let g:javascript_conceal_super = "Ω"
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_this = "@"
let g:javascript_plugin_flow = 1

set conceallevel=1

command! Pretty call javascript#pretty()
command! Life call javascript#react_lifecycle_picker()
command! FlowInit call javascript#flow_init()
command! EditJavascriptTest call javascript#edit_javascript_test()

"Capital represents alternate
"if exists("b:flow_init")
" nnoremap <silent> <buffer> <Space>yt :FlowGetType<CR>
nnoremap <silent> <buffer> <Space>yt :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <buffer> <Space>yT :BothType<CR>

" nnoremap <silent> <buffer> <Space>yg :FlowJumpTo<CR>
nnoremap <silent> <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <buffer> gvd :vs<CR>:call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <buffer> gsd :sp<CR>:call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <buffer> gD :TernDef<CR>


"else
  "nnoremap <silent> <buffer> <Space>yt :TernType<CR>
  "nnoremap <silent> <buffer> <Space>yg :TernDef<CR>
  "nnoremap <silent> <buffer> <Space>yv :TernDefSplit<CR>
"endif

nnoremap <silent> <buffer> <Space>yd :TernDoc<CR>
nnoremap <silent> <buffer> <Space>yr :TernRefs<CR>
nnoremap <silent> <buffer> <Space>yn :TernRename<CR>
nnoremap <silent> <buffer> <Space>ya :JsDoc<CR>
nnoremap <silent> <buffer> <Space>yi :FlowInit<CR>

nnoremap <silent> <buffer> <Space>ft :call javascript#edit_javascript_test('e')<cr>
nnoremap <silent> <buffer> <Space>fvt :call javascript#edit_javascript_test('v')<cr>
nnoremap <silent> <buffer> <Space>fst :call javascript#edit_javascript_test('s')<cr>


let b:ale_fixers = ['prettier']
let g:ale_javascript_prettier_eslint_options = '--single-quote --trailing-comma all'
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'
let g:ale_fix_on_save = 1
let b:color_column = 80

" if get(b:, 'javascript_funcs_loaded')
"   finish
" endif

"function! StrTrim(txt)
  "return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
"endfunction

"let g:neomake_javascript_enabled_makers = []
""let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

"let g:neomake_javascript_flow_maker = {
  "\ 'exe': 'sh',
  "\ 'args': ['-c', g:flow#flowpath . ' check --json 2> /dev/null | flow-vim-quickfix'],
  "\ 'errorformat': '%E%f:%l:%c\,%n: %m',
  "\ 'cwd': '%:p:h' 
  "\ }

"let g:neomake_javascript_eslint_maker = {
  "\ 'exe': substitute(system('PATH=$(npm bin):$PATH && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', ''),
  "\ 'args': ['-f', 'compact'],
  "\ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    "\ '%W%f: line %l\, col %c\, Warning - %m'
  "\ }
"let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + ['flow', 'eslint']

"function! FlowGetType()
"  "if has('python3')
"    "py3file ~/repo/dotfiles/vim/flow-tools/get-type.py
"  "else
"    let cmd = g:flow#flowpath.' type-at-pos '.line('.').' '.col('.')
"    let buffer_contents = join(getline(1,'$'), "\n")
"    let output = 'FlowType: '.system(cmd, buffer_contents)
"    let output = substitute(output, '\n$', '', '')
"    let g:last_flow_type = output
"    echo output
"  "endif
"endfunction
"command! FlowGetType call FlowGetType()

"function! BothType()
"  :echo "Flow:"
"  :FlowGetType
"  :echo "\nTern: "
"  :TernType
"endfunction
"command! BothType call BothType()

"function! FlowJumpTo()
"  let cmd = g:flow#flowpath.' get-def '.line('.').' '.col('.')
"  let buffer_contents = join(getline(1,'$'), "\n")
"  let output = system(cmd, buffer_contents)
"  let output = substitute(output, '\n$', '', '')
"  let parts = split(output, ',')
"  if len(parts) < 2
"    echo 'cannot find definition'
"    return
"  endif
"  let line_parts = split(parts[0], ':')
"  if len(line_parts) != 3
"    echo 'cannot find definition'
"    return
"  endif
"  let [file, line, col] = split(parts[0], ':')
"  if len(file) > 0 && file != '-'
"    execute 'edit' file
"  endif
"  call cursor(line, col)
"  let current_word = expand("<cword>")
"  if current_word == "require"
"    call FlowJumpTo()
"  endif
"endfunction
"command! FlowJumpTo call FlowJumpTo()

" let b:javascript_funcs_loaded = 1

set completefunc=LanguageClient#complete
