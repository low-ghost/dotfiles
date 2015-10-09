set nocompatible
set shell=/bin/zsh

call plug#begin('~/.nvim/plugged')
Plug 'altercation/vim-colors-solarized'
	"Plug 'amirh/HTML-AutoCloseTag'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'gorodinskiy/vim-coloresque'
Plug 'hail2u/vim-css3-syntax'
Plug 'heavenshell/vim-jsdoc'
Plug 'honza/vim-snippets'
	"Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'matchit.zip'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-over'
Plug 'pangloss/vim-javascript'
Plug 'powerline/fonts'
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'spf13/vim-colors'
Plug 'spf13/vim-preview'
Plug 'tacahiroy/ctrlp-funky'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'vim-scripts/restore_view.vim'
call plug#end()

if !exists("g:ycm_semantic_triggers")
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

set background=dark
filetype plugin indent on
syntax on
set mouse=a
set mousehide
scriptencoding utf-8
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000
set spell
set hidden
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"restore cursor from prev edit
function! ResCur()
	if match(bufname("%"), "term://") == -1 && line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

set backup                  " Backups are nice ...
set undofile
set undolevels=1000
set undoreload=10000

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
color solarized

set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode

set showcmd                 " Show partial commands in status line and

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 4 spaces
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.

let mapleader = "\<Space>"

map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-L> <C-w>l
map <C-H> <C-w>h

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Same for 0, home, end, etc
function! WrapRelativeMotion(key, ...)
	let vis_sel=""
	if a:0
		let vis_sel="gv"
	endif
	if &wrap
		execute "normal!" vis_sel . "g" . a:key
	else
		execute "normal!" vis_sel . a:key
	endif
endfunction

" Map g* keys in Normal, Operator-pending, and Visual+select
noremap $ :call WrapRelativeMotion("$")<CR>
noremap <End> :call WrapRelativeMotion("$")<CR>
noremap 0 :call WrapRelativeMotion("0")<CR>
noremap <Home> :call WrapRelativeMotion("0")<CR>
noremap ^ :call WrapRelativeMotion("^")<CR>
" Overwrite the operator pending $/<End> mappings from above
" to force inclusive motion with :execute normal!
onoremap $ v:call WrapRelativeMotion("$")<CR>
onoremap <End> v:call WrapRelativeMotion("$")<CR>
" Overwrite the Visual+select mode mappings from above
" to ensure the correct vis_sel flag is passed to function
vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

if has("user_commands")
	command! -bang -nargs=* -complete=file E e<bang> <args>
	command! -bang -nargs=* -complete=file W w<bang> <args>
	command! -bang -nargs=* -complete=file Wq wq<bang> <args>
	command! -bang -nargs=* -complete=file WQ wq<bang> <args>
	command! -bang Wa wa<bang>
	command! -bang WA wa<bang>
	command! -bang Q q<bang>
	command! -bang QA qa<bang>
	command! -bang Qa qa<bang>
endif

cmap Tabe tabe

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

nmap <silent> <leader>/ :set invhlsearch<CR>
nmap <silent> <leader>/ :set invhlsearch<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

nnoremap Y y$

" Easier formatting
nnoremap <silent> <leader>q gwip

map <C-e> <plug>NERDTreeTabsToggle<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
let g:vim_json_syntax_conceal = 0

" ctrlp {
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
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

"funky
	nnoremap <Leader>fu :CtrlPFunky<Cr>
"}

" TagBar {
	"nnoremap <silent> <leader>tt :TagbarToggle<CR>
"}

" Fugitive {
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
" Mnemonic _i_nteractive
nnoremap <silent> <leader>gi :Git add -p %<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>
"}
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
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest
" }
"    " YouCompleteMe {
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

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" UndoTree {
	nnoremap <Leader>u :UndotreeToggle<CR>
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
	let g:airline_theme = 'solarized'
" }
" functions {
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

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }
" }

nnoremap <leader>yt :YcmCompleter GetType<CR>
nnoremap <leader>yg :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>

" clean up status line
let g:bufferline_echo=0
set noshowmode

nnoremap <leader> :w<CR>
nnoremap <leader>f :<C-f>i

"delete buffer, keep split
nmap <silent> <leader>d :bp\|bd #<CR>

nmap ,, <Plug>(easymotion-s)

nmap ,n <Plug>(easymotion-sn)
nmap ,2 <Plug>(easymotion-s2)

nnoremap <leader>ss :s///g<Left><Left><Left><C-f>i
nnoremap <leader>sw :s/\(<C-r><C-w>\)//g<Left><Left><C-f>i
nnoremap <leader>sa :%s///g<Left><Left><Left><C-f>i

inoremap %: <Esc>A;<Esc>
nnoremap %: A;<Esc>

nnoremap <leader>l :ls<CR>:b<Space>

"nnoremap <Space><Tab> :bnext<cr>
"nnoremap <Tab><Space> :bprevious<cr>

nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

"comment
"nnoremap <leader>' ysiw'
"nnoremap <leader>] ysiw]
"nnoremap <leader>) ysiw)

"window
nnoremap <leader>wJ 10<C-w>+
nnoremap <leader>wj 5<C-w>+
nnoremap <leader>wK 10<C-w>-
nnoremap <leader>wk 5<C-w>-
nnoremap <leader>wH 10<C-w><
nnoremap <leader>wh 5<C-w><
nnoremap <leader>wL 10<C-w>>
nnoremap <leader>wl 5<C-w>>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2

nnoremap <C-t>l :tabnext<cr>
nnoremap <C-t>h :tabprevious<cr>
nnoremap <C-t>n :tabnew<cr>
nnoremap <C-t>i :tabfirst<cr>
nnoremap <C-t>I :tablast<cr>

