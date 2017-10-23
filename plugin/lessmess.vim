" Author: Mohamed Boughaba
" Repository: https://github.com/mboughaba/vim-lessmess
" Description: This plugin removes all empty white-spaces in a file

" Prevent loading the plugin multiple times
if exists('g:loaded_lessmess_plugin')
    fini
en
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
    cal setpos('.', save_cursor)
endf
if g:enable_lessmess_onsave == 1
    autocmd BufWritePre * call lessmess#StripWhitespaces()
en
if g:enable_lessmess_highlighting == 1
    set nolist                                      " Hide by default
    set listchars=tab:▸\ ,trail:-,extends:>,precedes:<,nbsp:⎵,eol:¬
en
fun! lessmess#ToggleWhitespacesDisplay()
    set list!
endf
com! StripWhitespaces cal lessmess#StripWhitespaces()
com! ToggleWhitespacesDisplay cal lessmess#ToggleWhitespacesDisplay()
if !exists('g:lessmess_highlighting_map') | let g:lessmess_highlighting_map = '<leader>l' | en
if g:lessmess_highlighting_map != '' && !hasmapto(':<c-u>ToggleWhitespacesDisplay<cr>', 'n')
    exe 'nn <silent>' g:lessmess_highlighting_map ':ToggleWhitespacesDisplay<cr>'
en
