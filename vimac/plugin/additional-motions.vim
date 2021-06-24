" Additional Motions {
if !exists('g:additional_motions')

 "pasted/yanked
  call textobj#user#plugin('pasted', {
        \      '-': {
        \        '*sfile*': expand('<sfile>:p'),
        \        'select-a': 'agp', '*select-a-function*': 's:pasted_select_a',
        \        'select-i': 'igp', '*select-i-function*': 's:pasted_select_i',
        \   },
        \ })

  function! s:pasted_select_i()
    normal `]
    let end_pos = getpos('.')
    normal `[
    let start_pos = getpos('.')
    return ['v', end_pos, start_pos]
  endfunction

  function! s:pasted_select_a()
    normal ']$
    let end_pos = getpos('.')
    normal '[0
    let start_pos = getpos('.')
    return ['v', end_pos, start_pos]
  endfunction

  "selected
  call textobj#user#plugin('selected', {
        \      '-': {
        \        '*sfile*': expand('<sfile>:p'),
        \        'select-a': 'agp', '*select-a-function*': 's:selected_select_a',
        \        'select-i': 'igp', '*select-i-function*': 's:selected_select_i',
        \   },
        \ })

  function! s:selected_select_i()
    normal `>
    let end_pos = getpos('.')
    normal `<
    let start_pos = getpos('.')
    return ['v', end_pos, start_pos]
  endfunction

  function! s:selected_select_a()
    normal '>$
    let end_pos = getpos('.')
    normal '<0
    let start_pos = getpos('.')
    return ['v', end_pos, start_pos]
  endfunction

  let g:additional_motions = 1
endif
" }
