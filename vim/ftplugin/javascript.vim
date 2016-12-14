let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_show_argument_hints = 1
let g:tern_show_signature_in_pum = 1

call deoplete#enable()

function! FlowGetType()
  py3file ~/repo/dotfiles/vim/flow-tools/get-type.py
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

nnoremap <silent> <Space>yt :TernType<CR>
nnoremap <silent> <Space>yg :TernDef<CR>
nnoremap <silent> <Space>yv :TernDefSplit<CR>
nnoremap <silent> <Space>yd :TernDoc<CR>
nnoremap <silent> <Space>yr :TernRefs<CR>
nnoremap <silent> <Space>yn :TernRename<CR>
nnoremap <silent> <Space>ya :JsDoc<CR>
nnoremap <silent> <Space>yf :call FlowGetType()<CR>
nnoremap <silent> <Space>yi :call FlowInit()<CR>

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
