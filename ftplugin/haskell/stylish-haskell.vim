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

  let splitted = split(a:output, '\n')

  " From https://github.com/fatih/vim-go/blob/99a1732e40e3f064300d544eebd4153dbc3c60c7/autoload/go/fmt.vim
  "
  " delete any leftover before we replace the whole file. Suppose the
  " file had 20 lines, but new output has 10 lines, only 1-10 are
  " replaced with setline, remaining lines 11-20 won't get touched. So
  " remove them.
  if line('$') > len(splitted)
      execute len(splitted) .',$delete'
  endif

  " setline iterates over the list and replaces each line
  call setline(1, splitted)

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
    echom substitute(output, '\n$', '', '')
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
