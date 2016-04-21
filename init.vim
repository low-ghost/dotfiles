" vim: foldmarker={,} foldmethod=marker spell:
set nocompatible
set shell=/bin/zsh

"TODO: figure out why cursor doesn't show in history edit

call plug#begin('~/.nvim/plugged')
Plug 'altercation/vim-colors-solarized'
	"Plug 'amirh/HTML-AutoCloseTag'
Plug 'benekastah/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
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
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'spf13/vim-colors'
Plug 'spf13/vim-preview'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'vim-scripts/restore_view.vim'
Plug 'wellle/targets.vim'
Plug 'mxw/vim-jsx'
Plug 'low-ghost/vimax'
Plug 'low-ghost/vim-macro-manager'
Plug 'low-ghost/toggle-words.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'powerline/fonts', { 'dir': '~/fonts', 'do': './install.sh' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tlib_vim'
Plug 'klen/python-mode'
call plug#end()
let g:Completion_YouCompleteMe = 1
let g:Make_neomake = 1

let g:fzf_command_prefix = 'Fzf'
let g:VimaxHistoryFile = $HOME.'/.zsh_history'

source ~/.config/vim/general.vim
source ~/.config/vim/plugins.vim
source ~/.config/vim/functions.vim

let mapleader = ","

nnoremap <C-t>l :tabnext<cr>
nnoremap <C-t>h :tabprevious<cr>
nnoremap <C-t>n :tabnew<cr>
nnoremap <C-t>i :tabfirst<cr>
nnoremap <C-t>I :tablast<cr>

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


"Spacemacs style keys {

" Windows {
nnoremap <silent> <Space>wd :hide<cr>;
"resize
nnoremap <silent> <Space>wJ :<C-U>call CountCommand('resize +', 10, 1)<CR>
nnoremap <silent> <Space>wK :<C-U>call CountCommand('resize -', 10, 1)<CR>
nnoremap <silent> <Space>wH :<C-U>call CountCommand('vertical resize +', 10, 1)<CR>
nnoremap <silent> <Space>wL :<C-U>call CountCommand('vertical resize -', 10, 1)<CR>
nnoremap <silent> <Space>w= <C-W>=
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
nnoremap <silent> <Space>wc :lclose<CR>:cclose<CR>:pclose<CR>
nnoremap <silent> <Space>wC :windo lclose<CR>:windo cclose<CR>:windo pclose<CR>
" }

" Commands {
nnoremap <silent> <Space>x q:
nnoremap <silent> <Space>x/ :FzfHistory :<CR>
" }

" Buffers {
"both delete accept count to specify buffer
nnoremap <silent> <Space>bd :bp\|bd #<CR>
nnoremap <silent> <Space>bD :bp\|bd! #<CR>
"delete or keep buffers matching a string
nnoremap <silent> <Space>bmd :call BufferByMatch(1)<CR>
nnoremap <silent> <Space>bmo :call BufferByMatch(0)<CR>
"BOnly will not kill buffers w/ unsaved content
nnoremap <silent> <Space>bo :BOnly<CR>
"TODO filter current
nnoremap <silent> <Space>bb :FzfBuffers<CR>
"bp/h and bn/l accept count
nnoremap <silent> <Space>bp :<C-U> call CountCommand('bprev')<CR>
nnoremap <silent> <Space>bh :<C-U> call CountCommand('bprev')<CR>
nnoremap <silent> <Space>bn :<C-U> call CountCommand('bnext')<CR>
nnoremap <silent> <Space>bl :<C-U> call CountCommand('bnext')<CR>
"copy entire buffer
nnoremap <silent> <Space>by gg"+yG<CR>
nnoremap <silent> <Space>bY gg"+yG<CR>
"replace entire buffer with register
"TODO accept register
nnoremap <silent> <Space>bP gg"_dGp<CR>
nnoremap <silent> <Space>br :e! %<CR>
"TODO get to work
nnoremap <silent> <Space>bR :call RefreshAllBuffers()<CR>
"go to buffer
nnoremap <silent> <Space>bg :<C-U>call CountCommand('b')<CR>
" }