nnoremap <leader>k :bd!<cr>

"neovim terminal
tnoremap <C-o> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>= <C-\><C-n><C-w>=
tnoremap <C-w>R <C-\><C-n><C-w>R
tnoremap <C-t>l <C-\><C-n>:tabnext<cr>
tnoremap <C-t>h <C-\><C-n>:tabprevious<cr>
tnoremap <C-t>n <C-\><C-n>:tabnew<cr>
tnoremap <C-t>i <C-\><C-n>:tabfirst<cr>
tnoremap <C-t>I <C-\><C-n>:tablast<cr>
autocmd BufWinEnter,WinEnter term://* startinsert
let g:terminal_scrollback_buffer_size=10000 "default is 1000 limit is 100000

"nerm
let s:NermPrefix = "term://" . $SHELL . "_"

function! s:NermGetBufName(toName, ...)
	if a:toName==1
		call inputsave()
		let name = input('Enter terminal name: ')
		call inputrestore()
		if a:0
			return name
		else
			return s:NermPrefix . name
		endif

	else
		if a:0
			let l:countBuf = len(g:_find_buffers_with_var("NermBuf", 1)) + 1
			return s:NermPrefix . l:countBuf
		else
			return s:NermPrefix . v:count1
		endif
	endif
endfunction

"strip prefix of buffer name
"function! s:NermStripPrefix(name)
"return substitute(a:name, s:NermPrefix, "", "");
"endfunction

"get an array of buffer numbers corresponding to terminals
function! s:NermGetTermNumbers()
	return g:_find_buffers_with_var("NermBuf", 1)
endfunction

"display list of terminals
function! s:NermDisplayTerms(termNumbers)
	return "terminals:\n\n" .
				\ join(
				\		map(
				\			a:termNumbers,
				\			'"[" . v:key . "] " . substitute(bufname(v:val), s:NermPrefix, "", "")'), "\n")
endfunction

"like :ls but for terms
function! g:NermListTerms()
	echo s:NermDisplayTerms(s:NermGetTermNumbers())
endfunction

"show a list of terminals and prompt for the number to which the user wants to
"travel. Perform a tab drop to get there
function! g:NermPrompt(...)
  if a:0 < 1
		let termNumbers = s:NermGetTermNumbers()
	else
		let termNumbers = copy(a:1)
	endif

	"have to copy termNumbers so it doesn't mutate
	call inputsave()
	let choiceNum = input(s:NermDisplayTerms(copy(termNumbers)) . "\n\nEnter terminal name: ")
	call inputrestore()
	let choice = get(termNumbers, choiceNum, 'false')
	if choice != 'false'
		execute "tab drop " . bufname(choice)
	else
		echo "\n\nSorry, that terminal doesn't exist"
	endif
endfunction

" borrowed from jeetsukumaran/vim-buffergato
" Searches for all buffers that have a buffer-scoped variable `varname`
" with value that matches the expression `expr`. Returns list of buffer
" numbers that meet the criterion.
function! g:_find_buffers_with_var(varname, expr)
	let l:results = []
	for l:bni in range(1, bufnr("$"))
		if !bufexists(l:bni)
			continue
		endif
		let l:bvar = getbufvar(l:bni, "")
		if empty(a:varname)
			call add(l:results, l:bni)
		elseif has_key(l:bvar, a:varname) && empty(a:expr)
			call add(l:results, l:bni)
		elseif has_key(l:bvar, a:varname) && l:bvar[a:varname] =~ a:expr
			call add(l:results, l:bni)
		endif
	endfor
	return l:results
endfunction

function! g:NermCreate(splitOrTab, toName)
	let bufName = s:NermGetBufName(a:toName, 'new')

	if a:splitOrTab == 'tab'
		execute "tabedit term://" . $SHELL
	elseif a:splitOrTab == 'split'
		execute "10split term://" . $SHELL
	else
		execute "vsplit term://" . $SHELL
	endif

	execute "file " . bufName . " | set nobuflisted | let b:NermBuf = 1"
endfunction

function! g:NermGoTo(toName)
	let bufName = s:NermGetBufName(a:toName, 'noprefix')
	let l:termNumbers = s:NermGetTermNumbers()
	let l:matchingNums = filter(l:termNumbers, 'bufname(v:val) =~ bufName')
	let l:matchingNames = map(l:matchingNums, 'bufname(v:val)')

	let l:lenMatch = len(l:matchingNums)

	if l:lenMatch == 1
		execute "tab drop " . l:matchingNames[0]
	elseif l:lenMatch == 0
		echo "No matching terminal buffers"
	else
		echo "More than one terminal buffer matches that name"
		call g:NermPrompt(l:matchingNums)
	endif

endfunction

nnoremap <leader>tg :<C-U>call g:NermGoTo(0)<cr>
nnoremap <leader>ts :<C-U>call g:NermCreate('split', 0)<cr>
nnoremap <leader>tt :<C-U>call g:NermCreate('tab', 0)<cr>
nnoremap <leader>tv :<C-U>call g:NermCreate('vsplit', 0)<cr>
nnoremap <leader>tng :call g:NermGoTo(1)<cr>
nnoremap <leader>tns :call g:NermCreate('split', 1)<cr>
nnoremap <leader>tnt :call g:NermCreate('tab', 1)<cr>
nnoremap <leader>tnv :call g:NermCreate('vsplit', 1)<cr>
nnoremap <leader>tl :call g:NermListTerms()<cr>
nnoremap <leader>tlp :call g:NermPrompt()<cr>
