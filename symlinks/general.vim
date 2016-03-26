" vim: foldmarker={,} foldmethod=marker spell:
" Basic settings for all vim instances

" General Settings {
" Basic {
set background=dark                             " dark background
filetype plugin indent on                       " Automatically detect file types
syntax on                                       " Syntax
set mouse=a                                     " Mouse support
set mousehide                                   " hide mouse while typing
scriptencoding utf-8                            " script encoding standard utf-8
set clipboard=unnamed,unnamedplus               " use unnamed clipboard when possible
set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore                         " allow for cursor beyond last character
set history=2000                                " a ton of history
set spell                                       " spell checking on
set hidden                                      " allow switching buffer w/o saving
set iskeyword-=.                                " '.' is an end of word designator
set iskeyword-=#                                " '#' is an end of word designator
set iskeyword-=-                                " '-' is an end of word designator
" }

" Backups {
set backup
set undofile
set undolevels=2000
set undoreload=10000
" }

" Theme {
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
" }

" Appearance {
set cursorline                                 " Highlight current line
highlight clear SignColumn                     " SignColumn should match background
highlight clear LineNr                         " Current line number row will have same background color in relative mode
set showcmd                                    " Show partial commands in status line and
set linespace=0                                " No extra spaces between rows
set number                                     " Line numbers on
set showmatch                                  " Show matching brackets/parenthesis
set incsearch                                  " Find as you type search
set hlsearch                                   " Highlight search terms
set winminheight=0                             " Windows can be 0 line high
set wildmenu                                   " Show list instead of just completing
set wildmode=list:longest,full                 " Command <Tab> completion, list matches, then longest common part, then all.
set foldenable                                 " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nowrap                                     " Do not wrap long lines
set autoindent                                 " Indent at the same level of the previous line
set diffopt+=vertical                          " vertical diffs
" clean up status line
let g:bufferline_echo=0
set noshowmode
" }

" Behavior {
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
"set matchpairs+=<:>            " Match, to be used with %
" }

" Formatting Defaults{
set shiftwidth=2  " Use indents of 4 spaces
set tabstop=2     " An indentation every four columns
set softtabstop=2 " Let backspace delete indent
set expandtab     " Spaces instead of tabs
" }
" }

" Fixes {
" WrapRelativeMotion {
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
" }

" Capitalization errors {
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
cmap Tabe tabe
" }

" Quickfix {
"autocmd qf BufEnter <buffer> if winnr('$') < 2 | q | endif " quit if qf is the last buffer
autocmd FileType qf set nobuflisted " don't put the qf window in buffer list
" }

" General {
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
set backspace=indent,eol,start  " Backspace for dummies
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
" Wrapped lines goes down/up to next row, rather than next line in file
noremap j gj
noremap k gk
" Easier horizontal scrolling
map zl zL
map zh zH
" Y acts like everything else
nnoremap Y y$
"fixes a few bugs
inoremap <Esc> <Esc><Esc>
" }
" }

" Autocmds {
" automatically change directory to buffer dir
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" always go to first line of git commit messages
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" restore cursor from prev edit {
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
" }
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell,rust setlocal nospell
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

" Shortcuts {
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Select last pasted block
nnoremap gp `[v`]
" }
