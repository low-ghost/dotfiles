function! s:build(key, action, range_selection, range, is_correct, end) abort
  let l:std_extra = a:action ==# '' && a:key !=# 'l' ? '<Left>' : ''
  let l:arrows = '<Left><Left>' . l:std_extra
  let l:map_str = 'noremap <silent> <Space>s' . a:range_selection
  let l:correct_extra = a:is_correct == v:true ? 'c<Left>' : ''
  let l:sub_str = 's/' . a:action . '//g' . l:correct_extra . l:arrows
  let l:full_command_except_mode =
    \ l:map_str . a:key . ' :' . a:range . l:sub_str . a:end

  exe 'n' . l:full_command_except_mode

  if a:range_selection !~# 'a\|e'
    exe 'v' . l:full_command_except_mode
  endif 
endfunction

function! sub#make_set(key, action) abort
  " Sub
  call s:build(a:key, a:action, '', '', v:false, '')
  " Sub all
  call s:build(a:key, a:action, 'a', '%', v:false, '')
  " Sub to end
  call s:build(a:key, a:action, 'e', '.,$', v:false, '')
  " Sub in command mode
  call s:build(a:key, a:action, 'f', '', v:false, '<C-f>i')
  " Sub all in command mode
  call s:build(a:key, a:action, 'fa', '%', v:false, '<C-f>i')
  " Sub to end in command mode
  call s:build(a:key, a:action, 'fe', '.,$', v:false, '<C-f>i')
  " Sub correct
  call s:build(a:key, a:action, 'c', '', v:true, '')
  " Sub all correct
  call s:build(a:key, a:action, 'ca', '%', v:true, '')
  " Sub to end correct
  call s:build(a:key, a:action, 'ce', '.,$', v:true, '')
  " Sub correct in command mode
  call s:build(a:key, a:action, 'fc', '', v:true, '<C-f>i')
  " Sub all in command mode
  call s:build(a:key, a:action, 'fca', '%', v:true, '<C-f>i')
  call s:build(a:key, a:action, 'fce', '.,$', v:true, '<C-f>i')
endfunction