" QuickFix and Location {
" for now, close both quickfix and location on close map
nnoremap <silent> <Space>cc :cclose<CR>
nnoremap <silent> <Space>cC :windo cclose<CR>
nnoremap <silent> <Space>co :<C-U>call CountCommand('copen', 7)<CR>
nnoremap <silent> <Space>cn :<C-U>call CountCommand('cnext')<CR>
nnoremap <silent> <Space>cp :<C-U>call CountCommand('cprev')<CR>
nnoremap <silent> <Space>cl :<C-U>cacl CountCommand('cnewer')<CR>
nnoremap <silent> <Space>ch :<C-U>call CountCommand('colder')<CR>
nnoremap <silent> <Space>c/ :FzfQf<CR>
nnoremap <silent> <Space>cg :<C-U>call CountCommand('cc')<CR>
nnoremap <silent> <Space>lc :lclose<CR>
nnoremap <silent> <Space>lC :windo lclose<CR>
nnoremap <silent> <Space>lo :<C-U>call CountCommand('lopen', 7)<CR>
nnoremap <silent> <Space>ln :<C-U>call CountCommand('lnext')<CR>
nnoremap <silent> <Space>lp :<C-U>call CountCommand('lprev')<CR>
nnoremap <silent> <Space>ll :<C-U>call CountCommand('lnewer')<CR>
nnoremap <silent> <Space>lh :<C-U>call CountCommand('lolder')<CR>
nnoremap <silent> <Space>l/ :FzfLl<CR>
nnoremap <silent> <Space>lg :<C-U>call CountCommand('ll')<CR>
" }

