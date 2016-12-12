let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_show_argument_hints = 1
let g:tern_show_signature_in_pum = 1

call deoplete#enable()

function! FlowGetType()
  let pos = fnameescape(expand('%')) . ' ' . line('.') . ' ' .col('.')
  let cmd = 'flow type-at-pos ' . pos
  let output = 'FlowType: ' . system(cmd)
  let output_trimmed = substitute(output, '\n$', '', '')
  echo output_trimmed
endfunction

function! FlowInit()
py << EOP
current = vim.current
buf = current.buffer;
first_line = buf[0]
if first_line == '// @flow' or first_line == '/* @flow */':
  print('already flow typed')
else:
  buf.append(['// @flow', ''], 0)
EOP
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

let g:react_lifecycle_list = [
  \ 'Mounting   | constructor()                                            | called before render, initialize state',
  \ 'Mounting   | componentWillMount()                                     | only lifecycle called on server, state will not trigger',
  \ 'Mounting   | componentDidMount(component)                             | dom node init, network, state will trigger',
  \ 'Updating   | componentWillReceiveProps(nextProps, nextContext)        | setState based on prop changes',
  \ 'Updating   | shouldComponentUpdate(nextProps, nextState, nextContext) | force component to not update',
  \ 'Updating   | componentWillUpdate(nextProps, nextState, nextContext)   | before render when new props or state. Pre-update prep. Not state on props',
  \ 'Updating   | render()                                                 | required and returns ReactElement or null',
  \ 'Updating   | componentDidUpdate(prevProps, prevState, nextContext)    | post update dom etc.',
  \ 'Unmounting | componentWillUnmount()                                   | clean up, request cancel, timers etc.'
  \ ]

function! ReactLifecycleSync(lines)
  let [ item ] = a:lines
py << EOP
import re
item = vim.eval('item')
vim_input = vim.eval('input(item)')
EOP
endfunction

function! ReactLifecyclePicker()
  return fzf#run(extend({
    \ 'source': g:react_lifecycle_list,
    \ 'sink*': function('ReactLifecycleSync'),
    \ 'options': '+m --ansi --prompt="Life> " --header "React Lifecycles"'
    \ }, g:VimaxFzfLayout))
endfunction
