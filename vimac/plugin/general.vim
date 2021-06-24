" vim: foldmarker={,} foldmethod=marker spell:
" Basic settings for all vim instances

" General Settings {
" Basic {
set background=dark                             " dark background
syntax on                                       " Syntax
set mouse=a                                     " Mouse support
set mousehide                                   " hide mouse while typing
scriptencoding utf-8                            " script encoding standard utf-8
set clipboard=unnamed,unnamedplus               " use unnamed clipboard when possible
set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore                         " allow for cursor beyond last character
set hidden                                      " allow switching buffer w/o saving
"set iskeyword-=.                                " '.' is an end of word designator
"set iskeyword-=#                                " '#' is an end of word designator
set iskeyword-=-                                " '-' is an end of word designator
" Neovim makes these obsolete: {
"filetype plugin indent on
set spell
"set backspace=indent,eol,start
"set autoindent
"set history=10000
"set incsearch
"set wildmenu
" }
" }

" Backups {
set backup
set undofile
set undolevels=2000
set undoreload=10000
" }

" Theme {
colorscheme gruvbox
" }

" Appearance {
set cursorline                                 " Highlight current line
highlight clear SignColumn                     " SignColumn should match background
highlight clear LineNr                         " Current line number row will have same background color in relative mode
set showcmd                                    " Show partial commands in status line and
set linespace=0                                " No extra spaces between rows
set number                                     " Line numbers on
set showmatch                                  " Show matching brackets/parenthesis
set hlsearch                                   " Highlight search terms
set winminheight=0                             " Windows can be 0 line high
set wildmode=list:longest,full                 " Command <Tab> completion, list matches, then longest common part, then all.
set foldenable                                 " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nowrap                                     " Do not wrap long lines
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
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>             " Match, to be used with %
" }

" Formatting Defaults{
set shiftwidth=2  " Use indents of 2 spaces
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
" }

" General {
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
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
" inoremap <Esc> <Esc><Esc>
" }

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

vnoremap O <Esc>O
vnoremap . :normal .<CR>
vnoremap crc :call case#selection_to_camel()<cr>
" }

" Autocmds {
" automatically change directory to buffer dir
if exists("g:gui_oni") 
  autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
endif
" always go to first line of git commit messages
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" restore cursor from prev edit {
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
" }
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,typescript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell,rust setlocal nospell
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

augroup qf
  autocmd!

  " automatically open the location/quickfix window after :make, :grep,
  " :lvimgrep and friends if there are valid locations/errors
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow

  " automatically close corresponding loclist when quitting a window
  autocmd QuitPre * if &filetype != 'qf' | silent! lclose | endif
augroup END

" Shortcuts {
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Select last pasted block
nnoremap gp `[v`]
" }

" Neovim specific incremental substitute
set inccommand=split
" Grep w/ rg
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m

set spellfile=$HOME/git/dotfiles/vimac/spell/en.utf-8.add

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

set t_ts=]2;
set t_fs=\\
set title
set titlestring=%t
exec "set titleold=".hostname()
