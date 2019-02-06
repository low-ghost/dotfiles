let g:fzf_command_prefix = 'Fzf'
let g:vimax_tmux_py_enabled = 0

let g:javascript_conceal_NaN = "ℕ"
let g:javascript_plugin_flow = 1

call plug#begin('~/.nvim/plugged')

" Not currently used {{{
"Plug 'altercation/vim-colors-solarized'
"Plug 'amirh/HTML-AutoCloseTag'
"Plug 'jiangmiao/auto-pairs'
"Plug 'flazz/vim-colorschemes'
"Plug 'rking/ag.vim'
"Plug 'edkolev/tmuxline.vim'
"Plug 'edkolev/promptline.vim'
"Plug 'gorodinskiy/vim-coloresque'
"Plug 'MarcWeber/vim-addon-local-vimrc'
" }}}

" Text Object {{{
Plug 'kana/vim-textobj-user'
"i
Plug 'kana/vim-textobj-indent'
"l
" Plug 'kana/vim-textobj-line'
"e
Plug 'kana/vim-textobj-entire'
"c
Plug 'glts/vim-textobj-comment'
" }}}

Plug 'Lokaltog/vim-easymotion'
" FZF {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'morhetz/gruvbox'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/rhubarb'
" GraphQl {{{
Plug 'jparise/vim-graphql'
" }}}

Plug '~/repo/dotfiles/vim'

filetype plugin indent on

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

vnoremap O <Esc>O
vnoremap . :normal .<CR>
vnoremap crc :call case#selection_to_camel()<cr>

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
noremap <silent> $ :call WrapRelativeMotion("$")<CR>
noremap <silent> <End> :call WrapRelativeMotion("$")<CR>
noremap <silent> 0 :call WrapRelativeMotion("0")<CR>
noremap <silent> <Home> :call WrapRelativeMotion("0")<CR>
noremap <silent> ^ :call WrapRelativeMotion("^")<CR>
" Overwrite the operator pending $/<End> mappings from above
" to force inclusive motion with :execute normal!
onoremap <silent> $ v:call WrapRelativeMotion("$")<CR>
onoremap <silent> <End> v:call WrapRelativeMotion("$")<CR>
" Overwrite the Visual+select mode mappings from above
" to ensure the correct vis_sel flag is passed to function
vnoremap <silent> $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <silent> <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <silent> 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <silent> <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <silent> ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
" }}}

