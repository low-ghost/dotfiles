function! test#edit_file(direction) abort
  let l:current_dir = expand('%:p')
  let l:git_root = util#git_root()
  let l:diff_path = matchlist(l:current_dir, l:git_root . '\(.*\)')[1]
  let l:full_alt_path = l:git_root . '/' . g:test_path . l:diff_path
  if a:direction ==# 'e'
    exe 'e ' . l:full_alt_path
  elseif a:direction ==# 's'
    exe 'sp ' . l:full_alt_path
  else
    exe 'vsp ' . l:full_alt_path
  endif
endfunction
