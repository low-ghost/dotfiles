"Based on tpope's unimpaired

let s:empty_char = nr2char(10)

function! s:build(count, go, is_prepend) abort
  if a:go is v:true
    normal! ^
    let [l:col, l:lnum] = [col('.'), line('.')]
  endif

  let [l:bang_char, l:go_to] = a:is_prepend is v:true ? ['!', "']+1"] : ['', "'[-1"]

  exe 'silent put' . l:bang_char . ' = repeat(s:empty_char, a:count)'

  if a:go is v:true
    "Prepend doesn't go to the line first
    if a:is_prepend is v:true
      call setpos('.', [0, l:lnum, 1])
    endif

    call setline('.', repeat(' ', l:col - 1))
    startinsert!
  else
    exe l:go_to
  endif
endfunction

function! line#prepend(...) abort
  return call('s:build', a:000 + [v:true])
endfunction

function! line#append(...) abort
  return call('s:build', a:000 + [v:false])
endfunction

function! line#append_and_prepend(count, is_visual) abort
  if a:is_visual is v:true
    normal! `<k
  endif
  call line#append(a:count, v:false)
  if a:is_visual is v:true
    normal! `>j
  endif
  call line#prepend(a:count, v:false)
endfunction
