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
"                                                                  by
"                                         ┌┬┐┌┐ ┌─┐┬ ┬┌─┐┬ ┬┌─┐┌┐ ┌─┐
"                                         │││├┴┐│ ││ ││ ┬├─┤├─┤├┴┐├─┤
"                                         ┴ ┴└─┘└─┘└─┘└─┘┴ ┴┴ ┴└─┘┴ ┴
" Author: Mohamed Boughaba
" Repository: https://github.com/mboughaba/vim-lessmess
" Description: This plugin removes all empty white-spaces in a file
"
" Prevent loading the plugin multiple times
" loading {{{1 "
if exists('g:loaded_lessmess_plugin')
    fini
en
let g:loaded_lessmess_plugin = 1

"
" Set default mapping if not configured by the user
"
if !exists('g:lessmess_highlighting_map')
    let g:lessmess_highlighting_map = '<leader>l'
en
" 1}}} "
" Commands {{{2 "
"
" Commands
"
com! StripWhitespaces cal lessmess#StripWhitespaces()
com! ToggleWhitespacesDisplay cal lessmess#ToggleWhitespacesDisplay()
if g:lessmess_highlighting_map != '' && !hasmapto(':<c-u>ToggleWhitespacesDisplay<cr>', 'n')
    exe 'nn <silent>' g:lessmess_highlighting_map ':ToggleWhitespacesDisplay<cr>'
en
" 2}}} "
