     ██╗     ███████╗███████╗███████╗███╗   ███╗███████╗███████╗███████╗
     ██║     ██╔════╝██╔════╝██╔════╝████╗ ████║██╔════╝██╔════╝██╔════╝
     ██║     █████╗  ███████╗███████╗██╔████╔██║█████╗  ███████╗███████╗
     ██║     ██╔══╝  ╚════██║╚════██║██║╚██╔╝██║██╔══╝  ╚════██║╚════██║
     ███████╗███████╗███████║███████║██║ ╚═╝ ██║███████╗███████║███████║
     ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
                                                                      by
                                             ┌┬┐┌┐ ┌─┐┬ ┬┌─┐┬ ┬┌─┐┌┐ ┌─┐
                                             │││├┴┐│ ││ ││ ┬├─┤├─┤├┴┐├─┤
                                             ┴ ┴└─┘└─┘└─┘└─┘┴ ┴┴ ┴└─┘┴ ┴

# Lessmess VIM Plugin
## Motivation
Every VIM user has a custom configuration to remove trailing white-spaces. Such a trivial task isn't it?
Well the idea here is all about moving that custom logic to its own plugin without having an impact on performance.

Keeping it stupid simple. I had the code around in my ![.vimrc](https://github.com/mboughaba/dotfiles/blob/master/.vimrc) and I decided to make a plugin out of it.
If you don't mind white-spaces in your files this is the best time to navigate away.

## Instalation
Using [Vundle](https://github.com/VundleVim/Vundle.vim)
```vim
Plugin 'mboughaba/vim-lessmess'
```

## Features
* Remove trailing white space onsave or on demand.
* Replace all sequences of Tab with new string of white-space.
* Remove empty lines at the end of the file.

## Usage
There are two functions
**StripWhitespaces** and **ToggleWhitespacesDisplay**.

To enable StripWhitespaces **onsave** make sure to include the configuration below in your vimrc
```vim
let g:enable_lessmess_onsave = 1
```

To enable/disable white-space highlighting add the following configuration too.
```vim
let g:enable_lessmess_highlighting = 1
```
To toggle highlighting on hidden characters use command
```vim
ToggleWhitespacesDisplay
```
Using custom mapping in your .vimrc
```vim
nn <silent> <Leader>l :ToggleWhitespacesDisplay<CR>
```

## Self promotion
Why this one and not the other two or three trailing white-spaces removal plugins?
- This support autoload, slowing down your ViM is not an option
- This is stupid simple and cannot go wrong
- This plugin is fully unit tested using [Vader](https://github.com/junegunn/vader.vim)
- This is still maintained (well I guess by now it is stable XD)
