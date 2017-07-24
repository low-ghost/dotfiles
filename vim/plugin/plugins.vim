" Plugin specific settings

" YouCompleteMe {{{
let g:Completion_YouCompleteMe = 1
" }}}
let g:Make_neomake = 1
let g:fzf_command_prefix = 'Fzf'
" Vimax {{{
let g:vimax_history_file = $HOME . '/.zsh_history'
let g:vimax_default_mappings = 1
let g:vimax_leader = '<Space>v'
" }}}
let g:airline#extensions#tmuxline#enabled = 0
let g:jsx_ext_required = 0

"let g:tmuxline_preset = 'nightly_line'
"let g:promptline_preset = {
  "\ 'a' : [ '$vim_mode' ],
  "\ 'b' : [ promptline#slices#cwd() ],
  "\ 'y' : [ promptline#slices#vcs_branch(), promptline#slices#git_status(), promptline#slices#jobs() ],
  "\ 'warn' : [ promptline#slices#last_exit_code(), promptline#slices#battery() ]}

" OmniComplete {{{
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
    \if &omnifunc == "" |
    \setlocal omnifunc=syntaxcomplete#Complete |
    \endif
endif

hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" Some convenient mappings
" below line causes <C-f> problems
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest
" }}}

" Ctags {{{
set tags=./tags;/,~/.vimtags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
  let &tags = &tags . ',' . gitroot . '/.git/tags'
endif
" }}}

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
"au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
"nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" NerdTree {{{
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\.map\.*', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
" }}}

" JSON {
let g:vim_json_syntax_conceal = 0
" }

" TagBar {
	"nnoremap <silent> <leader>tt :TagbarToggle<CR>
"}

" Let <Tab> also do completion
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB> pumvisible()
  \ ? "\<C-n>"
  \ : <SID>check_back_space()
  \ ? "\<TAB>"
  \ : deoplete#mappings#manual_complete()
let g:UltiSnipsSnippetsDir="~/repo/dotfiles/vim/UltiSnips"
set runtimepath+=~/repo/dotfiles/vim
" }

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 'ignorecase'
let g:deoplete#auto_completion_start_length = 0
let g:min_pattern_length = 0
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'buffer', 'noderepl', 'flow', 'tern', 'ultisnips']
let g:deoplete#sources['javascript'] = ['file', 'buffer', 'noderepl', 'flow', 'tern', 'ultisnips']
let g:deoplete#sources['python'] = ['file', 'jedi', 'ultisnips']
call deoplete#custom#set('flow', 'rank', 9999)

let g:deoplete#enable_refresh_always=1


" UndoTree {
let g:undotree_SetFocusWhenToggle=1
" }

" indent_guides {
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" }

" vim-airline {
let g:airline_powerline_fonts=1
" See `:echo g:airline_theme_map` for some more choices
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" }

" neomake {
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2

let g:neomake_warning_sign = {
  \ 'text': '>',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '>>',
  \ 'texthl': 'ErrorMsg',
  \ }

let g:neomake_python_enabled_makers = ['pylama', 'mypy']
let g:neomake_vim_enambled_makers = ['vint']

"autocmd FileType typescript autocmd BufWritePre <buffer> let b:neomake_typescript_eslint_exe = substitute(system('PATH=$(npm bin):$PATH && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

"let g:neomake_typescript_tsc_maker = {
  "\ 'args': [
      "\  '-t', 'es5', '-m', 'commonjs', '--noEmit', '--noImplicitAny',
  "\ ],
  "\ 'errorformat':
      "\ '%E%f %#(%l\,%c): error %m,' .
      "\ '%E%f %#(%l\,%c): %m,' .
      "\ '%Eerror %m,' .
      "\ '%C%\s%\+%m'
  "\ }
"let g:neomake_typescript_tsca_maker = {
  "\ 'exe': 'tsc',
  "\ 'append_file': 0,
  "\ 'errorformat':
      "\ '%E%f %#(%l\,%c): error %m,' .
      "\ '%E%f %#(%l\,%c): %m,' .
      "\ '%Eerror %m,' .
      "\ '%C%\s%\+%m'
  \ }
"let g:neomake_typescript_eslint_maker = {
  "\ 'exe': substitute(system('PATH=$(npm bin):$PATH && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', ''),
  "\ 'args': ['-f', 'compact'],
  "\ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    "\ '%W%f: line %l\, col %c\, Warning - %m'
  "\ }
let g:neomake_typescript_enabled_makers = ['tsc', 'eslint']

function! Tsc()
  "let path = systemlist('git rev-parse --show-toplevel')[0]
  "if v:shell_error
    "return s:warn('Not in git repo')
  "endif
  "exe 'cd' path
  exe 'Neomake tsca'
endfunction
command! Tsc call Tsc()

function! NeoAg(search, ...)
  "Takes a search parameter as first arg and all additional args
  "to perform ag query at git root
  let path = systemlist('git rev-parse --show-toplevel')[0]
  exe 'lcd' path
  if v:shell_error
    return s:warn('Not in git repo')
  endif
  let base_args = ['--column', '--nogroup', a:search ] + a:000
  call neomake#Make(0, [{
    \ 'name': 'Ag',
    \ 'exe': 'ag',
    \ 'cwd': path,
    \ 'args': base_args,
    \ 'errorformat': '%I%f:%l:%c:%m'
    \ }])
  let @/ = matchstr(a:search, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
  call feedkeys(":let &hlsearch=1 \| echo \<CR>", "n")
endfunction
command! -nargs=* Ag call NeoAg(<q-args>)
command! -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!
command! -nargs=+ -complete=file -bar Gr silent! grep! <args>|cwindow|redraw!

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:neomake_javascript_enabled_makers = []

let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

if findfile('.flowconfig', '.;') !=# ''
  let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))
  if g:flow_path != 'flow not found'
    let g:neomake_javascript_flow_maker = {
          \ 'exe': 'sh',
          \ 'args': ['-c', g:flow_path . ' --json 2> /dev/null | flow-vim-quickfix'],
          \ 'errorformat': '%E%f:%l:%c\,%n: %m',
          \ 'cwd': '%:p:h' 
          \ }
    let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + ['flow']
  endif
