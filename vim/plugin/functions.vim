" vim: foldmarker={,} foldmethod=marker spell:
" Helpful Functions

function! ResCur()
  if match(bufname("%"), "term://") == -1 && line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

let g:last_changed_dir = ""
function! SaveLastDir()
  let g:last_changed_dir = getcwd()
endfunction

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

function! s:getchar()
  let c = getchar()
  if c =~ '^\d\+$'
    let c = nr2char(c)
  endif
  return c
endfunction

function! ExecuteMacroOnSelection(...)
  if !exists('a:1') || !exists('s:last_execute_register')
    echo 'register> '
    let s:last_execute_register = s:getchar()
  endif
  exe "'<,'>normal @" . s:last_execute_register
endfunction

" Miscellaneous {
function! IncrementVisualNumbers()
  "increment all visually selected nums in order (only in col)
  "TODO, make work on none-line breaked
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call IncrementVisualNumbers()<CR>
"}
