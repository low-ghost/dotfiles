let g:flow#flowpath = 'flow'

if !exists("b:flow_init")
python << endpython
import vim
current = vim.current
buf = current.buffer;
first_line = buf[0]
if first_line == '// @flow' or first_line == '/* @flow */':
  vim.command("let b:flow_init = 1")
endpython
endif

"Capital represents alternate
if exists("b:flow_init")
  nnoremap <silent> <buffer> <Space>yt :FlowGetType<CR>
  nnoremap <silent> <buffer> <Space>yT :BothType<CR>

  nnoremap <silent> <buffer> <Space>yg :FlowJumpTo<CR>
  nnoremap <silent> <buffer> <Space>yG :TernDef<CR>
else
  nnoremap <silent> <buffer> <Space>yt :TernType<CR>
  nnoremap <silent> <buffer> <Space>yg :TernDef<CR>
  nnoremap <silent> <buffer> <Space>yv :TernDefSplit<CR>
endif

nnoremap <silent> <buffer> <Space>yd :TernDoc<CR>
nnoremap <silent> <buffer> <Space>yr :TernRefs<CR>
nnoremap <silent> <buffer> <Space>yn :TernRename<CR>
nnoremap <silent> <buffer> <Space>ya :JsDoc<CR>
nnoremap <silent> <buffer> <Space>yi :FlowInit<CR>

nnoremap <silent> <buffer> <Space>ft :EditJavascriptTest<cr>

if get(g:, 'javascript_funcs_loaded')
  finish
endif
let g:javascript_funcs_loaded = 1

"function! StrTrim(txt)
  "return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
"endfunction

let g:neomake_javascript_enabled_makers = []
"let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

let g:neomake_javascript_flow_maker = {
  \ 'exe': 'sh',
  \ 'args': ['-c', g:flow#flowpath . ' check --json 2> /dev/null | flow-vim-quickfix'],
  \ 'errorformat': '%E%f:%l:%c\,%n: %m',
  \ 'cwd': '%:p:h' 
  \ }

let g:neomake_javascript_eslint_maker = {
  \ 'exe': substitute(system('PATH=$(npm bin):$PATH && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', ''),
  \ 'args': ['-f', 'compact'],
  \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
  \ }
let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + ['flow', 'eslint']

function! FlowGetType()
  "if has('python3')
    "py3file ~/repo/dotfiles/vim/flow-tools/get-type.py
  "else
    let cmd = g:flow#flowpath.' type-at-pos '.line('.').' '.col('.')
    let buffer_contents = join(getline(1,'$'), "\n")
    let output = 'FlowType: '.system(cmd, buffer_contents)
    let output = substitute(output, '\n$', '', '')
    let g:last_flow_type = output
    echo output
  "endif
endfunction
command! FlowGetType call FlowGetType()

function! BothType()
  :echo "Flow:"
  :FlowGetType
  :echo "\nTern: "
  :TernType
endfunction
command! BothType call BothType()

function! FlowJumpTo()
  let cmd = g:flow#flowpath.' get-def '.line('.').' '.col('.')
  let buffer_contents = join(getline(1,'$'), "\n")
  let output = system(cmd, buffer_contents)
  let output = substitute(output, '\n$', '', '')
  let parts = split(output, ',')
  if len(parts) < 2
    echo 'cannot find definition'
    return
  endif
  let line_parts = split(parts[0], ':')
  if len(line_parts) != 3
    echo 'cannot find definition'
    return
  endif
  let [file, line, col] = split(parts[0], ':')
  if len(file) > 0 && file != '-'
    execute 'edit' file
  endif
  call cursor(line, col)
  let current_word = expand("<cword>")
  if current_word == "require"
    call FlowJumpTo()
  endif
endfunction
command! FlowJumpTo call FlowJumpTo()

function! FlowInit()
python << endpython
import vim
current = vim.current
buf = current.buffer;
first_line = buf[0]
if first_line == '// @flow' or first_line == '/* @flow */':
  print('already flow typed')
else:
  buf.append(['// @flow'], 0)
endpython
call filetype#source_ft_plugin()
endfunction
command! FlowInit call FlowInit()

let g:react_lifecycle_list = {
  \ 'Mounting   | constructor(props, context)                              | called before render, initialize state'
  \   : 'constructor',
  \ 'Mounting   | componentWillMount()                                     | only lifecycle called on server, state will not trigger'
  \   : 'componentWillMount',
  \ 'Mounting   | componentDidMount(component)                             | dom node init, network, state will trigger'
  \   : 'componentDidMount',
  \ 'Updating   | componentWillReceiveProps(nextProps, nextContext)        | setState based on prop changes'
  \   : 'componentWillReceiveProps',
  \ 'Updating   | shouldComponentUpdate(nextProps, nextState, nextContext) | force component to not update'
  \   : 'shouldComponentUpdate',
  \ 'Updating   | componentWillUpdate(nextProps, nextState, nextContext)   | before render when new props or state. Pre-update prep. Not state on props'
  \   : 'componentWillUpdate',
  \ 'Updating   | render()                                                 | required and returns ReactElement or null'
  \   : 'render',
  \ 'Updating   | componentDidUpdate(prevProps, prevState, nextContext)    | post update dom etc.'
  \   : 'componentDidUpdate',
  \ 'Unmounting | componentWillUnmount()                                   | clean up, request cancel, timers etc.'
  \   : 'componentWillUnmount',
  \ }

function! ReactLifecycleSync(lines)
  let [ item ] = a:lines
  let snip = g:react_lifecycle_list[item]
  call append(line('.'), snip)
  call feedkeys("jA\<C-r>=UltiSnips#ExpandSnippet()\<CR>")
endfunction

function! ReactLifecyclePicker()
  return fzf#run(extend({
    \ 'source': keys(g:react_lifecycle_list),
    \ 'sink*': function('ReactLifecycleSync'),
    \ 'options': '--ansi --prompt="Life> " --header "React Lifecycles"'
    \ }, g:vimax_fzf_layout))
endfunction
command! Life call ReactLifecyclePicker()

"follows pattern of file.js and __tests__/file.spec.js
function! EditJavascriptTest()
  let l:file_name = expand('%')
  let l:full_path = expand('%:p:h')
  if l:file_name =~# '\.spec'
    let l:alt_file_name = substitute(l:file_name, '\.spec\.js$', '.js', '')
    execute 'e ' . l:full_path . '/../' . l:alt_file_name
  else
    let l:alt_file_name = substitute(l:file_name, '\.js$', '.spec.js', '')
    execute "e " . l:full_path . '/__tests__/' . l:alt_file_name
  endif
endfunction
command! EditJavascriptTest call EditJavascriptTest()

function! Pretty()
  silent !npm run prettier > /dev/null
endfunction
command! Pretty call Pretty()

let g:color_column = 80