" File {
map <C-e> <plug>NERDTreeTabsToggle<CR>
nnoremap <silent> <Space><CR> :w<CR>
nnoremap <silent> <Space>fs :wa<CR>
nnoremap <silent> <Space>fea :e ~/.aliases<CR>
nnoremap <silent> <Space>fef :e ~/repo/dotfiles/functions.vim<CR>
nnoremap <silent> <Space>feg :e ~/repo/dotfiles/general.vim<CR>
nnoremap <silent> <Space>fep :e ~/repo/dotfiles/plugins.vim<CR>
nnoremap <silent> <Space>fev :e $MYVIMRC<CR>
nnoremap <silent> <Space>fez :e ~/.zshrc<CR>
nnoremap <silent> <Space>fet :e ~/.tmux.conf<CR>
nnoremap <silent> <Space>ff :FzfGitFiles<CR>
nnoremap <silent> <Space>flr :call system("tmux source-file ~/.tmux.conf")<CR>
nnoremap <silent> <Space>flv :source $MYVIMRC<CR>
nnoremap <silent> <Space>fn :NERDTreeFind<CR>
nnoremap <silent> <Space>fr :FzfHistory<CR>
nnoremap <silent> <Space>fw :silent w !sudo tee % > /dev/null<CR>
nnoremap <silent> <space>fi :let g:NERDTreeIgnore = ['
" }
" Quit {
nnoremap <silent> <Space>za :qa<CR>
nnoremap <silent> <Space>zf :qa!<CR>
nnoremap <silent> <Space>zwa :wqa!<CR>
" }

" Toggle {
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
nnoremap <silent> <Space>tn :set nu!<CR>
nnoremap <silent> <Space>tN :set relativenumber!<CR>
nnoremap <silent> <Space>tp :RainbowParentheses!!<CR>
nnoremap <silent> <Space>tsp :set spell!<CR>
nnoremap <silent> <Space>tsy :call ToggleSyntax()<CR>
nmap <silent> <Space>tw :ToggleWord<CR>
nmap <silent> <Space>tW :ToggleWordReverse<CR>
" }

" Insert {
" TODO: visual support
nnoremap <silent> <space>ij :<C-U>call AppendLine()<CR>
"nnoremap <space>io :<C-U>call AppendLine()<CR>i
nnoremap <silent> <Space>ik :<C-U>call PrependLine()<CR>
nnoremap <silent> <Space>ib :<C-U>call AppendAndPrependLine()<CR>
"nnoremap <space>iO :<C-U>call PrependLine()<CR>i
" }

" Applications (a is also alignment, watch for conflicts) {
nnoremap <silent> <Space>aj <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
nnoremap <silent> <Space>au :UndotreeToggle<CR>
"TODO normal mode accepting range
vnoremap <silent> <Space>as :sort<CR>
"t for template
nnoremap <silent> <Space>ate :UltiSnipsEdit<CR>
nnoremap <silent> <Space>at/ :FzfSnippets<CR>
" Plugins {
" TODO: generic functions
nnoremap <silent> <Space>api :PlugInstall<CR>
nnoremap <silent> <Space>apc :PlugClean<CR>
nnoremap <silent> <Space>apu :PlugUpdate<CR>
nnoremap <silent> <Space>apU :PlugUpgrade<CR>
nnoremap <silent> <Space>aps :PlugStatus<CR>
" }
nnoremap <silent> <Space>am :Neomake<CR>
" }

" Substitute {
" s - standard | a - all | f - in cntr-f mode
" Standard {
nnoremap <silent> <Space>ss :s///g<Left><Left><Left>
nnoremap <silent> <Space>sas :%s///g<Left><Left><Left>
nnoremap <silent> <Space>sfs :s///g<Left><Left><Left><C-f>i
nnoremap <silent> <Space>sfas :%s///g<Left><Left><Left><C-f>i
" }
" Word {
nnoremap <silent> <Space>sw :s/\(<C-r><C-w>\)//g<Left><Left>
nnoremap <silent> <Space>saw :%s/\(<C-r><C-w>\)//g<Left><Left>
nnoremap <silent> <Space>sfw :s/\(<C-r><C-w>\)//g<Left><Left><C-f>i
nnoremap <silent> <Space>sfaw :%s/\(<C-r><C-w>\)//g<Left><Left><C-f>i
" }
" Search {
nnoremap <silent> <Space>s/ :s/\(<C-r>/\)//g<Left><Left>
nnoremap <silent> <Space>sa/ :%s/\(<C-r>/\)//g<Left><Left>
nnoremap <silent> <Space>sf/ :s/\(<C-r>/\)//g<Left><Left><C-f>i
nnoremap <silent> <Space>sfa/ :%s/\(<C-r>/\)//g<Left><Left><C-f>i
" }
" }

" Search {
map <space>/ <Plug>(easymotion-prefix)
map <space>// <Plug>(easymotion-s)
map <space>/n <Plug>(easymotion-sn)
map <space>/2 <Plug>(easymotion-s2)
" List matching words and go to one. TODO: fzf-ize. Looks like:
" function ListInstances()
  " redir => lines
  " silent exe "normal! [I"
  " redir END
  " fzf lines
" endfunction
" possibly do silent bufdo
nnoremap <silent> <Space>/g [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" }

" Alignment {
" simple {
nnoremap <silent> <Space>a" :Tabularize /"<CR>
vnoremap <silent> <Space>a" :Tabularize /"<CR>
nnoremap <silent> <Space>a' :Tabularize /'<CR>
vnoremap <silent> <Space>a' :Tabularize /'<CR>
nnoremap <silent> <Space>a& :Tabularize /&<CR>
vnoremap <silent> <Space>a& :Tabularize /&<CR>
nnoremap <silent> <Space>a, :Tabularize /,<CR>
vnoremap <silent> <Space>a, :Tabularize /,<CR>
nnoremap <silent> <Space>a=> :Tabularize /=><CR>
vnoremap <silent> <Space>a=> :Tabularize /=><CR>
nnoremap <silent> <Space>a: :Tabularize /:<CR>
vnoremap <silent> <Space>a: :Tabularize /:<CR>
" }
nnoremap <silent> <Space>a:: :Tabularize /:\zs<CR>
vnoremap <silent> <Space>a:: :Tabularize /:\zs<CR>
nnoremap <silent> <Space>a,, :Tabularize /,\zs<CR>
vnoremap <silent> <Space>a,, :Tabularize /,\zs<CR>
nnoremap <silent> <Space>a= :Tabularize /^[^=]*\zs=<CR>
vnoremap <silent> <Space>a= :Tabularize /^[^=]*\zs=<CR>
nnoremap <silent> <Space>a<Bar> :Tabularize /<Bar><CR>
vnoremap <silent> <Space>a<Bar> :Tabularize /<Bar><CR>
nnoremap <silent> <Space>ac :Tabularize /
vnoremap <silent> <Space>ac :Tabularize /
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

" Git (fugitive) {
" Find merge conflict markers
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
" }

nmap <silent> <Space>m/ <Plug>MMList
nmap <silent> <Space>ma <Plug>MMListAll
nmap <silent> <Space>ml <Plug>MMListLoaded
xmap <silent> <Space>m :<C-U>call ExecuteMacroOnSelection()<CR>
xmap <silent> <Space>m. :<C-U>call ExecuteMacroOnSelection('.')<CR>

" Marks {
nnoremap <silent> <Space>' :FzfMarks<CR>
" }

" Vimax {
nmap <silent> <Space>va <Plug>VimaxList
nmap <silent> <Space>vc <Plug>VimaxClearAddressHistory
nmap <silent> <Space>vd <Plug>VimaxRunCommandInDir
nmap <silent> <Space>vg <Plug>VimaxGoToAddress
nmap <silent> <Space>vh <Plug>VimaxHistory
nmap <silent> <Space>vi <Plug>VimaxInspectAddress
nmap <silent> <Space>vj <Plug>VimaxScrollDownInspect
nmap <silent> <Space>vk <Plug>VimaxScrollUpInspect
nmap <silent> <Space>vl <Plug>VimaxRunLastCommand
nmap <silent> <Space>v<CR> <Plug>VimaxExitInspect
nmap <silent> <Space>vp <Plug>VimaxPromptCommand
nmap <silent> <Space>vq <Plug>VimaxCloseAddress
nmap <silent> <Space>vr <Plug>VimaxRunCommandAtGitRoot
nmap <silent> <Space>vss <Plug>VimaxMotionCurrentLine
nmap <silent> <Space>vs <Plug>VimaxMotion
vmap <silent> <Space>vs <Plug>VimaxMotion
nmap <silent> <Space>vx <Plug>VimaxInterruptAddress
nmap <silent> <Space>vz <Plug>VimaxZoomAddress
" }

" Repl and typing {
nnoremap <silent> <Space>yt :YcmCompleter GetType<CR>
nnoremap <silent> <Space>yg :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <Space>yv :YcmCompleter GoToDefinition<CR><C-W>v<C-W>h:bp<CR><C-W>l
nnoremap <silent> <Space>yd :YcmCompleter GetDoc<CR>
nnoremap <silent> <Space>yr :YcmCompleter GoToReferences<CR>
" }

" Mappings helper {
nnoremap <silent> <Space><Space>/ :FzfMaps<CR>
nnoremap <silent> <Space><Space><Space> :FzfMaps<CR>'space>
nnoremap <silent> <Space><Space><leader> :FzfMaps<CR>^<leader>
nnoremap <silent> <Space><Space>l :FzfMaps<CR>^<leader>
" }

"TODO text-object-user
"targets delete word
nnoremap dilw 2bdiw
nnoremap dalw 2bdaw
nnoremap daLw _daw
nnoremap diLw _diw
nnoremap dinw wdiw
nnoremap danw wdaw
nnoremap daNw $bdaw
nnoremap diNw $bdiw
