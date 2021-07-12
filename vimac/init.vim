call plug#begin('~/.local/share/nvim/plugged')
" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'sainnhe/gruvbox-material'

Plug 'norcalli/nvim-terminal.lua'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale', { 'for': 'markdown' }

" Text Object
Plug 'kana/vim-textobj-user'
"i
Plug 'kana/vim-textobj-indent'
"l (conflicts with target)
" Plug 'kana/vim-textobj-line'
"e
Plug 'kana/vim-textobj-entire'
"c
" Plug 'glts/vim-textobj-comment'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" writing
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-lexical', {'for': 'markdown'}
Plug 'reedes/vim-litecorrect', {'for': 'markdown'}
Plug 'reedes/vim-textobj-sentence', {'for': 'markdown'}
Plug 'reedes/vim-wordy', {'for': 'markdown'}
Plug 'reedes/vim-pencil', {'for': 'markdown'}

Plug 'Lokaltog/vim-easymotion'
Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'morhetz/gruvbox'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug '~/git/dotfiles/vimac'

Plug 'powerline/fonts', { 'dir': '~/fonts', 'do': './install.sh' }

Plug 'bling/vim-bufferline'
Plug 'SirVer/ultisnips'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'hail2u/vim-css3-syntax'
Plug 'honza/vim-snippets'
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-signify'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/restore_view.vim'
Plug 'wellle/targets.vim'

Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'chrisbra/Colorizer'

Plug 'ryanoasis/vim-devicons'

Plug 'low-ghost/vimax', { 'branch': 'develop' }
call plug#end()

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Not relative. Only useful with a programmed keyboard, and relative number.
nnoremap <Down> j
nnoremap <Up> k

inoremap ii <esc>

" Coc things {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB> 
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <c-p> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.') =~# '^ \+$'
endfunction

let g:ale_enabled = 0
let g:ale_pattern_options = {'.md': {'ale_enabled': 1}}

let g:coc_snippet_next = '<C-j>'
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap ge <Plug>(coc-diagnostic-next)
nmap gE <Plug>(coc-diagnostic-prev)
nmap gd <Plug>(coc-definition)
nmap gsd :call CocAction('jumpDefinition', 'vsplit')<cr>
nmap gSd :call CocAction('jumpDefinition', 'split')<cr>
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap gC <Plug>(coc-codelens-action)
nmap <space>gj <Plug>(coc-float-jump)
nmap <space>gh <Plug>(coc-float-hide)

nmap <Space>yn <Plug>(coc-rename)
nnoremap <Space>yd :<C-u>CocList -A diagnostics<cr>
" potential replacement for fr
nnoremap <Space>yr :<C-u>CocList -A mru<cr>
nmap <Space>yf <Plug>(coc-fix-current)

vmap <Space>f <Plug>(coc-format-selected)
xmap <Space>f <Plug>(coc-format-selected)

