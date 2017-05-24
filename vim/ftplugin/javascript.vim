let g:flow#flowpath = 'flow'

function! FlowGetType()
  if has('python3')
    py3file ~/repo/dotfiles/vim/flow-tools/get-type.py
  else
    let cmd = g:flow#flowpath.' type-at-pos '.line('.').' '.col('.')
    let buffer_contents = join(getline(1,'$'), "\n")
    let output = 'FlowType: '.system(cmd, buffer_contents)
    let output = substitute(output, '\n$', '', '')
    let g:last_flow_type = output
    echo output
  endif
endfunction
command! FlowGetType call FlowGetType()

function! FlowInit()
python << endpython
import vim
current = vim.current
buf = current.buffer;
first_line = buf[0]
if first_line == '// @flow' or first_line == '/* @flow */':
  print('already flow typed')
else:
  buf.append(['// @flow', ''], 0)
endpython
endfunction

nnoremap <silent> <buffer> <Space>yt :TernType<CR>
nnoremap <silent> <buffer> <Space>yg :TernDef<CR>
nnoremap <silent> <buffer> <Space>yv :TernDefSplit<CR>
nnoremap <silent> <buffer> <Space>yd :TernDoc<CR>
nnoremap <silent> <buffer> <Space>yr :TernRefs<CR>
nnoremap <silent> <buffer> <Space>yn :TernRename<CR>
nnoremap <silent> <buffer> <Space>ya :JsDoc<CR>
nnoremap <silent> <buffer> <Space>yf :call FlowGetType()<CR>
nnoremap <silent> <buffer> <Space>yi :call FlowInit()<CR>

let g:neomake_javascript_enabled_makers = ['eslint', 'flow']

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
    \ }, g:VimaxFzfLayout))
endfunction

command! Life call ReactLifecyclePicker()
