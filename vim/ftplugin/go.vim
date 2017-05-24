set tabstop=4
set shiftwidth=4
set noexpandtab

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

nnoremap <Space>ft :GoAlternate<CR>
nnoremap <Space>y<Space> :GoRun<CR>
nnoremap <Space>yc :GoBuild<CR> 
nnoremap <Space>yD :GoDescribe<CR>
nnoremap <Space>yd :GoDoc<CR>
nnoremap <Space>yg :GoDef<CR>
nnoremap <Space>yi :GoImport <C-r><C-w><CR>
nnoremap <Space>yr :GoReferrers<CR>
nnoremap <Space>yt :GoTest<CR>
