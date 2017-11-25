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
" Author: Mohamed Boughaba
" Repository: https://github.com/mboughaba/vim-lessmess
" Description: This plugin removes all empty white-spaces in a file
"
"
" loading {{{
"
"
if exists('g:autoloaded_lessmess') || &cp || version < 702
    fini
el
    "
    "
    " Plugin is enabled by default
    "
    if !exists("g:disable_lessmess")
        let g:disable_lessmess = 0
    en
    "
    "
    " Set the interval in which ViM will dirty check the file
    " this is triggered after idle
    let s:idle_update_timeout = 250
    " capture user's value for restore later on
    let s:idle_default_update_timeout = &updatetime
    if s:idle_default_update_timeout != s:idle_update_timeout
        let &updatetime = s:idle_update_timeout
    en
    "
    "
    " If the file is too big, whites-spaces is least of our worry
    let s:max_lines = 20000
    "
    "
    " Initialize scoped variables
    let s:contains_empty_lines = 0
    let s:contains_mixed_indent = 0
    let s:contains_trailing_whitespaces = 0
en
" }}}

" Private API {{{
"
" Store paste option
"
fun! s:capturePaste()
    let s:restore_paste = &paste
    if (s:restore_paste == 1)
        setl nopaste
    en
endf

"
" Restore paste option
"
fun! s:restorePaste()
    if (s:restore_paste == 1)
        setl paste
    en
endf

"
" Does it contain mixed indent?
"
fun! s:containsMixedIndent()
    "
    "
    " Check if there is mixed indent
    " no need to check again if previous search succeeded
    "
    " Sometimes there will be only tabs.
    " We should check if expandtab is on
    "     => This means that tabs are converted to spaces
    " TODO: Maybe we will need to capture and restore paste option
    " This is because expandtab is impacted by paste option.
    if s:contains_mixed_indent == 0
        if &expandtab
            " If spaces are being used and we find a line starting with tab.
            let s:contains_mixed_indent = search('\v(^( +)?\t+)', 'nw')
        el
            " We only check mixed indents (tabs + spaces)
            let s:contains_mixed_indent = search('\v(^\t+ +)|(^ +\t+)', 'nw')
        en
    en
endf

"
" Does it contain trailing whitespaces?
"
fun! s:containsTrailingWhitespaces()
    " no need to check again if previous search succeeded
    if s:contains_trailing_whitespaces == 0
        let s:contains_trailing_whitespaces = search('\v\s+$', 'nw')
    en
endf

"
" Does it contain empty lines?
"
fun! s:containsEmptylines()
    " no need to check again if previous search succeeded
    if s:contains_empty_lines == 0
        let s:contains_empty_lines = search('\v($\n\s*)+%$', 'nw')
    en
endf

"
" is file editable?
"
" FIXME: mboughaba: Currently Vader doesn't set the file as modified:
" https://github.com/junegunn/vader.vim/issues/143
fun! s:isEditable()
    if exists("g:__lessmess_vader_test__")
        retu 1
    el
        let l:editable = &mod && !&ro
        retu l:editable
    en
endf

"
" Dirty check
"
" To minimize performance impact onsave
" we check if the file is dirty
" This way we ensure that heavy regex replace
" is run only when needed
"
fun! lessmess#_dirtyCheck()
    if !g:disable_lessmess && s:isEditable() && line('$') < s:max_lines
        try
            "
            "
            " dirty checking
            sil cal s:containsMixedIndent()
            sil cal s:containsTrailingWhitespaces()
            sil cal s:containsEmptylines()
        cat
            echomsg 'lessmess: darn it'
            echomsg v:exception
        endt
    en
endf
" }}}

" Public API {{{
"
"
" Main function
" Stripes white-spaces from
" 1. End of the line
" 2. Mixed indent
" 3. Empty lines at the end of the file
"
" It preserves the position of the cursor.
" It preserves the last search as well
"
" The function only runs when file is in edit mode and modified.
" and when the file is dirty,
" meaning it contains some sort of unwanted white-spaces
"
" TODO: mboughaba: Use faster regex search engine (we can make use of Ag or Ack)
fun! lessmess#LessmessExecute(force)
    try
        if a:force || s:contains_empty_lines || s:contains_trailing_whitespaces || s:contains_mixed_indent

            "
            "
            " Do nothing if the user disabled the plugin for this specific
            " buffer
            if !a:force && exists("b:lessmess_disable_buffer")
                retu
            en
            " done.
            " We should add it then only if there is something to be done?
            " Remove Empty lines at the end of file
            if a:force || s:contains_empty_lines > 0
                :keepp %s#\($\n\s*\)\+\%$##e | norm!``
            en

            " Replace all sequences of white-space containing a
            " <Tab> with new strings of white-space using the new 'tabstop' value given.
            if a:force || s:contains_mixed_indent > 0
                "
                " We cannot fix mixed indent if paste is enabled
                " We will temporally set it off execute then put it back
                sil cal s:capturePaste()
                "
                "
                " retab the whole file
                sil retab | norm!``
                "
                "
                " restore paste option
                sil cal s:restorePaste()
            en

            " Remove Trailing white-space
            if a:force || s:contains_trailing_whitespaces > 0
                :keepp %s/\s\+$//e | norm!``
            en
        en
    cat
        echomsg 'lessmess: darn it'
        echomsg v:exception
    endt

    " Reset scoped variables
    let s:contains_empty_lines = 0
    let s:contains_mixed_indent = 0
    let s:contains_trailing_whitespaces = 0
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
        "
        "
        " (re) Set update time
        if s:idle_update_timeout != &updatetime
            let &updatetime = s:idle_update_timeout
        en

        "
        "
        " (re) enable dirty checking
        aug lessmess#dirty_checking
            au!
            au CursorHold * sil cal lessmess#_dirtyCheck()
        aug end

        "
        "
        " (re) enable onsave
        if exists("g:enable_lessmess_onsave") && g:enable_lessmess_onsave == 1
            aug lessmess#strip_whitespaces_onsave
                au!
                au BufWritePre * sil cal lessmess#LessmessExecute(0)
            aug end
        en
    el
        let g:disable_lessmess = 1
        "
        "
        " Reset update time
        if s:idle_default_update_timeout != &updatetime
            let &updatetime = s:idle_default_update_timeout
        en

        "
        "
        " Remove dirt checking autocommand
        au! lessmess#dirty_checking
        aug! lessmess#dirty_checking

        "
        "
        " Remove onsave autocommand
        au! lessmess#strip_whitespaces_onsave
        aug! lessmess#strip_whitespaces_onsave
    en
endf
"
" Get lessmess status
"
fun! lessmess#LessmessStatus()
    if g:disable_lessmess == 0
        if exists("b:lessmess_disable_buffer")
            retu 'OFF for the current buffer'
        en

        retu 'ON'
    el
        retu 'OFF'
    en
endf
" }}}

let g:autoloaded_lessmess = 1
" vim: se sw=4 sts=4 et fdm=marker:
