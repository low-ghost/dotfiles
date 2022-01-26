let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'

hi link CocErrorSign GruvboxRedSign
hi link CocWarningSign GruvboxYellowSign
hi link CocInfoSign GruvboxGreenSign

let g:UltiSnipsExpandTrigger="<C-j>"

let g:EasyMotion_keys = 'tnseriaodhbkvmplfuwyqsent'

command! -nargs=+ -complete=file -bar Grep silent! grep! '<args>'|cwindow|redraw!
command! -nargs=+ -complete=file -bar Gr silent! grep! '<args>'|cwindow|redraw!

" coc extensions {
let g:coc_global_extensions = [
 \ 'coc-css',
 \ 'coc-eslint',
 \ 'coc-git',
 \ 'coc-html',
 \ 'coc-lists',
 \ 'coc-diagnostic',
 \ 'coc-jedi',
 \ 'coc-json',
 \ 'coc-prettier',
 \ 'coc-snippets',
 \ 'coc-tsserver',
 \ 'coc-vimlsp',
 \ 'coc-yank',
 \]

let g:airline#extensions#coc#enabled = 1
" }

" rainbowpairs {
 let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
 let g:rainbow#blacklist = [239, 240, 244, 245, 248, 250, 223, 229, 224]
" }

" Vimax {
let g:vimax_history_file = $HOME . '/.zsh_history'
let g:vimax_default_mappings = 1
let g:vimax_leader = '<Space>v'
let g:vimax_mode = 'nvim'
" }

" no default doesn't seem to override. too lazy to look rn.
" let g:textobj_line_no_default_mappings = 1
" call textobj#user#plugin('line', {
" \   '-': {
" \     'select-a': 'ass', 'select-a-function': 'textobj#line#select_a',
" \     'select-i': 'iss', 'select-i-function': 'textobj#line#select_i',
" \   },
" \ })

let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]

" vim-airline {
let g:airline#extensions#tmuxline#enabled = 1
let g:airline_powerline_fonts=1
" See `:echo g:airline_theme_map` for some more choices
let g:airline_theme = 'gruvbox_material'
let g:airline#extensions#tabline#enabled = 0
" tab airline weirdly flashed all buffer names on landing in new buffer,
" slowing everything down
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#tabline#tab_min_count = 2
" let g:airline_section_a = '%#__accent_bold#%{airline#util#wrap(airline#parts#mode(),0)}%#__restore__#%{airline#util#append(airline#parts#crypt(),0)}%{airline#util#append(airline#parts#paste(),0)}%{airline#util#append(airline#extensions#keymap#status(),0)}%{airline#util#append("",0)}%{airline#util#append(airline#parts#iminsert(),0)}'
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" function! CocCurrentFunction()
"     return get(b:, 'coc_current_function', '')
" endfunction

" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'separator': { 'left': '⮀', 'right': '⮂' },
"       \ 'subseparator': { 'left': '⮁', 'right': '⮃' },
"       \ 'component_function': {
"       \   'cocstatus': 'coc#status',
"       \   'currentfunction': 'CocCurrentFunction',
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ }

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set showbreak=····
  set nocursorline
  set fo+=a
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=3
  set showbreak=
  set cursorline
  set fo-=a
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

augroup pencil
  autocmd!
  autocmd filetype markdown,mkd call pencil#init()
        \ | call lexical#init()
        \ | call litecorrect#init()
        \ | setl fdo+=search
augroup END
" Pencil / Writing Controls {{{
let g:pencil#textwidth = 80 
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130
" }}}

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let $FZF_DEFAULT_OPTS = '--bind ctrl-s:select-all,ctrl-d:deselect-all'
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -nargs=0 Snippets :call fzf#vim#snippets({'options': '-n ..'})

" let g:ale_echo_msg_format = '[%linter%] %s [%severity%% code%]'
" let g:ale_python_pylint_executable = '/usr/local/bin/pylint

let NERDTreeIgnore = ['\~$', '\.pyc$', '\.egg-info$', '__pycache__']