endif

" }


" rainbowpairs {
 let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
 let g:rainbow#blacklist = [239, 240, 244, 245, 248, 250, 223, 229, 224]
" }

" jsDoc {
let g:jsdoc_enable_es6 = 1
" }

" toggle-words {
"switches ' and ' to ' or '
"let g:toggle_words_dict = {
"\   "python": [
"\     [toggle_words#word('and'), toggle_words#word('or')],
"\   ],
"\   "javascript": [
"\      ['if (', 'else if (', 'else '],
"\      ['import', 'export'],
"\      [['\.to\.\(not\)\@!', '\.to\.'], ['\.to\.not\.', '\.to\.not\.']],
"\      ['&&', '||'],
"\      ['const', 'let'],
"\   ],
"\ }
"" }
"let g:toggle_words_dict['typescript'] = g:toggle_words_dict['javascript']

function! Fzf_base(prompt, source, sink, ...)

  let restOptions = exists('a:1') ? ' '.a:1 : ''

  return fzf#run(extend({
    \ 'source': a:source,
    \ 'sink*': function(a:sink),
    \ 'options': '--ansi --prompt="'.a:prompt.'> "'.
      \ ' --tiebreak=index'.restOptions,
    \ }, { 'down': '~40%' }))

endfunction

function! s:ansi(str, col, bold)
  return printf("\x1b[%s%sm%s\x1b[m", a:col, a:bold ? ';1' : '', a:str)
endfunction

for [s:c, s:a] in items({'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36})
  execute "function! s:".s:c."(str, ...)\n"
        \ "  return s:ansi(a:str, ".s:a.", get(a:, 1, 0))\n"
        \ "endfunction"
endfor

function! s:fzf_qf_sink(lines)
  let list_and_num = matchstr(a:lines[0], '\w\d\+\ ')
  if list_and_num[0] == 'c'
    call input('exe cc'.list_and_num[1:])
    exe 'cc '.list_and_num[2:]
  else
    exe 'll '.list_and_num[2:]
  endif
endfunction

function! FzfQf(location_or_quickfix)
  redir => clist_lines
  silent exe a:location_or_quickfix.'list'
  redir END
  exe a:location_or_quickfix.'close'
  let clist_split = split(clist_lines, "\n")
  let source = map(clist_split, 'printf("'.a:location_or_quickfix.':%s %s", s:yellow(v:key + 1), v:val)')
  call Fzf_base('qf', source, 's:fzf_qf_sink')
endfunction

command! FzfQf call FzfQf('c')
command! FzfLl call FzfQf('l')

" Fugitive {
function! GeditBranchFile(split, ...)	
  let branch = exists('a:1') ? a:1 : 'master'
  if a:split == 'v'
    exe 'Gvsplit '.branch.':%'
  elseif a:split == 'h'
    exe 'Gsplit '.branch.':%'
  else
    exe 'Gedit '.branch.':%'
  endif
endfunction
command! -nargs=? GeditBF call GeditBranchFile(0, <f-args>)
command! -nargs=? GvsplitBF call GeditBranchFile('v', <f-args>)
command! -nargs=? GsplitBF call GeditBranchFile('h', <f-args>)
" }

command! -nargs=1 Node echo system('cd ~/repo/js; node --print '.
  \ '"var lo; var fp; try { lo = require(\"lodash\"); fp = require(\"lodash/fp\");} '.
  \ 'catch (e) {}; '.<f-args>.'"')

let g:EasyMotion_keys = 'tnseriaodhbkvmplfuwyqsent'

let g:fzf_history_dir = '~/.fzf-history'

let g:surround_{char2nr("c")} = "/*\r*/"
let g:surround_{char2nr("C")} = "/* \r */"

let g:textobj_line_no_default_mappings = 1
call textobj#user#plugin('line', {
\   '-': {
\     'select-a': 'ass', 'select-a-function': 'textobj#line#select_a',
\     'select-i': 'iss', 'select-i-function': 'textobj#line#select_i',
\   },
\ })

let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]