" Search {{{
map <Space><Space> <Plug>(easymotion-s)
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
nnoremap <silent> <Space>/g [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
nnoremap <silent> <Space>/a :Ag <C-r><C-w><CR>
" }}}

" Applications (a is also alignment, watch for conflicts) {{{
nnoremap <silent> <Space>aj <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
nnoremap <silent> <Space>au :MundoToggle<CR>
"TODO normal mode accepting range
vnoremap <silent> <Space>as :sort<CR>
"t for template
nnoremap <silent> <Space>ate :UltiSnipsEdit<CR>
nnoremap <silent> <Space>at/ :FzfSnippets<CR>
"e for execute
nnoremap <silent> <Space>aeo :IShell<CR>
nnoremap <silent> <Space>aei :IShell<Space>
nnoremap <silent> <Space>ae<space> :Shell<Space>
" Plugins {
" TODO: generic functions
nnoremap <silent> <Space>api :PlugInstall<CR>
nnoremap <silent> <Space>apc :PlugClean<CR>
nnoremap <silent> <Space>apu :PlugUpdate<CR>
nnoremap <silent> <Space>apU :PlugUpgrade<CR>
nnoremap <silent> <Space>aps :PlugStatus<CR>
nnoremap <silent> <Space>apr :UpdateRemotePlugins<CR>
" }
" nnoremap <silent> <Space>am :Neomake<CR>
" nnoremap <silent> <Space>amd :NeomakeDisable<CR>
" nnoremap <silent> <Space>ame :NeomakeEnable<CR>
" nnoremap <silent> <Space>amt :NeomakeToggle<CR>
" }
" }}}

" Windows {{{
nnoremap <silent> <Space>wd :hide<cr>;
"resize
nnoremap <silent> <Space>wJ :<C-U>call util#count_command('resize +', 10, 1)<CR>
nnoremap <silent> <Space>wK :<C-U>call util#count_command('resize -', 10, 1)<CR>
nnoremap <silent> <Space>wH :<C-U>call util#count_command('vertical resize +', 10, 1)<CR>
nnoremap <silent> <Space>wL :<C-U>call util#count_command('vertical resize -', 10, 1)<CR>
nnoremap <silent> <Space>w= <C-W>=
nnoremap <silent> <Space>wz :ZoomToggle<CR>
"split
nnoremap <silent> <Space>ws <C-W>s:bn<CR>
nnoremap <silent> <Space>wv <C-W>v:bn<CR>
"only
nnoremap <silent> <Space>wo :only<CR>
"rotate
nnoremap <silent> <Space>wrk <C-w>K
nnoremap <silent> <Space>wrh <C-w>H
nnoremap <silent> <Space>wrl <C-w>L
nnoremap <silent> <Space>wrj <C-w>J
"rotate all
nnoremap <silent> <Space>wrak :windo wincmd K<CR>
nnoremap <silent> <Space>wrah :windo wincmd H<CR>
"close all extraneous windows
nnoremap <silent> <Space>wc :lclose\|cclose\|pclose\|helpclose\|NERDTreeClose<CR>
nnoremap <silent> <Space>wC :windo lclose\|windo cclose\|windo pclose\|helpclose\|NERDTreeClose<CR>
" }}}

" Toggle {{{
nnoremap <silent> <Space>t/ :set invhlsearch<CR>
nnoremap <silent> <Space>tb :call ToggleBG()<CR>
nnoremap <silent> <Space>tc :FzfColors<CR>
nnoremap <silent> <Space>tg :SignifyToggle<CR>
nnoremap <silent> <Space>the :call ToggleEndColumn()<CR>
nnoremap <silent> <Space>thc :set cursorcolumn!<CR>
"show syntax info for character under cursor
nnoremap <silent> <Space>thi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nnoremap <silent> <Space>thl :set cursorline!<CR>
nnoremap <silent> <Space>thp :call TogglePosition()<CR>
nnoremap <silent> <Space>tl :call ToggleHiddenAll()<CR>
nnoremap <silent> <Space>tn :set nu!<CR>
nnoremap <silent> <Space>tN :set relativenumber!<CR>
nnoremap <silent> <Space>tp :RainbowParentheses!!<CR>
nnoremap <silent> <Space>tsp :set spell!<CR>
nnoremap <silent> <Space>tsy :call ToggleSyntax()<CR>
"toggle line wrap
nnoremap <silent> <Space>tlw :call ToggleWrap()<CR>
"nmap <silent> <Space>tw :ToggleWord<CR>
"nmap <silent> <Space>tW :ToggleWordReverse<CR>
" }}}

" Git (fugitive) {{{
nnoremap <silent> <Space>gW :Gwrite!<CR>
nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gc :Gcommit<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>
nnoremap <silent> <Space>gdp :diffput<CR>
nnoremap <silent> <Space>gdb :Gdiff<Space>
nnoremap <silent> <Space>ge :Gedit<CR>
nnoremap <silent> <Space>gf /\v^[<\|=>]{7}( .*\|$)<CR>
nnoremap <silent> <Space>gg :Ggrep<Space>
nnoremap <silent> <Space>gi :Git add -p %<CR>
nnoremap <silent> <Space>gl :Glog<CR>
nnoremap <silent> <Space>gm :Gmerge<CR>
nnoremap <silent> <Space>gp :Git push<CR>
nnoremap <silent> <Space>gr :Gread<CR>
nnoremap <silent> <Space>gs :Gstatus<CR>
nnoremap <silent> <Space>gw :Gwrite<CR>
" }}}

" Dir {{{
nnoremap <silent> <Space>dr :call SaveLastDir()<CR>:lcd `git rev-parse --show-toplevel`<CR>:echo getcwd()<CR>
nnoremap <silent> <Space>ds :echo getcwd()<CR>
nnoremap <silent> <Space>df :call SaveLastDir()<CR>:lcd %:p:h<CR>:echo getcwd()<CR>
"TODO: make du accept a count as in 2du would exe cd ../../
nnoremap <silent> <Space>du :call SaveLastDir()<CR>:cd ../<CR>:echo getcwd()<CR>
nnoremap <silent> <Space>dc :call SaveLastDir()<CR>:cd
"TODO: maybe maintain a stack of 5 or so and d- moves back in stack, d+ moves
"forward?
nnoremap <silent> <Space>d- :exe "cd " . g:last_changed_dir<CR>:echo getcwd()<CR>
" }}}

" Buffers {{{
"both delete accept count to specify buffer
nnoremap <silent> <Space>bd :lclose\|cclose\|pclose<CR>:bp\|bd #<CR>
nnoremap <silent> <Space>bD :lclose\|cclose\|pclose<CR>:bp\|bd! #<CR>
nnoremap <silent> <Space>BD :lclose\|cclose\|pclose<CR>:bp\|bd! #<CR>
"delete or keep buffers matching a string
nnoremap <silent> <Space>bmd :call buffer#by_match(v:true)<CR>
nnoremap <silent> <Space>bmo :call buffer#by_match(v:false)<CR>
"BOnly will not kill buffers w/ unsaved content
nnoremap <silent> <Space>bo :call buffer#only(v:null, '')<CR>
nnoremap <silent> <Space>bO :call buffer#only(v:null, v:true)<CR>
"TODO filter current
nnoremap <silent> <Space>b/ :FzfBuffers<CR>
"bp/h and bn/l accept count
nnoremap <silent> <Space>bp :<C-U> call util#count_command('bprev')<CR>
nnoremap <silent> <Space>bh :<C-U> call util#count_command('bprev')<CR>
nnoremap <silent> <Space>bH :bfirst<CR>
nnoremap <silent> <Space>bn :<C-U> call util#count_command('bnext')<CR>
nnoremap <silent> <Space>bl :<C-U> call util#count_command('bnext')<CR>
nnoremap <silent> <Space>bL :blast<CR>
"copy entire buffer
nnoremap <silent> <Space>by gg"+yG<CR>
nnoremap <silent> <Space>bY gg"+yG<CR>
"replace entire buffer with register
"TODO accept register
nnoremap <silent> <Space>bP gg"_dGp<CR>
nnoremap <silent> <Space>br :e! %<CR>
"TODO get to work
nnoremap <silent> <Space>bR :call buffer#refresh_all()<CR>
"go to buffer
nnoremap <silent> <Space>bg :<C-U>call util#count_command('b')<CR>
"buffer toggle
nnoremap <silent> <Space>bt :b#<CR>
" }}}

" QuickFix and Location {{{
" for now, close both quickfix and location on close map
nnoremap <silent> <Space>cc :cclose<CR>
nnoremap <silent> <Space>cC :windo cclose<CR>
nnoremap <silent> <Space>co :<C-U>call util#count_command('copen', 7)<CR>
nnoremap <silent> <Space>cn :<C-U>call util#count_command('cnext')<CR>
nnoremap <silent> <Space>cp :<C-U>call util#count_command('cprev')<CR>
nnoremap <silent> <Space>cl :<C-U>cacl util#count_command('cnewer')<CR>
nnoremap <silent> <Space>ch :<C-U>call util#count_command('colder')<CR>
nnoremap <silent> <Space>c/ :FzfQf<CR>
nnoremap <silent> <Space>cg :<C-U>call util#count_command('cc')<CR>
nnoremap <silent> <Space>lc :lclose<CR>
nnoremap <silent> <Space>lC :windo lclose<CR>
nnoremap <silent> <Space>lo :<C-U>call util#count_command('lopen', 7)<CR>
nnoremap <silent> <Space>ln :<C-U>call util#count_command('lnext')<CR>
nnoremap <silent> <Space>lp :<C-U>call util#count_command('lprev')<CR>
nnoremap <silent> <Space>ll :<C-U>call util#count_command('lnewer')<CR>
nnoremap <silent> <Space>lh :<C-U>call util#count_command('lolder')<CR>
nnoremap <silent> <Space>l/ :FzfLl<CR>
nnoremap <silent> <Space>lg :<C-U>call util#count_command('ll')<CR>
" }}}

" Files {{{
nnoremap <silent> <Space><CR> :w<CR>
nnoremap <silent> <Space>f/ :FzfGitFiles<CR>
nnoremap <silent> <Space>f? :FzfFiles<CR>
nnoremap <silent> <Space>fr :FzfHistory<CR>
nnoremap <silent> <Space>fw :silent w !sudo tee % > /dev/null<CR>
" }}}
"
command! -nargs=+ FindFile call find#file(<f-args>)


if exists("g:gui_oni") 
  tnoremap <Esc> <Esc>
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l
  nnoremap <C-k> <C-w>k
  nnoremap <C-j> <C-w>j
  call plug#end()
else
  set nocompatible
  set shell=/bin/zsh

  "All plugins
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'SirVer/ultisnips'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'bling/vim-bufferline'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'elzr/vim-json'
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
  Plug 'hail2u/vim-css3-syntax'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'honza/vim-snippets'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'low-ghost/vim-macro-manager'
  Plug 'low-ghost/vimax'
  Plug 'machakann/vim-highlightedyank'
  Plug 'majutsushi/tagbar'
  "Plug 'matchit.zip'
  Plug 'mbbill/undotree'
  Plug 'mhinz/vim-signify'
  Plug 'mxw/vim-jsx'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'pangloss/vim-javascript'
  Plug 'powerline/fonts', { 'dir': '~/fonts', 'do': './install.sh' }
  Plug 'scrooloose/nerdtree'
  Plug 'spf13/vim-colors'
  Plug 'spf13/vim-preview'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/restore_view.vim'
  Plug 'wellle/targets.vim'
  Plug 'vim-scripts/SyntaxComplete'
  Plug 'vimwiki/vimwiki'
  " Python {{{
  Plug 'hdima/python-syntax', { 'for': 'python' }
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }
  Plug 'davidhalter/jedi-vim', { 'for': 'python' }
  Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
  " }}}
  " Javascript {{{
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': [ 'javascript', 'javascript.jsx' ] }
  Plug 'carlitux/deoplete-ternjs', { 'for': [ 'javascript', 'javascript.jsx' ], 'do': 'npm install -g tern' }
  "Plug 'othree/jspc.vim', { 'for': [ 'javascript', 'javascript.jsx' ] }
  "Plug 'steelsojka/deoplete-flow', { 'for': [ 'javascript', 'javascript.jsx' ] }
  Plug 'othree/javascript-libraries-syntax.vim', { 'for': [ 'javascript', 'javascript.jsx' ] }
  " }}}
  " Go {{{
  Plug 'zchee/deoplete-go', { 'do': 'make' }
  Plug 'fatih/vim-go'
  " Typescript {{{
  " Never got deoplete typescript working well...
  "Plug 'Valloric/YouCompleteMe', {'do': './install.py --all', 'for': ['typescript']}
  " }}}
  " Neomake {{{
  "Plug 'benekastah/neomake'
  "Plug 'benjie/neomake-local-eslint.vim'
  " }}}
  Plug 'w0rp/ale'
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
  call plug#end()
  let g:used_javascript_libs='react,underscore,chai'

  let g:mapleader = ','
  "Spacemacs style keys {{{

  " Commands {{{
  nnoremap <silent> <Space>x q:
  nnoremap <silent> <Space>x/ :FzfHistory :<CR>
  " }}}

  " File {{{
  map <C-e> <plug>NERDTreeTabsToggle<CR>
  nnoremap <silent> <Space>fea :e ~/repo/dotfiles/.aliases<CR>
  nnoremap <silent> <Space>fef :e ~/repo/dotfiles/vim/plugin/functions.vim<CR>
  nnoremap <silent> <Space>feg :e ~/repo/dotfiles/vim/plugin/general.vim<CR>
  nnoremap <silent> <Space>fep :e ~/repo/dotfiles/vim/plugin/plugins.vim<CR>
  nnoremap <silent> <Space>fet :e ~/repo/dotfiles/.tmux.conf<CR>
  nnoremap <silent> <Space>fev :e ~/repo/dotfiles/vim/init.vim<CR>
  nnoremap <silent> <Space>fez :e ~/repo/dotfiles/.zshrc<CR>
  nnoremap <silent> <Space>fft :call filetype#edit_ft_plugin()<CR>
  nnoremap <silent> <Space>flft :call filetype#source_ft_plugin()<CR>
  nnoremap <silent> <Space>flr :call system("tmux source-file ~/.tmux.conf")<CR>
  nnoremap <silent> <Space>flv :source $MYVIMRC<CR>
  nnoremap <silent> <Space>fn :NERDTreeFind<CR>
  nnoremap <silent> <space>fi :let g:NERDTreeIgnore = ['
  nnoremap <silent> <Space>ft :call EditTestFile('e')<CR>
  nnoremap <silent> <Space>fst :call EditTestFile('s')<CR>
  nnoremap <silent> <Space>fvt :call EditTestFile('v')<CR>
  " }}}


  " Insert {{{
  " TODO: visual support
  call util#nvmap('ij', ':<C-U>call line#append(v:count1, v:false)<CR>')
  call util#nvmap('io', ':<C-U>call line#append(v:count1, v:true)<CR>')
  call util#nvmap('ik', ':<C-U>call line#prepend(v:count1, v:false)<CR>')
  call util#nvmap('iO', ':<C-U>call line#prepend(v:count1, v:true)<CR>')
  nnoremap <silent> <Space>ib :<C-U>call line#append_and_prepend(v:count1, v:false)<CR>
  vnoremap <silent> <Space>ib :<C-U>call line#append_and_prepend(v:count1, v:true)<CR>
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
  nnoremap <silent> <Space>f0 :set foldlevel=0<CR>
  nnoremap <silent> <Space>f1 :set foldlevel=1<CR>
  nnoremap <silent> <Space>f2 :set foldlevel=2<CR>
  nnoremap <silent> <Space>f3 :set foldlevel=3<CR>
  nnoremap <silent> <Space>f4 :set foldlevel=4<CR>
  nnoremap <silent> <Space>f5 :set foldlevel=5<CR>
  nnoremap <silent> <Space>f6 :set foldlevel=6<CR>
  nnoremap <silent> <Space>f7 :set foldlevel=7<CR>
  nnoremap <silent> <Space>f8 :set foldlevel=8<CR>
  nnoremap <silent> <Space>f9 :set foldlevel=9<CR>
  " }

  nmap <silent> <Space>m/ <Plug>MMList
  nmap <silent> <Space>ma <Plug>MMListAll
  nmap <silent> <Space>ml <Plug>MMListLoaded
  xmap <silent> <Space>m :<C-U>call ExecuteMacroOnSelection()<CR>
  xmap <silent> <Space>m. :<C-U>call ExecuteMacroOnSelection('.')<CR>

  " Marks and registers {
  nnoremap <silent> <Space>'/ :FzfMarks<CR>
  nnoremap c<Space> "_c
  nnoremap d<Space> "_d
  " }

  " Repl and typing {
  " nnoremap <silent> <Space>yt :YcmCompleter GetType<CR>
  " nnoremap <silent> <Space>yg :YcmCompleter GoToDefinition<CR>
  " nnoremap <silent> <Space>yv :YcmCompleter GoToDefinition<CR><C-W>v<C-W>h:bp<CR><C-W>l
  " nnoremap <silent> <Space>yd :YcmCompleter GetDoc<CR>
  " nnoremap <silent> <Space>yr :YcmCompleter GoToReferences<CR>
  " }

  " Mappings helper {
  nnoremap <silent> <Space><Space>/ :FzfMaps<CR>
  nnoremap <silent> <Space><Space><Space> :FzfMaps<CR>'space>
  " }

  vnoremap <Space>r c<C-O>:set ri<CR><C-R>"<Esc>:set nori<CR>

  " autoclose for multiline only {
  inoremap [<CR> [<CR>]<Esc>ko
  inoremap [; [<CR>];<Esc>ko
  inoremap [, [<CR>],<Esc>ko
  inoremap {<CR> {<CR>}<Esc>ko
  inoremap {; {<CR>};<Esc>ko
  inoremap {, {<CR>},<Esc>ko
  inoremap {)<CR> {<CR>});<Esc>ko
  inoremap ({<CR> ({<CR>})<Esc>ko
  inoremap ({; ({<CR>});<Esc>ko
  inoremap ([<CR> ([<CR>])<Esc>ko
  inoremap ([; ([<CR>]);<Esc>ko
  "}
endif

" function! MapQF(key, val) abort
"   return { 'filename': a:val }
" endfunction
" function! SetQF(id, data, event) dict abort
"   let l:dict = map(a:data, function('MapQF'))
"   call setqflist(getqflist(), 'r', {'items': l:dict})
" endfunction
" function! AsyncQF(cmd) abort
"   call jobstart(a:cmd, { 'on_stdout': function('SetQF') })
" endfunction

