function! javascript#flow_init()
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

function! javascript#react_lifecycle_sync(lines)
  let [ item ] = a:lines
  let snip = g:react_lifecycle_list[item]
  call append(line('.'), snip)
  call feedkeys("jA\<C-r>=UltiSnips#ExpandSnippet()\<CR>")
endfunction

function! javascript#react_lifecycle_picker()
  return fzf#run(extend({
    \ 'source': keys(g:react_lifecycle_list),
    \ 'sink*': function('ReactLifecycleSync'),
    \ 'options': '--ansi --prompt="Life> " --header "React Lifecycles"'
    \ }, g:vimax_fzf_layout))
endfunction

"follows pattern of file.js and __tests__/file.spec.js
function! javascript#edit_javascript_test(direction)
  let l:edit = 'e'
  if a:direction ==# 'v'
    let l:edit = 'vsp'
  elseif a:direction ==# 's'
    let l:edit = 'sp'
  endif
  let l:file_name = expand('%:t')
  let l:full_path = expand('%:p:h')
  if l:file_name =~# '\.spec'
    let l:alt_file_name = substitute(l:file_name, '\.spec\.js$', '.js', '')
    execute l:edit . ' ' . l:full_path . '/../' . l:alt_file_name
  else
    let l:alt_file_name = substitute(l:file_name, '\.js$', '.spec.js', '')
    let l:test_dir = l:full_path . '/__tests__/'
    if !isdirectory(l:test_dir)
      call mkdir(l:test_dir, 'p')
    endif
    execute l:edit . ' ' . l:test_dir . l:alt_file_name
  endif
endfunction

function! javascript#pretty()
  silent !npm run prettier > /dev/null
endfunction
