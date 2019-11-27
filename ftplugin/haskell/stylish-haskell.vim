if !exists("g:stylish_haskell_command")
  if executable("stylish-haskell")
    let g:stylish_haskell_command = "stylish-haskell"
  else
    echom "stylish-haskell not found in $PATH"
  endif
endif

if !exists("g:stylish_haskell_options")
  let g:stylish_haskell_options = [ ]
endif

function! s:OverwriteBuffer(output)
  let winview = winsaveview()
  silent! undojoin
  normal! gg"_dG
  call append(0, split(a:output, '\v\n'))
  normal! G"_dd
  call winrestview(winview)
endfunction

function! s:StylishHaskell()
  if executable(split(g:stylish_haskell_command)[0])
    call s:RunStylishHaskell()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "stylish-haskell executable not found"
  endif
endfunction

function! s:RunStylishHaskell()
  let output = system(g:stylish_haskell_command . " " . join(g:stylish_haskell_options, ' ') . " " . bufname("%"))
  let errors = matchstr(output, '\(Language\.Haskell\.Stylish\.Parse\.parseModule:[^\x0]*\)')
  if v:shell_error != 0
    echom output
  elseif empty(errors)
    call s:OverwriteBuffer(output)
    write
  else
    echom errors
  endif
endfunction

augroup stylish-haskell
  autocmd!
  autocmd BufWritePost *.hs call s:StylishHaskell()
augroup END
