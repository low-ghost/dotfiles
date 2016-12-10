function! s:ExecuteInShell(command)
  silent! execute 'sp ' . fnameescape(a:command)
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . a:command . '...'
  silent! execute 'silent %!'. a:command
  silent! set ft=zsh
  silent! resize 10
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <space>r :call <SID>ExecuteInShell(''' . a:command . ''')<CR>'
  echo 'Shell command ' . a:command . ' executed.'
endfunction

command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
command! -complete=shellcmd -nargs=+ Sh call s:ExecuteInShell(<q-args>)

function! s:IExecuteInShell(command)
  let name = a:command ? fnameescape(a:command) : 'new_terminal'
  silent! execute 'sp ' . name
  silent! set ft=zsh
  silent! resize 10
  let g:last_terminal = termopen('zsh')
  if a:command
    silent! call jobsend(g:last_terminal, a:command . "\r")
  endif
  startinsert!
endfunction

command! -complete=shellcmd -nargs=* IShell call s:IExecuteInShell(<q-args>)
command! -complete=shellcmd -nargs=* ISh call s:IExecuteInShell(<q-args>)

"}

" Zoom / Restore window. {
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction

command! ZoomToggle call s:ZoomToggle()
