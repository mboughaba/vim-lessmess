" Author: Mohamed Boughaba
" Repository: https://github.com/mboughaba/vim-lessmess

" Prevent loading the plugin multiple times
if exists('g:loaded_lessmess_plugin')
    finish
endif
let g:loaded_lessmess_plugin = 1

fun! lessmess#StripWhitespaces()
    " Let's remember where your cursor is
    let save_cursor = getpos(".")

    " Remove Trailing white-space
    " Replace all sequences of white-space containing a
    "   <Tab> with new strings of white-space using the new 'tabstop' value given.
    " Remove Empty lines at the end of file
    :%s/\s\+$//e | retab | %s#\($\n\s*\)\+\%$##e

    " You don't want me to make a mess of your cursor
    call setpos('.', save_cursor)
endf
if g:enable_lessmess_onsave == 1
    autocmd BufWritePre * call lessmess#StripWhitespaces()
endif
if g:enable_lessmess_highlighting == 1
    set nolist                                      " Hide by default
    set listchars=tab:▸\ ,trail:-,extends:>,precedes:<,nbsp:⎵,eol:¬
endif
fun! lessmess#ToggleWhitespacesDisplay()
    set list!
endf
