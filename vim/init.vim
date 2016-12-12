" vim: foldmarker={,} foldmethod=marker spell:
set nocompatible
set shell=/bin/zsh

"TODO: figure out why cursor doesn't show in history edit

call plug#begin('~/.nvim/plugged')
"Not currently used
"Plug 'altercation/vim-colors-solarized'
"Plug 'amirh/HTML-AutoCloseTag'
"Plug 'jiangmiao/auto-pairs'
"Plug 'flazz/vim-colorschemes'
"Plug 'rking/ag.vim'
"Plug 'edkolev/tmuxline.vim'
"Plug 'edkolev/promptline.vim'

"All other vim settings
Plug '~/repo/dotfiles/vim'

"All plugins
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': [ 'javascript', 'javascript.jsx' ] }
Plug 'carlitux/deoplete-ternjs', { 'for': [ 'javascript', 'javascript.jsx' ], 'do': 'npm install -g tern' }
Plug 'othree/jspc.vim', { 'for': [ 'javascript', 'javascript.jsx' ] }
Plug 'benekastah/neomake'
Plug 'bling/vim-bufferline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'gorodinskiy/vim-coloresque'
Plug 'hail2u/vim-css3-syntax'
Plug 'heavenshell/vim-jsdoc'
Plug 'honza/vim-snippets'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kana/vim-textobj-user'
  "i
  Plug 'kana/vim-textobj-indent'
  "l
  Plug 'kana/vim-textobj-line'
  "e
  Plug 'kana/vim-textobj-entire'
