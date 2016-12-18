function! s:execute_in_shell(command)
  silent! execute 'sp ' . fnameescape(a:command)
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . a:command . '...'
  silent! execute 'silent %!'. a:command
  silent! set ft=zsh
  silent! resize 10
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <space>r :call <SID>ExecuteInShell('''
    \ . a:command . ''')<CR>'
  echo 'Shell command ' . a:command . ' executed.'
endfunction

command! -complete=shellcmd -nargs=+ Shell call s:execute_in_shell(<q-args>)
command! -complete=shellcmd -nargs=+ Sh call s:execute_in_shell(<q-args>)

function! s:i_execute_in_shell(command)
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

command! -complete=shellcmd -nargs=* IShell call s:i_execute_in_shell(<q-args>)
command! -complete=shellcmd -nargs=* ISh call s:i_execute_in_shell(<q-args>)

" Basic Job Control {{{

function! s:color_echo(str)
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

if !exists('g:running_jobs')
  let g:last_job_executed = ''
  let g:last_job_results = ''
  let g:running_jobs = {}
endif

"TODO: print 'exited' to scratch at least
function! s:exit_job_callback(id, data, event) dict
  call remove(g:running_jobs, a:id)
endfunction

function! s:base_callback(data)
  let is_one_liner = len(a:data) == 2 && a:data[-1] == ''
  let formatted_data = is_one_liner ? a:data[0] : "\n" . join(a:data, "\n")
  let g:last_job_results = formatted_data
  return formatted_data
endfunction

function! s:print_job(id, data, event) dict
  let data = s:call_self_filter(self, a:data)
  if empty(data)
    return
  endif
  let formatted_data = s:base_callback(data)
  let label = a:event == 'stdout'
    \ ? ' |-|Title|-|stdout|-|None|-|: '
    \ : ' |-|WarningMsg|-|stderr|-|None|-|: '
  call s:color_echo(self.shell . label . formatted_data)
endfunction

function! s:read_job(id, data, event) dict
  let data = s:call_self_filter(self, a:data)
  if empty(data)
    return
  endif
  call append('.', data)
endfunction

"Scatch buffer functionality based on scratch.vim
"https://github.com/vim-scripts/scratch.vim
"by Yegappan Lakshmanan (yegappan AT yahoo DOT com) {{{

function! s:get_job_window_name(id)
  return '__job_window_' . a:id . '__'
endfunction

let g:open_job_window_height = 10

function! OpenJobWindow(...)
  let id = s:get_job_address(a:000)
  let current_location = [ winnr(), bufnr('%') ]
  let job_window_name = s:get_job_window_name(id)
  let buffer_num = bufnr(job_window_name)
  let buffer_doesnt_exist = buffer_num == -1
  if buffer_doesnt_exist
    silent! exe g:open_job_window_height . "new " . job_window_name
    silent! call s:set_buffer_local_opts()
  else
    let window_num = bufwinnr(buffer_num)
    let window_doesnt_exist = window_num == -1
    if window_doesnt_exist
      "bring existing buffer into view
      silent! exe g:open_job_window_height . "split +buffer" . buffer_num
    elseif current_location[0] != window_num
      silent! exe window_num . "wincmd w"
    endif
  endif
  return current_location
endfunction

function! CloseJobWindow(...)
  let id = s:get_job_address(a:000)
  let job_window_name = s:get_job_window_name(id)
  let buffer_num = bufnr(job_window_name)
  if buffer_num == -1
    echo "No scratch open"
  else
    exe "bd! " . buffer_num
  endif
endfunction

function! s:set_buffer_local_opts()
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal buflisted
endfunction

function! s:call_self_filter(caller, data)
  return has_key(a:caller, 'filter') ? a:caller.filter(a:data) : a:data
endfunction

function! s:window_job(id, data, event) dict
  let data = s:call_self_filter(self, a:data)
  if empty(data)
    return
  endif
  let previous_location = OpenJobWindow(a:id)
  let last_scratch_line = line('$')
  if last_scratch_line ==# 1 && !strlen(getline(1))
    " first line is empty, we overwrite it
    call append(0, data)
    silent! exe 'normal! Gdd$'
  else
    call append(last_scratch_line, data)
    silent! exe 'normal! G$'
  endif
  " remove trailing white space
  silent! exe '%s/\s\+$/'
  silent! exe previous_location[0] . "wincmd w"
  silent! exe 'b ' . previous_location[1]
endfunction

" }}}

let s:print_job_callbacks = {
  \ 'on_stdout': function('s:print_job'),
  \ 'on_stderr': function('s:print_job'),
  \ }
let s:read_job_callbacks = {
  \ 'on_stdout': function('s:read_job'),
  \ 'on_stderr': function('s:read_job'),
  \ }
let s:window_job_callbacks = {
  \ 'on_stdout': function('s:window_job'),
  \ 'on_stderr': function('s:window_job'),
  \ }

