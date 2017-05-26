set tabstop=4
set shiftwidth=4
set noexpandtab

let g:neomake_go_gometalinter_args = [
  \ '--disable-all',
  \ '--enable=errcheck',
  \ '--enable=gosimple',
  \ '--enable=staticcheck',
  \ '--enable=unused'
  \ ]
let g:neomake_go_enambled_makers = ['go', 'gometalinter', 'govet']

" Maybe I like letting neomake do all the work and so don't show go fmt errors
let g:go_fmt_fail_silently = 1

let g:go_info_mode = 'guru'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

nmap <Space>ft <Plug>(go-alternate)
nmap <Space>y<Space> <Plug>(go-run)
nmap <Space>yc <Plug>(go-build)
nmap <Space>yD <Plug>(go-describe)
nmap <Space>yd <Plug>(go-doc)
nmap <Space>yg <Plug>(go-def)
nmap <Space>yi <Plug>(go-import)
nmap <Space>yr <Plug>(go-referrers)
nmap <Space>yT <Plug>(go-test)
nmap <Space>yt <Plug>(go-info)