" Use K to show documentation in preview window
nnoremap K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocAction('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <Space>k <Plug>(coc-diagnostic-info)
nmap <Space>do <Plug>(coc-codeaction)
vmap <Space>do <Plug>(coc-codeaction-selected)
nmap <Space>fm :CocCommand workspace.renameCurrentFile<CR>

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 Format :call CocAction('format')
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Rename :CocCommand workspace.renameCurrentFile
command! -nargs=0 SortImports :call CocAction('runCommand', 'editor.action.organizeImport')

autocmd CursorHold * silent call CocActionAsync('highlight')
"}}}

"Last window {{{
tnoremap <C-p> <C-\><C-n><C-w>p
nnoremap <C-p> <C-w>p
"}}}

"Neovim terminal {{{
tnoremap <C-o> <C-\><C-n>
tnoremap <C-o>x <C-\><C-n>:bd!<cr>
tnoremap <C-o><C-x> <C-\><C-n>:bd!<cr>
tnoremap <C-o>z <C-\><C-n>:ZoomToggle<cr>
tnoremap <C-o><C-z> <C-\><C-n>:ZoomToggle<cr>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
"found this to be too annoying if accidentally landing on buffer
"autocmd BufWinEnter,WinEnter term://* startinsert
let g:terminal_scrollback_buffer_size=10000 "default is 1000 limit is 100000
" }}}
"
" Tabs {{{
nnoremap <C-t>l :tabnext<cr>
nnoremap <C-t>h :tabprevious<cr>
nnoremap <C-t>n :tabnew<cr>
nnoremap <C-t>i :tabfirst<cr>
nnoremap <C-t>I :tablast<cr>
nnoremap <C-t>x :tabclose<cr>
tnoremap <C-t>l <C-\><C-n>:tabnext<cr>
tnoremap <C-t>h <C-\><C-n>:tabprevious<cr>
tnoremap <C-t>n <C-\><C-n>:tabnew<cr>
tnoremap <C-t>i <C-\><C-n>:tabfirst<cr>
tnoremap <C-t>I <C-\><C-n>:tablast<cr>
tnoremap <C-t>x <C-\><C-n>:tabclose<cr>
" }}}

" WrapRelative {{{
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
" }}}

" Search {{{
map <Space><Space> <Plug>(easymotion-s)
map ,, <Plug>(easymotion-s)
map <Space>// <Plug>(easymotion-s)
map <Space>/2 <Plug>(easymotion-s2)
map <Space>/B <Plug>(easymotion-B)
map <Space>/E <Plug>(easymotion-E)
map <Space>/F <Plug>(easymotion-F)
map <Space>/T <Plug>(easymotion-T)
map <Space>/W <Plug>(easymotion-W)
map <Space>/b <Plug>(easymotion-b)
map <Space>/e <Plug>(easymotion-e)
map <Space>/f <Plug>(easymotion-f)
map <Space>/gE <Plug>(easymotion-gE)
map <Space>/ge <Plug>(easymotion-ge)
map <Space>/j <Plug>(easymotion-j)
map <Space>/k <Plug>(easymotion-k)
map <Space>/n <Plug>(easymotion-sn)
map <Space>/t <Plug>(easymotion-t)
map <Space>/w <Plug>(easymotion-w)
map <Space>/<space> <Plug>(easymotion-overwin-f)
omap z <Plug>(easymotion-t)
omap Z <Plug>(easymotion-T)
omap x <Plug>(easymotion-f)
omap X <Plug>(easymotion-F)
omap <Space> <Plug>(easymotion-prefix)
" List matching words and go to one. TODO: fzf-ize. Looks like:
" function ListInstances()
" redir => lines
" silent exe "normal! [I"
" redir END
" fzf lines
" endfunction
" possibly do silent bufdo
nnoremap <Space>/g [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" }}}

nnoremap <Space>r :Rg<CR>
nnoremap <Space>/r :Gr <C-r><C-w><CR>

" Applications (a is also alignment, watch for conflicts) {{{
nnoremap <Space>aj <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
nnoremap <Space>au :MundoToggle<CR>
"TODO normal mode accepting range
vnoremap <Space>as :sort<CR>
"t for template
nnoremap <Space>ato :CocCommand snippets.openSnippetFiles<CR>
nnoremap <Space>atn :CocCommand snippets.editSnippets<CR>
nnoremap <Space>ate :UltiSnipsEdit<CR>
nnoremap <Space>at/ :Snippets<CR>

" Windows {{{
nnoremap <Space>wd :hide<cr>;
"resize
nnoremap <Space>wJ :<C-U>call util#count_command('resize +', 10, 1)<CR>
nnoremap <Space>wK :<C-U>call util#count_command('resize -', 10, 1)<CR>
nnoremap <Space>wH :<C-U>call util#count_command('vertical resize +', 10, 1)<CR>
nnoremap <Space>wL :<C-U>call util#count_command('vertical resize -', 10, 1)<CR>
nnoremap <Space>w= <C-W>=
nnoremap <Space>wz :ZoomToggle<CR>
"split
nnoremap <Space>ws <C-W>s:bn<CR>
nnoremap <Space>wv <C-W>v:bn<CR>
nnoremap <Space>wt <C-W>v:term<CR>i
nnoremap <Space>wT <C-W>s:term<CR>i
"only
nnoremap <Space>wo :only<CR>
"rotate
nnoremap <Space>wrk <C-w>K
nnoremap <Space>wrh <C-w>H
nnoremap <Space>wrl <C-w>L
nnoremap <Space>wrj <C-w>J
"rotate all
nnoremap <Space>wrak :windo wincmd K<CR>
nnoremap <Space>wrah :windo wincmd H<CR>
"close all extraneous windows
nnoremap <Space>wc :lclose\|cclose\|pclose\|helpclose\|NERDTreeClose\|call coc#float#close_all()<CR>
nnoremap <Space>wC :windo lclose\|windo cclose\|windo pclose\|helpclose\|NERDTreeClose<CR>
" }}}

" Toggle {{{
nnoremap <Space>t/ :set invhlsearch<CR>
nnoremap <Space>tb :call ToggleBG()<CR>
nnoremap <Space>tc :Colors<CR>
nnoremap <Space>tg :SignifyToggle<CR>
nnoremap <Space>the :call ToggleEndColumn()<CR>
nnoremap <Space>thc :set cursorcolumn!<CR>
"show syntax info for character under cursor
nnoremap <Space>thi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nnoremap <Space>thl :set cursorline!<CR>
nnoremap <Space>thp :call TogglePosition()<CR>
nnoremap <Space>tl :call ToggleHiddenAll()<CR>
nnoremap <Space>tn :set nu!<CR>
nnoremap <Space>tN :set relativenumber!<CR>
nnoremap <Space>tp :RainbowParentheses!!<CR>
nnoremap <Space>tsp :set spell!<CR>
nnoremap <Space>tsy :call ToggleSyntax()<CR>
nnoremap <Space>tlw :call ToggleWrap()<CR>
nnoremap <Space>tw :Goyo<CR>
"nmap <Space>tw :ToggleWord<CR>
"nmap <Space>tW :ToggleWordReverse<CR>
" }}}

" Git (fugitive) {{{
nnoremap <Space>gW :Gwrite!<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gc :Gcommit<CR>
nnoremap <Space>gd :Gdiff<CR>
nnoremap <Space>gdp :diffput<CR>
nnoremap <Space>gdb :Gdiff<Space>
nnoremap <Space>ge :Gedit<CR>
nnoremap <Space>gf /\v^[<\|=>]{7}( .*\|$)<CR>
nnoremap <Space>gg :Ggrep<Space>
nnoremap <Space>gi :Git add -p %<CR>
nnoremap <Space>gl :Glog<CR>
nnoremap <Space>gm :Git mergetool<CR>
nnoremap <Space>gp :Git push<CR>
nnoremap <Space>gr :Gread<CR>
nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>gw :Gwrite<CR>
" }}}

" Dir {{{
nnoremap <Space>dr :call SaveLastDir()<CR>:lcd `git rev-parse --show-toplevel`<CR>:echo getcwd()<CR>
nnoremap <Space>ds :echo getcwd()<CR>
nnoremap <Space>df :call SaveLastDir()<CR>:lcd %:p:h<CR>:echo getcwd()<CR>
"TODO: make du accept a count as in 2du would exe cd ../../
nnoremap <Space>du :call SaveLastDir()<CR>:cd ../<CR>:echo getcwd()<CR>
nnoremap <Space>dc :call SaveLastDir()<CR>:cd
"TODO: maybe maintain a stack of 5 or so and d- moves back in stack, d+ moves
"forward?
nnoremap <Space>d- :exe "cd " . g:last_changed_dir<CR>:echo getcwd()<CR>
" }}}

" Buffers {{{
"both delete accept count to specify buffer
nnoremap <Space>bd :lclose\|cclose\|pclose<CR>:bp\|bd #<CR>
nnoremap <Space>bD :lclose\|cclose\|pclose<CR>:bp\|bd! #<CR>
nnoremap <Space>BD :lclose\|cclose\|pclose<CR>:bp\|bd! #<CR>
"delete or keep buffers matching a string
nnoremap <Space>bmd :call buffer#by_match(v:true)<CR>
nnoremap <Space>bmo :call buffer#by_match(v:false)<CR>
"BOnly will not kill buffers w/ unsaved content
nnoremap <Space>bo :call buffer#only(v:null, '')<CR>
nnoremap <Space>bO :call buffer#only(v:null, v:true)<CR>
"TODO filter current
nnoremap <Space>b/ :Buffers<CR>
"bp/h and bn/l accept count
nnoremap <Space>bp :<C-U> call util#count_command('bprev')<CR>
nnoremap <Space>bh :<C-U> call util#count_command('bprev')<CR>
nnoremap <Space>bH :bfirst<CR>
nnoremap <Space>bn :<C-U> call util#count_command('bnext')<CR>
nnoremap <Space>bl :<C-U> call util#count_command('bnext')<CR>
nnoremap <Space>bL :blast<CR>
"copy entire buffer
nnoremap <Space>by gg"+yG<CR>
nnoremap <Space>bY gg"+yG<CR>
"replace entire buffer with register
"TODO accept register
nnoremap <Space>bP gg"_dGp<CR>
nnoremap <Space>br :e! %<CR>
"TODO get to work
nnoremap <Space>bR :call buffer#refresh_all()<CR>
"go to buffer
nnoremap <Space>bg :<C-U>call util#count_command('b')<CR>
"buffer toggle
nnoremap <Space>bt :b#<CR>
" }}}

" QuickFix and Location {{{
" for now, close both quickfix and location on close map
nnoremap <Space>cc :cclose<CR>
nnoremap <Space>cC :windo cclose<CR>
nnoremap <Space>co :<C-U>call util#count_command('copen', 7)<CR>
nnoremap <Space>cn :<C-U>call util#count_command('cnext')<CR>
nnoremap <Space>cp :<C-U>call util#count_command('cprev')<CR>
nnoremap <Space>cl :<C-U>call util#count_command('cnewer')<CR>
nnoremap <Space>ch :<C-U>call util#count_command('colder')<CR>
nnoremap <Space>c/ :CocList -A quickfix<CR>
nnoremap <Space>cg :<C-U>call util#count_command('cc')<CR>
nnoremap <Space>lc :lclose<CR>
nnoremap <Space>lC :windo lclose<CR>
nnoremap <Space>lo :<C-U>call util#count_command('lopen', 7)<CR>
nnoremap <Space>ln :<C-U>call util#count_command('lnext')<CR>
nnoremap <Space>lp :<C-U>call util#count_command('lprev')<CR>
nnoremap <Space>ll :<C-U>call util#count_command('lnewer')<CR>
nnoremap <Space>lh :<C-U>call util#count_command('lolder')<CR>
nnoremap <Space>l/ :CocList -A locationlist<CR>
nnoremap <Space>lg :<C-U>call util#count_command('ll')<CR>
" }}}

" Files {{{
nnoremap <Space><CR> :w<CR>
nnoremap <Space>f/ :GitFiles<CR>
nnoremap <Space>f? :Files<CR>
nnoremap <Space>fr :History<CR>
nnoremap <Space>fw :silent w !sudo tee % > /dev/null<CR>
" }}}
"
command! -nargs=+ FindFile call find#file(<f-args>)



let g:mapleader = ','
"Spacemacs style keys {{{

" Commands {{{
nnoremap <Space>x q:
nnoremap <Space>/x :History :<CR>
" }}}

" File {{{
map <C-e> :NERDTreeToggle<CR>
nnoremap <Space>fev :e $MYVIMRC<CR>
nnoremap <Space>feo :e ~/git/dotfiles/vimac/<CR>
nnoremap <Space>feft :call filetype#edit_ft_plugin()<CR>
nnoremap <Space>flft :call filetype#source_ft_plugin()<CR>
nnoremap <Space>flr :call system("tmux source-file ~/.tmux.conf")<CR>
nnoremap <Space>flv :source $MYVIMRC<CR>
nnoremap <Space>fn :NERDTreeFind<CR>
nnoremap <space>fi :let g:NERDTreeIgnore = ['
nnoremap <Space>ft :call EditTestFile('e')<CR>
nnoremap <Space>fst :call EditTestFile('s')<CR>
nnoremap <Space>fvt :call EditTestFile('v')<CR>
" }}}


" Insert {{{
" TODO: visual support
call util#nvmap('ij', ':<C-U>call line#append(v:count1, v:false)<CR>')
call util#nvmap('io', ':<C-U>call line#append(v:count1, v:true)<CR>')
call util#nvmap('ik', ':<C-U>call line#prepend(v:count1, v:false)<CR>')
call util#nvmap('iO', ':<C-U>call line#prepend(v:count1, v:true)<CR>')
nnoremap <Space>ib :<C-U>call line#append_and_prepend(v:count1, v:false)<CR>
vnoremap <Space>ib :<C-U>call line#append_and_prepend(v:count1, v:true)<CR>
" }}}
"
" Substitute {
" Each sub set defines sequences like <Space>s<additional><range><key>
" such that '<Space>sas' means sub all standard, or '<Space>scaw' means sub
" all with correct flag for current word under cursor. See sub.vim for more
" details. Probably shouldn't use f, c, a, or e as the additional because
" they're the excepted ranges
" Sub standard - s
call sub#make_set('s', '')
call sub#make_set_upper('s', '')
" Word - w
call sub#make_set('w', '\(<C-r><C-w>\)')
call sub#make_set_upper('w', '<C-r><C-w>')
" Search - /
call sub#make_set('/', '\(<C-r>/\)')
call sub#make_set_upper('/', '<C-r>/')
" Register - '
call sub#make_set("'", '\(<C-r>"\)')
call sub#make_set_upper("'", '<C-r>"')
" Last - l
call sub#make_set('l', '')
call sub#make_set_upper('l', '')
" }

" Alignment {
" simple {
call util#nvmap('a"', ':Tabularize /"<CR>')
call util#nvmap("a'", ":Tabularize /'<CR>")
call util#nvmap('a&', ':Tabularize /&<CR>')
call util#nvmap('a,', ':Tabularize /,<CR>')
call util#nvmap('a=>', ':Tabularize /=><CR>')
call util#nvmap('a:', ':Tabularize /:<CR>')
" }
call util#nvmap('a::', ':Tabularize /:\zs<CR>')
call util#nvmap('a,,', ':Tabularize /,\zs<CR>')
call util#nvmap('a=', ':Tabularize /^[^=]*\zs=<CR>')
call util#nvmap('a<Bar>', ':Tabularize /<Bar><CR>')
call util#nvmap('ac', ':Tabularize /')
" }

" Moving text {
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv
" }

" Folding {
nnoremap <Space>f0 :set foldlevel=0<CR>
nnoremap <Space>f1 :set foldlevel=1<CR>
nnoremap <Space>f2 :set foldlevel=2<CR>
nnoremap <Space>f3 :set foldlevel=3<CR>
nnoremap <Space>f4 :set foldlevel=4<CR>
nnoremap <Space>f5 :set foldlevel=5<CR>
nnoremap <Space>f6 :set foldlevel=6<CR>
nnoremap <Space>f7 :set foldlevel=7<CR>
nnoremap <Space>f8 :set foldlevel=8<CR>
nnoremap <Space>f9 :set foldlevel=9<CR>
" }

" Marks and registers {
nnoremap <Space>'/ :Marks<CR>
nnoremap c<Space> "_c
nnoremap d<Space> "_d
" }

" Mappings helper {
nnoremap <Space><Space>/ :Maps<CR>
nnoremap <Space><Space><Space> :Maps<CR>'space>
" }

vnoremap <Space>r c<C-O>:set ri<CR><C-R>"<Esc>:set nori<CR>

" autoclose for multiline only {
" inoremap [<CR> [<CR>]<Esc>ko
" inoremap [; [<CR>];<Esc>ko
" inoremap [, [<CR>],<Esc>ko
" inoremap {<CR> {<CR>}<Esc>ko
" inoremap {; {<CR>};<Esc>ko
" inoremap {, {<CR>},<Esc>ko
" inoremap {)<CR> {<CR>});<Esc>ko
" inoremap ({<CR> ({<CR>})<Esc>ko
" inoremap ({; ({<CR>});<Esc>ko
" inoremap ([<CR> ([<CR>])<Esc>ko
" inoremap ([; ([<CR>]);<Esc>ko
"}

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

command! -nargs=0 DelMarks :delm A-Z

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@comment.outer",
        ["ic"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<space>np"] = "@parameter.inner",
      },
      swap_previous = {
        ["<space>nP"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = false,
    },
  },
}

require'treesitter-context.config'.setup{
    enable = true,
}

require'terminal'.setup()
EOF

let g:python3_host_prog="/usr/local/bin/python3"
