" vim: foldmarker={,} foldmethod=marker spell:
set nocompatible
set shell=/bin/zsh

call plug#begin('~/.nvim/plugged')
Plug 'altercation/vim-colors-solarized'
	"Plug 'amirh/HTML-AutoCloseTag'
Plug 'benekastah/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
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
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'vim-scripts/restore_view.vim'
Plug 'wellle/targets.vim'
Plug 'mxw/vim-jsx'
Plug 'low-ghost/vimax'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'powerline/fonts', { 'dir': '~/fonts', 'do': './install.sh' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'morhetz/gruvbox'
call plug#end()

let g:Completion_YouCompleteMe = 1
let g:Make_neomake = 1

source ~/.config/vim/general.vim
source ~/.config/vim/plugins.vim
source ~/.config/vim/functions.vim


nnoremap <space>yt :YcmCompleter GetType<CR>
nnoremap <space>yg :YcmCompleter GoToDefinition<CR>
nnoremap <space>yd :YcmCompleter GetDoc<CR>

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
nnoremap <silent> <Space>wj <C-W>j;
nnoremap <silent> <Space>wJ 10<C-w>+
nnoremap <silent> <Space>wk <C-W>k;
nnoremap <silent> <Space>wK 10<C-w>-
nnoremap <silent> <Space>wh <C-W>h;
nnoremap <silent> <Space>wH 10<C-w><
nnoremap <silent> <Space>wl <C-W>l;
nnoremap <silent> <Space>wL 10<C-w>>
nnoremap <silent> <Space>ws <C-W>s;
nnoremap <silent> <Space>wv <C-W>v;
nnoremap <silent> <Space>w= <C-W>=;
nnoremap <silent> <Space>wO :only<CR>
" }

" Plugins {
" TODO: generic functions
nnoremap <silent> <Space>pi :PlugInstall<CR>
nnoremap <silent> <Space>pc :PlugClean<CR>
nnoremap <silent> <Space>pu :PlugUpdate<CR>
" }

" Commands {
nnoremap <silent> <Space>x q:
" }

" Buffers {
"both delete accept count to specify buffer
nnoremap <silent> <Space>bd :bp\|bd #<CR>
nnoremap <silent> <Space>bD :bp\|bd! #<CR>
"BOnly will not kill buffers w/ unsaved content
nnoremap <silent> <Space>bo :BOnly<CR>
nnoremap <silent> <Space>bb :CtrlPBuffer<CR>
"bp/h and bn/l accept count
nnoremap <silent> <Space>bp :bprev<CR>
nnoremap <silent> <Space>bh :bprev<CR>
nnoremap <silent> <Space>bn :bnext<CR>
nnoremap <silent> <Space>bl :bnext<CR>
"copy entire buffer
nnoremap <silent> <Space>by gg"+yG<CR>
nnoremap <silent> <Space>bY gg"+yG<CR>
"replace entire buffer with register
"TODO accept register
nnoremap <silent> <Space>bP gg"_dGp<CR>
nnoremap <silent> <Space>br :e! %<CR>
" }

" QuickFix and Location {
nnoremap <silent> <Space>cl :cclose<CR>
nnoremap <silent> <Space>co :copen<CR>
nnoremap <silent> <Space>cn :cnext<CR>
nnoremap <silent> <Space>cp :cprev<CR>
nnoremap <silent> <Space>lc :lclose<CR>
nnoremap <silent> <Space>lo :lopen<CR>
nnoremap <silent> <Space>ln :lnext<CR>
nnoremap <silent> <Space>lp :lprev<CR>
" }

" File {
nnoremap <silent> <Space><CR> :w<CR>
nnoremap <silent> <Space>fs :w<CR>
nnoremap <silent> <Space>fS :wa<CR>
nnoremap <silent> <Space>fw :silent w !sudo tee % > /dev/null<CR>
map <C-e> <plug>NERDTreeTabsToggle<CR>
nnoremap <silent> <Space>fn :NERDTreeFind<CR>
nnoremap <silent> <Space>fe :NERDTreeTabsToggle<CR>
nnoremap <silent> <Space>ff :CtrlP<CR>
nnoremap <silent> <Space>fr :CtrlPMRUFiles<CR>
nnoremap <silent> <Space>fu :CtrlPFunky<Cr>
nnoremap <silent> <Space>fve :e $MYVIMRC<CR>
nnoremap <silent> <Space>fvr :source $MYVIMRC<CR>
nnoremap <silent> <Space>fte :e ~/.tmux.conf<CR>
nnoremap <silent> <Space>ftr :call system("tmux source-file ~/.tmux.conf")<CR>
" }
" Quit {
nnoremap <silent> <Space>qq :qa<CR>
nnoremap <silent> <Space>Q :qa!<CR>
nnoremap <silent> <Space>qs :wqa!<CR>
" }

" Toggle {
nnoremap <silent> <Space>tn :set nu!<CR>
nnoremap <silent> <Space>tN :set relativenumber!<CR>
nnoremap <silent> <Space>tse :set invhlsearch<CR>
nnoremap <silent> <Space>/ :set invhlsearch<CR>
nnoremap <silent> <Space>tsp :set spell!<CR>
nnoremap <silent> <Space>tsy :call ToggleSyntax()<CR>
nnoremap <silent> <Space>thl :set cursorline!<CR>
nnoremap <silent> <Space>tb :call ToggleBG()<CR>
nnoremap <silent> <Space>tp :RainbowParentheses!!<CR>
"show syntax info for character under cursor
nnoremap <space>thc :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }

" Insert {
nnoremap <silent> <space>ij :<C-U>call AppendLine()<CR>
"nnoremap <space>io :<C-U>call AppendLine()<CR>i
nnoremap <silent> <Space>ik :<C-U>call PrependLine()<CR>
"nnoremap <space>iO :<C-U>call PrependLine()<CR>i
" }

" Applications {
nnoremap <silent> <Space>au :UndotreeToggle<CR>
nnoremap <silent> <Space>aj <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
" }

" Search {
nnoremap <silent> <Space>ss :s///g<Left><Left><Left>
nnoremap <silent> <Space>sfs :s///g<Left><Left><Left><C-f>i
nnoremap <silent> <Space>sw :s/\(<C-r><C-w>\)//g<Left><Left>
nnoremap <silent> <Space>sfw :s/\(<C-r><C-w>\)//g<Left><Left><C-f>i
nnoremap <silent> <Space>sas :%s///g<Left><Left><Left>
nnoremap <silent> <Space>safs :%s///g<Left><Left><Left><C-f>i
nnoremap <silent> <Space>saw :%s/\(<C-r><C-w>\)//g<Left><Left>
nnoremap <silent> <Space>safw :%s/\(<C-r><C-w>\)//g<Left><Left><C-f>i
" Easy motion {
map ,, <Plug>(easymotion-prefix)
map <space>, <Plug>(easymotion-prefix)
map <space>sc <Plug>(easymotion-s)
map ,,s <Plug>(easymotion-s)
map <space>sn <Plug>(easymotion-sn)
map ,n <Plug>(easymotion-sn)
map <space>st <Plug>(easymotion-s2)
map ,2 <Plug>(easymotion-s2)
" }
" List matching words and go to one
nnoremap <silent> <Space>sg [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
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
nnoremap <silent> <Space>gm :Gmerge<CR>
nnoremap <silent> <Space>gs :Gstatus<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>
nnoremap <silent> <Space>gc :Gcommit<CR>
nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gl :Glog<CR>
nnoremap <silent> <Space>gp :Git push<CR>
nnoremap <silent> <Space>gr :Gread<CR>
nnoremap <silent> <Space>gw :Gwrite<CR>
nnoremap <silent> <Space>gW :Gwrite!<CR>
nnoremap <silent> <Space>ge :Gedit<CR>
nnoremap <silent> <Space>gi :Git add -p %<CR>
nnoremap <silent> <Space>gg :SignifyToggle<CR>
" Find merge conflict markers
nnoremap <silent> <Space>gf /\v^[<\|=>]{7}( .*\|$)<CR>
" }

if exists('g:Make_neomake')
  nnoremap <silent> <Space>m :Neomake<CR>
endif
