"nnoremap <silent> <buffer> <Space>yt :TernType<CR>
"nnoremap <silent> <buffer> <Space>yg :call jedi#goto_definitions()<CR>
"nnoremap <silent> <buffer> <Space>yv :TernDefSplit<CR>
"nnoremap <silent> <buffer> <Space>yd :call jedi#show_documentation()<CR>
"nnoremap <silent> <buffer> <Space>yr :call jedi#usages()<CR>
"nnoremap <silent> <buffer> <Space>yn :call jedi#rename()<CR>
"nnoremap <silent> <buffer> <Space>ya :JsDoc<CR>
"nnoremap <silent> <buffer> <Space>yf :call FlowGetType()<CR>
"nnoremap <silent> <buffer> <Space>yi :call FlowInit()<CR>

nnoremap gd :call jedi#goto_definitions()<CR>
nnoremap K :call jedi#show_documentation()<CR>

let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<Space>yd"
let g:jedi#usages_command = "<Space>yr"
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<Space>yn"
let g:jedi#completions_enabled = 0

let b:ale_linters = ['flake8', 'pylint', 'bandit']
let b:ale_fixers = ['yapf']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%% code%]'
let g:ale_fix_on_save = 1

nnoremap <silent> <buffer> <Space>yf :0,$!yapf<CR>

let g:color_column = 79

set shiftwidth=4  " Use indents of 2 spaces
set tabstop=4     " An indentation every four columns
set softtabstop=4 " Let backspace delete indent
set expandtab     " Spaces instead of tabs

