" vim: foldmarker={,} foldmethod=marker spell:
" Helpful Functions

" Initialize directories {
function! InitializeDirectories()
  let parent = $HOME
  let prefix = 'vim'
  let dir_list = {
    \ 'backup': 'backupdir',
    \ 'views': 'viewdir',
    \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  " To specify a different directory in which to place the vimbackup,
  " vimviews, vimundo, and vimswap files/directories, add the following to
  " your .vimrc.before.local file:
  "   let g:spf13_consolidated_directory = <full path to desired directory>
  "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
  if exists('g:spf13_consolidated_directory')
    let common_dir = g:spf13_consolidated_directory . prefix
  else
    let common_dir = parent . '/.' . prefix
  endif

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()
" }

" Initialize NERDTree as needed {
function! NERDTreeInitAsNeeded()
  redir => bufoutput
  buffers!
  redir END
  let idx = stridx(bufoutput, "NERD_tree")
  if idx > -1
    NERDTreeMirror
    NERDTreeFind
    wincmd l
  endif
endfunction
" }

" Strip whitespace {
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }

" Shell command {
function! s:RunShellCommand(cmdline)
  botright new

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal nobuflisted
  setlocal noswapfile
  setlocal nowrap
  setlocal filetype=shell
  setlocal syntax=shell

  call setline(1, a:cmdline)
  call setline(2, substitute(a:cmdline, '.', '=', 'g'))
  execute 'silent $read !' . escape(a:cmdline, '%#')
  setlocal nomodifiable
  1
endfunction
command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
" }

"TODO visual block
" Insert functions {
function! AppendLine()
  let c = v:count > 0 ? v:count : 1
  let i = 0
  while i < c
    call append(line("."), "")
    let i += 1
  endwhile
endfunction

function! PrependLine()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  let c = v:count > 0 ? v:count : 1
  let i = 0
  while i < c
    call append(line(".") - 1, "")
    let i += 1
  endwhile
  if winline() != winheight(0)
    silent normal! <C-e>
  end
  let &scrolloff = l:scrolloffsave
endfunction

function! AppendAndPrependLine()
  call AppendLine()
  call PrependLine()
endfunction
" }

function! BufferByMatch(delete)
   let bufNr = bufnr("$")
   let str = a:delete
     \ ? input('Delete buffers matching> ')
     \ : input('Keep only buffers matching> ')
   while bufNr > 0
     let bname = bufname(bufNr)
     if buflisted(bufNr)
       \ && (a:delete ? bname =~ str : bname !~ str)
       \ && getbufvar(bufNr, '&modified') == 0
       exe "bd ".bufNr
     endif
     let bufNr = bufNr-1
   endwhile
endfunction

" BufOnly.vim {
"
" Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer] 
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

command! -nargs=? -complete=buffer -bang Bonly
      \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
      \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
      \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
      \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
  if a:buffer == ''
    " No buffer provided, use the current buffer.
    let buffer = bufnr('%')
  elseif (a:buffer + 0) > 0
    " A buffer number was provided.
    let buffer = bufnr(a:buffer + 0)
  else
    " A buffer name was provided.
    let buffer = bufnr(a:buffer)
  endif

  if buffer == -1
    echohl ErrorMsg
    echomsg "No matching buffer for" a:buffer
    echohl None
    return
  endif

  let last_buffer = bufnr('$')

  let delete_count = 0
  let n = 1
  while n <= last_buffer
    if n != buffer && buflisted(n)
      if a:bang == '' && getbufvar(n, '&modified')
        echohl ErrorMsg
        echomsg 'No write since last change for buffer'
              \ n '(add ! to override)'
        echohl None
      else
        silent exe 'bdel' . a:bang . ' ' . n
        if ! buflisted(n)
          let delete_count = delete_count+1
        endif
      endif
    endif
    let n = n+1
  endwhile

  if delete_count == 1
    echomsg delete_count "buffer deleted"
  elseif delete_count > 1
    echomsg delete_count "buffers deleted"
  endif

endfunction
" }

" Toggle {
" Background {
function! ToggleBG()
  let s:tbg = &background
  if s:tbg == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction
" }

" Syntax {
let s:syntax_toggle = "on"
function! ToggleSyntax()
  if s:syntax_toggle == "on"
    let s:syntax_toggle = "off"
    syntax off
  else
    let s:syntax_toggle = "on"
    syntax on
  endif
endfunction

"TODO redir => hi_cursor_line
"hi CursorLine
"redir END
"grep to get values and execute in else
let s:position_toggle = "off"
function! TogglePosition()
  if s:position_toggle == "off"
    let s:position_toggle = "on"
    set cursorcolumn
    hi CursorLine cterm=reverse ctermbg=241 gui=reverse guibg=#665c54
  else
    let s:position_toggle = "off"
    set cursorcolumn!
    hi CursorLine cterm=NONE ctermbg=237 gui=NONE guibg=#3c3836
  endif
endfunction

let s:end_column_toggle = "off"
function! ToggleEndColumn()
  if s:end_column_toggle == "off"
    let s:end_column_toggle = input('end col. num> ', 100)
    exe 'set colorcolumn='.s:end_column_toggle
  else
    let s:end_column_toggle = "off"
    set colorcolumn=
  endif
endfunction
" }
" }

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

  "line
  call textobj#user#plugin('line', {
        \      '-': {
        \        '*sfile*': expand('<sfile>:p'),
        \         'select-a': 'al', '*select-a-function*': 's:line_select_a',
        \         'select-i': 'il', '*select-i-function*': 's:line_select_i',
        \  },
        \ })

  function! s:line_select_a()
    normal! 0
    let head_pos = getpos('.')
    normal! $
    let tail_pos = getpos('.')
    return ['v', head_pos, tail_pos]
  endfunction

  function! s:line_select_i()
    normal! ^
    let head_pos = getpos('.')
    normal! g_
    let tail_pos = getpos('.')
    let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
    return
          \ non_blank_char_exists_p
          \ ? ['v', head_pos, tail_pos]
          \ : 0
  endfunction

  let g:additional_motions = 1
endif
" }
