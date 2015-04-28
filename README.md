vim-stylish-haskell
===================

Introduction
------------

This is a plugin to integrate [stylish-haskell] cleanly into your vim
workflow. By default, it will run stylish-haskell on Haskell buffers every
time they are saved. It assumes stylish-haskell is accessible from your $PATH.
If this isn't the case, set the `g:stylish_haskell_command` variable to the
location of the stylish-haskell binary.

In case `stylish-haskell` is not present in PATH all the time, annoying error
messages could be suppressed via `g:stylish_haskell_disable_if_not_in_path = 1`.

[stylish-haskell]: https://github.com/jaspervdj/stylish-haskell

Installation
------------

This plugin is compatible with [Vundle.vim] and [pathogen.vim].

[Vundle.vim]: https://github.com/gmarik/Vundle.vim
[pathogen.vim]: https://github.com/tpope/vim-pathogen
