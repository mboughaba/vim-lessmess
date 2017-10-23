fun! s:StripWhitespaces()
    let save_cursor = getpos(".")                   " Let's remember where your
                                                    " cursor is

    :%s/\s\+$//e                                    " Remove Trailing white-space

    retab                                           " Replace all sequences of
                                                    " white-space containing a
                                                    " <Tab> with new strings of
                                                    " white-space using the new
                                                    " 'tabstop' value given.

    :%s/\($\n\s*\)\+\%$//e                          " Remove Empty lines at
                                                    " the end of file

    call setpos('.', save_cursor)                   " You don't want me to make
                                                    " a mess of your cursor
endf
if g:enable_lessmess_onsave == 1
    autocmd BufWritePre * :call StripWhitespaces()
endif
if g:enable_lessmess_highlighting == 1
    set nolist                                      " Hide by default
    set listchars=tab:▸\ ,trail:-,extends:>,precedes:<,nbsp:⎵,eol:¬
endif
fun! s:ToggleWhitespacesDisplay()
    set list!
endf
