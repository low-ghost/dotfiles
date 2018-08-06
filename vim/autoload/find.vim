" find files and populate the quickfix list
function! find#file(filename)
  let error_file = tempname()
  silent exe '!find . -regex "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfunction
