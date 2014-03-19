if !exists("g:stylish_haskell_command")
  let g:stylish_haskell_command = "stylish-haskell"
endif

function! s:StylishHaskell()
  let cursor_position = getpos('.')
  silent! undojoin
  silent! execute "%!" . g:stylish_haskell_command
  call setpos('.', cursor_position)
endfunction

augroup stylish-haskell
  autocmd!
  autocmd BufWrite *.hs call s:StylishHaskell()
augroup END