Plug 'klen/python-mode'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'low-ghost/vim-macro-manager'
Plug 'low-ghost/vimax'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'matchit.zip'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-over'
Plug 'pangloss/vim-javascript'
Plug 'powerline/fonts'
Plug 'powerline/fonts', { 'dir': '~/fonts', 'do': './install.sh' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'spf13/vim-colors'
Plug 'spf13/vim-preview'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/restore_view.vim'
Plug 'wellle/targets.vim'
Plug 'steelsojka/deoplete-flow'
Plug 'vim-scripts/SyntaxComplete'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'simnalamburt/vim-mundo'
call plug#end()
let g:used_javascript_libs='react,underscore,chai'

let mapleader = ","
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

"neovim terminal
tnoremap <C-o> <C-\><C-n>
tnoremap <C-o>x <C-\><C-n>:bd!<cr>
tnoremap <C-o><C-x> <C-\><C-n>:bd!<cr>
tnoremap <C-o>z <C-\><C-n>:ZoomToggle<cr>
tnoremap <C-o><C-z> <C-\><C-n>:ZoomToggle<cr>
"found this to be too annoying if accidentally landing on buffer
"autocmd BufWinEnter,WinEnter term://* startinsert
let g:terminal_scrollback_buffer_size=10000 "default is 1000 limit is 100000

vnoremap crc :call SelectionToCamel()<cr>
vnoremap O <Esc>O

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;
nnoremap ,, ,
vnoremap ,, ,

"Spacemacs style keys {

" Windows {
nnoremap <silent> <Space>wd :hide<cr>;
"resize
nnoremap <silent> <Space>wJ :<C-U>call CountCommand('resize +', 10, 1)<CR>
nnoremap <silent> <Space>wK :<C-U>call CountCommand('resize -', 10, 1)<CR>
nnoremap <silent> <Space>wH :<C-U>call CountCommand('vertical resize +', 10, 1)<CR>
nnoremap <silent> <Space>wL :<C-U>call CountCommand('vertical resize -', 10, 1)<CR>
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
" }

" Commands {
nnoremap <silent> <Space>x q:i
nnoremap <silent> <Space>x/ :FzfHistory :<CR>
" }

" Dir {
nnoremap <silent> <Space>dr :call SaveLastDir()<CR>:lcd `git rev-parse --show-toplevel`<CR>:echo getcwd()<CR>
nnoremap <silent> <Space>ds :echo getcwd()<CR>
nnoremap <silent> <Space>df :call SaveLastDir()<CR>:lcd %:p:h<CR>:echo getcwd()<CR>
"TODO: make du accept a count as in 2du would exe cd ../../
nnoremap <silent> <Space>du :call SaveLastDir()<CR>:cd ../<CR>:echo getcwd()<CR>
nnoremap <silent> <Space>dc :call SaveLastDir()<CR>:cd
"TODO: maybe maintain a stack of 5 or so and d- moves back in stack, d+ moves
"forward?
nnoremap <silent> <Space>d- :exe "cd " . g:last_changed_dir<CR>:echo getcwd()<CR>
" }

" Buffers {
"both delete accept count to specify buffer
nnoremap <silent> <Space>bd :lclose\|cclose\|pclose<CR>:bp\|bd #<CR>
nnoremap <silent> <Space>bD :lclose\|cclose\|pclose<CR>:bp\|bd! #<CR>
nnoremap <silent> <Space>BD :lclose\|cclose\|pclose<CR>:bp\|bd! #<CR>
"delete or keep buffers matching a string
nnoremap <silent> <Space>bmd :call BufferByMatch(1)<CR>
nnoremap <silent> <Space>bmo :call BufferByMatch(0)<CR>
"BOnly will not kill buffers w/ unsaved content
nnoremap <silent> <Space>bo :BOnly<CR>
"TODO filter current
nnoremap <silent> <Space>b/ :FzfBuffers<CR>
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
"buffer toggle
nnoremap <silent> <Space>bt :b#<CR>
nnoremap <silent> <Space>bf :bfirst<CR>
nnoremap <silent> <Space>be :blast<CR>
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
nnoremap <silent> <Space>f/ :FzfGitFiles<CR>
nnoremap <silent> <Space>f? :FzfFiles<CR>
nnoremap <silent> <Space>fea :e ~/repo/dotfiles/.aliases<CR>
nnoremap <silent> <Space>fef :e ~/repo/dotfiles/vim/plugin/functions.vim<CR>
nnoremap <silent> <Space>feg :e ~/repo/dotfiles/vim/plugin/general.vim<CR>
nnoremap <silent> <Space>fep :e ~/repo/dotfiles/vim/plugin/plugins.vim<CR>
nnoremap <silent> <Space>fet :e ~/repo/dotfiles/.tmux.conf<CR>
nnoremap <silent> <Space>fev :e ~/repo/dotfiles/vim/init.vim<CR>
nnoremap <silent> <Space>fez :e ~/repo/dotfiles/.zshrc<CR>
nnoremap <silent> <Space>fft :call EditFtPlugin()<CR>
nnoremap <silent> <Space>flr :call system("tmux source-file ~/.tmux.conf")<CR>
nnoremap <silent> <Space>flv :source $MYVIMRC<CR>
nnoremap <silent> <Space>fn :NERDTreeFind<CR>
nnoremap <silent> <Space>fr :FzfHistory<CR>
nnoremap <silent> <Space>fw :silent w !sudo tee % > /dev/null<CR>
nnoremap <silent> <space>fi :let g:NERDTreeIgnore = ['
nnoremap <silent> <Space>ft :call EditTestFile('e')<CR>
nnoremap <silent> <Space>fst :call EditTestFile('s')<CR>
nnoremap <silent> <Space>fvt :call EditTestFile('v')<CR>
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
"toggle line wrap
nnoremap <silent> <Space>tlw :call ToggleWrap()<CR>
"nmap <silent> <Space>tw :ToggleWord<CR>
"nmap <silent> <Space>tW :ToggleWordReverse<CR>
" }

" Insert {
" TODO: visual support
nnoremap <silent> <space>ij :<C-U>call AppendLine(0)<CR>
nnoremap <silent> <space>io :<C-U>call AppendLine(1)<CR>
nnoremap <silent> <Space>ik :<C-U>call PrependLine(0)<CR>
nnoremap <silent> <space>iO :<C-U>call PrependLine(1)<CR>
nnoremap <silent> <Space>ib :<C-U>call AppendAndPrependLine()<CR>
" }

" Applications (a is also alignment, watch for conflicts) {
nnoremap <silent> <Space>aj <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
nnoremap <silent> <Space>au :UndotreeToggle<CR>
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
" }
nnoremap <silent> <Space>am :Neomake<CR>
" }


" Substitute {
" s - standard | a - all | f - in cntr-f mode
" Standard {
" Sub last
nnoremap <silent> <Space>sl :s///g<Left><Left>
" Sub standard
nnoremap <silent> <Space>ss :s///g<Left><Left><Left>
" Sub all standard
nnoremap <silent> <Space>sas :%s///g<Left><Left><Left>
" Sub standard in command mode
nnoremap <silent> <Space>sfs :s///g<Left><Left><Left><C-f>i
" Sub all standard in command mode
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
" Register {
nnoremap <silent> <Space>s' :s/\(<C-r>"\)//g<Left><Left>
nnoremap <silent> <Space>sa' :%s/\(<C-r>"\)//g<Left><Left>
nnoremap <silent> <Space>sf' :s/\(<C-r>"\)//g<Left><Left><C-f>i
nnoremap <silent> <Space>sfa' :%s/\(<C-r>"\)//g<Left><Left><C-f>i
" }
" }

" Search {
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
nmap <silent> <Space>vbo <Plug>VimaxOpenScratch
nmap <silent> <Space>vbc <Plug>VimaxCloseScratch
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
nmap <silent> <Space>vs. <Plug>VimaxMotionSendLastRegion
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
