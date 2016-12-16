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

" Basic Job Control {{{

function! s:ColorEcho(str)
  let index = 0
  for item in split(a:str, "|-|")
    let index += 1
    if index % 2
      echon item
    else
      exec "echohl " . item
    endif
  endfor
endfunction

let g:last_job_executed = ''
let g:last_job_results = ''
let g:running_jobs = {}

function! s:ExitJobCallback(id, data, event) dict
  call remove(g:running_jobs, a:id)
endfunction

function! s:BaseCallback(data)
  let is_one_liner = len(a:data) == 2 && a:data[-1] == ''
  let formatted_data = is_one_liner ? a:data[0] : join(a:data, "\n")
  let g:last_job_results = formatted_data
  return formatted_data
endfunction

function! s:PrintJob(id, data, event) dict
  let formatted_data = s:BaseCallback(a:data)
  let label = a:event == 'stdout'
    \ ? ' |-|Title|-|stdout|-|None|-|: '
    \ : ' |-|WarningMsg|-|stderr|-|None|-|: '
  call s:ColorEcho(self.shell . label . formatted_data)
endfunction

function! s:ReadJob(id, data, event) dict
  call append('.', a:data)
endfunction

"Scatch buffer functionality based on scratch.vim
"https://github.com/vim-scripts/scratch.vim
"by Yegappan Lakshmanan (yegappan AT yahoo DOT com) {{{
let g:JobScratchBufferName = "__Job_Scratch__"

function! OpenJobScratch()
  let bnum = bufnr(g:JobScratchBufferName)
  if bnum == -1
    exe "new " . g:JobScratchBufferName
  else
    let wnum = bufwinnr(bnum)
    if wnum != -1
      if winnr() != wnum
        exe wnum . "wincmd w"
      endif
    else
      "bring existing buffer into view
      exe "split +buffer" . bnum
    endif
  endif
endfunction

function! CloseJobScratch()
  let bnum = bufnr(g:JobScratchBufferName)
  if bnum == -1
    echo "No scratch open"
  else
    exe "bd " . bnum
  endif
endfunction

function! s:SetBufferLocalOpts()
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal buflisted
endfunction

function! s:ScratchJob(id, data, event) dict
  call OpenJobScratch()
  let last_scratch_line = line('$')
  if last_scratch_line ==# 1 && !strlen(getline(1))
    " line is empty, we overwrite it
    call append(0, a:data)
    silent exe 'normal! Gdd$'
  else
    call append(last_scratch_line, a:data)
    silent exe 'normal! G$'
  endif
  " remove trailing white space
  silent! exe '%s/\s\+$/'
endfunction

autocmd BufNewFile __Job_Scratch__ call s:SetBufferLocalOpts()

" }}}

let s:PrintJobCallbacks = {
  \ 'on_stdout': function('s:PrintJob'),
  \ 'on_stderr': function('s:PrintJob'),
  \ }
let s:ReadJobCallbacks = {
  \ 'on_stdout': function('s:ReadJob'),
  \ 'on_stderr': function('s:ReadJob'),
  \ }
let s:ScratchJobCallbacks = {
  \ 'on_stdout': function('s:ScratchJob'),
  \ 'on_stderr': function('s:ScratchJob'),
  \ }

function! JobExecute(command, name, output)
  let g:last_job_executed = a:command
  let base_ops = { 'shell': a:name, 'on_exit': function('s:ExitJobCallback') }
  let full_command = [ 'zsh', '-c', a:command ]
  if a:output == 'print'
    let callbacks = s:PrintJobCallbacks
  elseif a:output == 'read'
    let callbacks = s:ReadJobCallbacks
  else
    let callbacks = s:ScratchJobCallbacks
  endif
  let id = jobstart(full_command, extend(base_ops, callbacks))
  let g:running_jobs[id] = [ a:name, a:command ]
endfunction

function! PrintRunningJobs()
  echo g:running_jobs
endfunction
command! PrintRunningJobs call PrintRunningJobs()

command! -complete=shellcmd -nargs=* J call JobExecute(<q-args>, 'job', 'print')
command! -complete=shellcmd -nargs=* Jr call JobExecute(<q-args>, 'job', 'read')
command! -complete=shellcmd -nargs=* Js call JobExecute(<q-args>, 'job', 'scratch')
command! OpenJobScratch call OpenJobScratch()
command! CloseJobScratch call CloseJobScratch()

" I have ; mapped to : so running these commands might look like ;;<space>ls<cr>
cnoreabbrev ; J
cnoreabbrev ;r Jr
cnoreabbrev ;s Js

" }}}

command! -complete=shellcmd -nargs=* Nvm
  \ call JobExecute('source ~/.nvm/nvm.sh > /dev/null; nvm ' . <q-args>, 'nvm', 'print')
