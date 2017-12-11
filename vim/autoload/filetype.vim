function! s:get_path() abort
  let l:to_edit = substitute(&filetype, '\.jsx', '', '')
  return '~/repo/dotfiles/vim/ftplugin/' . l:to_edit . '.vim'
endfunction

function! filetype#edit_ft_plugin() abort
  exe 'e ' . s:get_path()
endfunction

function! filetype#source_ft_plugin() abort
  exe 'so ' . s:get_path()
endfunction 
