" vim: foldmarker={,} foldmethod=marker spell:
" Plugin specific settings

" OmniComplete {
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
" }

" Ctags {
set tags=./tags;/,~/.vimtags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
  let &tags = &tags . ',' . gitroot . '/.git/tags'
endif
" }

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
"au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
"nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" NerdTree {
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
" }

" JSON {
let g:vim_json_syntax_conceal = 0
" }

" ctrlp {
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

if executable('ag')
  let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
  let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
  let s:ctrlp_fallback = 'ack %s --nocolor -f'
else
  let s:ctrlp_fallback = 'find %s -type f'
endif
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
let g:ctrlp_user_command = {
  \ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': s:ctrlp_fallback
  \ }

let g:ctrlp_extensions = ['funky']

" }

" TagBar {
	"nnoremap <silent> <leader>tt :TagbarToggle<CR>
"}

" YouCompleteMe {
if exists('g:Completion_YouCompleteMe')
  let g:acp_enableAtStartup = 0
  " enable completion from tags
  let g:ycm_collect_identifiers_from_tags_files = 1
  " remap Ultisnips for compatibility for YCM
  let g:UltiSnipsExpandTrigger = '<C-j>'
  let g:UltiSnipsJumpForwardTrigger = '<C-j>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

  if !executable("ghcmod")
    autocmd BufWritePost *.hs GhcModCheckAndLintAsync
  endif
  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
  " Disable the neosnippet preview candidate window
  " When enabled, there can be too much visual noise
  " especially when splits are used.
  "set completeopt-=preview


  if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
  endif
  let g:ycm_semantic_triggers['typescript'] = ['.']

endif
" }

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
autocmd FileType typescript autocmd BufWritePre <buffer> let b:neomake_typescript_eslint_exe = substitute(system('PATH=$(npm bin):$PATH && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:neomake_typescript_eslint_maker = {
  \ 'exe': substitute(system('PATH=$(npm bin):$PATH && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', ''),
  \ 'args': ['-f', 'compact'],
  \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
  \ '%W%f: line %l\, col %c\, Warning - %m'
  \ }
let g:neomake_warning_sign = {
  \ 'text': '>',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '>>',
  \ 'texthl': 'ErrorMsg',
  \ }
let g:neomake_typescript_enabled_makers = ['tsc', 'eslint']
" }

" rainbowpairs {
 let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
 let g:rainbow#blacklist = [239, 240, 244, 245]
" }
