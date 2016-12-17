"nnoremap <silent> <buffer> <Space>yt :TernType<CR>
"nnoremap <silent> <buffer> <Space>yg :call jedi#goto_definitions()<CR>
"nnoremap <silent> <buffer> <Space>yv :TernDefSplit<CR>
"nnoremap <silent> <buffer> <Space>yd :call jedi#show_documentation()<CR>
"nnoremap <silent> <buffer> <Space>yr :call jedi#usages()<CR>
"nnoremap <silent> <buffer> <Space>yn :call jedi#rename()<CR>
"nnoremap <silent> <buffer> <Space>ya :JsDoc<CR>
"nnoremap <silent> <buffer> <Space>yf :call FlowGetType()<CR>
"nnoremap <silent> <buffer> <Space>yi :call FlowInit()<CR>

let g:jedi#goto_command = "<Space>yg"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<Space>yd"
let g:jedi#usages_command = "<Space>yr"
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<Space>yn"
let g:jedi#completions_enabled = 0

let g:color_column = 79
