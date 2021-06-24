function! util#count_command(command, ...) abort
  let l:count = exists('a:1') && v:count == 0 ? a:1 : v:count1
  "execute a command like b or ll w/ a count
  if exists('a:2')
    exe '' . a:command . '' . l:count
  else
    exe a:command . l:count
  endif
endfunction

function! util#git_root() abort
  let l:root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    throw 'Not in git repo'
  endif
  return l:root
endfunction

function! util#nvmap(keys, command) abort
  let l:map = 'noremap <silent> <Space>' . a:keys . ' ' . a:command
  exe 'n' . l:map
  exe 'v' . l:map
endfunction
