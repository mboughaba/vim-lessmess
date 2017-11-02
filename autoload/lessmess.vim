"            MIT License
"
" Copyright (c) 2017 Mohamed Boughaba
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.
"
" ██╗     ███████╗███████╗███████╗███╗   ███╗███████╗███████╗███████╗
" ██║     ██╔════╝██╔════╝██╔════╝████╗ ████║██╔════╝██╔════╝██╔════╝
" ██║     █████╗  ███████╗███████╗██╔████╔██║█████╗  ███████╗███████╗
" ██║     ██╔══╝  ╚════██║╚════██║██║╚██╔╝██║██╔══╝  ╚════██║╚════██║
" ███████╗███████╗███████║███████║██║ ╚═╝ ██║███████╗███████║███████║
" ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
"
" Author: Mohamed Boughaba
" Repository: https://github.com/mboughaba/vim-lessmess
" Description: This plugin removes all empty white-spaces in a file
"
"
"
" Prevent loading the plugin multiple times
if exists('g:autoloaded_lessmess') || &cp || version < 700
    fini
el
    "
    " Configure list
    " This is used to set the white-space characters to be displayed
    " when highlighting is on.
    "
    if exists("g:enable_lessmess_highlighting") && g:enable_lessmess_highlighting == 1
        " Hide empty white-space characters by default
        setl nolist
        setl listchars=tab:▸\ ,trail:-,extends:>,precedes:<,nbsp:⎵,eol:¬
    en
    "
    "
    "
    " Plugin is enabled by default
    if !exists("g:disable_lessmess")
        let g:disable_lessmess = 0
    en
en

" Strip white-spaces {{{ "
"
"
" Main function
" Stripes white-spaces from
" 1. End of the line
" 2. Mixed indent
" 3. Empty lines at the end of the file
"
" It preserves the position of the cursor.
"
fun! lessmess#LessmessExecute()
    if g:disable_lessmess == 0
        " Let's remember where your cursor is
        let l:save_cursor = getpos(".")
        " We cannot fix mixed indent if paste is enabled
        " We will temporally set it off execute then put it back
        let l:restore_paste = &paste
        if (l:restore_paste == 1)
          setl nopaste
        en

        " Remove Trailing white-space
        " Replace all sequences of white-space containing a
        " <Tab> with new strings of white-space using the new 'tabstop' value given.
        " Remove Empty lines at the end of file
        :%s/\s\+$//e | retab | %s#\($\n\s*\)\+\%$##e

        " restore paste option
        if (l:restore_paste == 1)
          setl paste
        en
        " You don't want me to make a mess of your cursor
        cal setpos('.', l:save_cursor)
    en
endf
"
" Toggle the list highlighting according to user of plugin list settings
"
fun! lessmess#LessmessDisplayToggle()
    setl list!
endf
"
" Enable/disable lessmess
"
fun! lessmess#LessmessToggle()
    if g:disable_lessmess == 1
        let g:disable_lessmess = 0
    el
        let g:disable_lessmess = 1
    en
endf
" }}} "

let g:autoloaded_lessmess = 1
