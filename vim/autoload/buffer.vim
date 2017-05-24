function! buffer#refresh_all() abort
  set noconfirm
  bufdo e!
  set confirm
endfunction

function! buffer#by_match(delete) abort
   let l:buf_nr = bufnr('$')
   let l:str = a:delete is v:true
     \ ? input('Delete buffers matching> ')
     \ : input('Keep only buffers matching> ')

   while l:buf_nr > 0
     let l:bname = bufname(l:buf_nr)
     if buflisted(l:buf_nr)
       \ && (a:delete ? l:bname =~ l:str : l:bname !~ l:str)
       \ && getbufvar(l:buf_nr, '&modified') == 0
       exe 'bd ' . l:buf_nr
     endif
     let l:buf_nr = l:buf_nr - 1
   endwhile
endfunction

""
" Delete all the buffers except the current/named buffer.
" Based on:
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
" Distributed under the terms of the Vim license.  See ":help license".
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.
function! buffer#only(buffer, bang) abort

  if a:buffer ==# '' || a:buffer == v:null
    " No buffer provided, use the current buffer.
    let l:buffer = bufnr('%')
  elseif (a:buffer + 0) > 0
    " A buffer number was provided.
    let l:buffer = bufnr(a:buffer + 0)
  else
    " A buffer name was provided.
    let l:buffer = bufnr(a:buffer)
  endif

  if l:buffer == -1
    echohl ErrorMsg
    echomsg 'No matching buffer for ' . a:buffer
    echohl None
    return
  endif

  let l:last_buffer = bufnr('$')

  let l:delete_count = 0
  let l:i = 1
  while l:i <= l:last_buffer
    if l:i != l:buffer && buflisted(l:i)
      if (a:bang ==# '') && getbufvar(l:i, '&modified')
        echohl ErrorMsg
        echomsg 'No write since last change for buffer ' .
              \ l:i . ' (add ! to override)'
        echohl None
      else
        silent exe 'bdel' . a:bang . ' ' . l:i
        if ! buflisted(l:i)
          let l:delete_count = l:delete_count + 1
        endif
      endif
    endif
    let l:i = l:i + 1
  endwhile

  if l:delete_count == 1
    echomsg l:delete_count 'buffer deleted'
  elseif l:delete_count > 1
    echomsg l:delete_count 'buffers deleted'
  endif

endfunction