function! JobExecute(command, name, output, ...)
  let g:last_job_executed = a:command
  let base_ops = {'shell': a:name, 'on_exit': function('s:exit_job_callback')}
  let command_is_list = type(a:command) == type([])
  let full_command = command_is_list ? a:command : ['zsh', '-c', a:command]
  if a:output == 'print'
    let callbacks = s:print_job_callbacks
  elseif a:output == 'read'
    let callbacks = s:read_job_callbacks
  else
    let callbacks = s:window_job_callbacks
  endif
  let opts_with_overrides = a:0 > 0 ? extend(callbacks, a:1) : callbacks
  let id = jobstart(full_command, extend(base_ops, opts_with_overrides))
  let joined_command = command_is_list ? join(a:command, ' ') : a:command
  let g:running_jobs[id] = [a:name, joined_command]
  "So that we can start a job and send to it immediately
  let g:last_job_id = id
endfunction

function! s:truncate(text)
  let cut_off = 15
  return len(a:text) > cut_off ? a:text[:cut_off] . '...' : a:text
endfunction

" Ignore args from completion
function! PrintRunningJobs(...)
  let formatted =
    \ join(map(keys(g:running_jobs),
           \ 'v:val . ": " . g:running_jobs[v:val][0] . " " . s:truncate(g:running_jobs[v:val][1])'), "\n")
  echo formatted
  return formatted
endfunction
command! PrintRunningJobs call PrintRunningJobs()

function! s:get_job_address(arg)
  return !empty(a:arg) ? str2nr(split(a:arg[0], ':')[0]) : g:last_job_id
endfunction

" Will take a raw number or a formatted '<job_id>: <description>' as generated
" by PrintRunningJobs
function! StopRunningJob(...)
  call jobstop(s:get_job_address(a:000))
endfunction

function! SendPromptToJob(...)
  let g:last_job_id = s:get_job_address(a:000)
  let message = input('Send to ' . g:last_job_id . '> ')
  call jobsend(g:last_job_id, message . "\n")
endfunction

"Kill a running job, with tab completion. If no job is chosen, it will
"kill the last used or last opened job
command! -complete=custom,PrintRunningJobs -nargs=? StopRunningJob call StopRunningJob(<f-args>)
"Send a message to a job, with tab completion. If no job is chosen, it will
"send to the last used or last opened job
command! -complete=custom,PrintRunningJobs -nargs=? SendPromptToJob call SendPromptToJob(<f-args>)

"Equivalent to :!
"Prints command output as normal vim messages (with a little color)
command! -complete=shellcmd -nargs=* J call JobExecute(<q-args>, 'job', 'print')
"Equivalent to :r!
"Reads command output into current buffer
command! -complete=shellcmd -nargs=* Jr call JobExecute(<q-args>, 'job', 'read')
"No equivalent
"Reads command output into a scratch buffer
command! -complete=shellcmd -nargs=* Js call JobExecute(<q-args>, 'job', 'scratch')
"Open the scratch buffer
command! -complete=custom,PrintRunningJobs -nargs=? OpenJobWindow call OpenJobWindow(<f-args>)
"Close the scratch buffer
command! -complete=custom,PrintRunningJobs -nargs=? CloseJobWindow call CloseJobWindow(<f-args>)

" These are purely for convenience. I have  mapped to : so running these commands might look like
" ;;<space>ls<cr>
" Without mapping ; to :, replacing ; with : here would probably be simpler
" e.g. cnreabbrev : J
" ::<space>ls<cr>
" cnoreabbrev's do not expand if there is anything before or after them, so
" these shouldn't get in the way
cnoreabbrev ; J
cnoreabbrev ;r Jr
cnoreabbrev ;s Js
"print
cnoreabbrev ;p PrintRunningJobs
"kill
cnoreabbrev ;k StopRunningJob
"input
cnoreabbrev ;i SendPromptToJob

" }}}


" Specific Job Commands {{{

":Nvm use 7
command! -complete=shellcmd -nargs=* Nvm
  \ call JobExecute('source ~/.nvm/nvm.sh > /dev/null; nvm ' . <q-args>, 'nvm', 'print')

"Some programs feature output buffering and will need flags or configuration to print
"incrementally to stdout. For instance, python needs a '-u' and ruby needs
"'$stdout.sync = true'

"Shortcut for :J python -c 'from ...'
":Py from time import sleep; print(1); sleep(1); print(2)<cr>
command! -complete=shellcmd -nargs=* Py
  \ call JobExecute([ 'python', '-u', '-c', <q-args> ], 'python', 'print')
":Pyf ../file.py
command! -complete=shellcmd -nargs=* Pyf
  \ call JobExecute([ 'python', '-u', <q-args> ], 'python', 'print')

function! s:node_repl_cb(data)
  "Ignore empty lines and node prompt (starting with >)
  return filter(a:data, '!empty(v:val)')
endfunction

command! NodeRepl call JobExecute(
  \ ['node', '../repl/node'],
  \ 'node-repl',
  \ 'scratch',
  \ { 'filter': function('s:node_repl_cb') })

" }}}
