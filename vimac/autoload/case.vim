""
" Uses tpope's coercion helpers
function! case#selection_to_camel() abort
  silent try | :silent s/\%V\-\(.\)/\U\1/g | catch || endtry
  silent normal crc
  silent normal! `<
endfunction
