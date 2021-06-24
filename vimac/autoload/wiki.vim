function! wiki#tags() abort
  VimwikiIndex
  VimwikiRebuildTags
  let l:path = VimwikiGet('path')
  execute "edit " . l:path . "tags.md"
  execute "norm! ggdG"
  VimwikiGenerateTags
  "Fix a few links that are erroneously (almost) absolute
  execute "%s:" . strpart(l:path, 1) . "::g"
  w
endfunction

function! wiki#diary_index() abort
  VimwikiDiaryIndex
  VimwikiDiaryGenerateLinks
  w
endfunction

function! wiki#alt_diary_entry(...) abort
  let l:suffix = get(a:, 1, v:count)
  let l:path = VimwikiGet('path')
  let l:diary_rel_path = VimwikiGet('diary_rel_path')
  let l:date = strftime(VimwikiGet('diary_link_fmt'))
  let l:ext = VimwikiGet('ext') 
  execute "edit " . l:path . l:diary_rel_path . l:date . l:suffix . l:ext
endfunction
