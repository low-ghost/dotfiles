nnoremap Q mzgqap`z
nnoremap g{ {w
vnoremap g{ {w
nnoremap g} }k$
vnoremap g} }k$

setlocal textwidth=80

hi! link EasyMotionTarget Search
hi! link EasyMotionShade  Comment

hi! link EasyMotionTarget2First ErrorMsg
hi! link EasyMotionTarget2Second ErrorMsg

let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt',]
let g:lexical#spellfile = ['~/git/dotfiles/vimac/spell/en.utf-8.add',]
let g:lexical#thesaurus_key = '<space>zt'
let g:lexical#dictionary_key = '<space>zk'

let g:ale_linters = {'markdown': ['proselint', 'vale', 'write-good']}
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nnoremap ge :ALENext<CR>
nnoremap gE :ALEPrevious<CR>

setl spell spl=en_us fdl=4 noru nonu nornu
