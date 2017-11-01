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

[![Build Status](https://travis-ci.org/mboughaba/vim-lessmess.svg?branch=master)](https://travis-ci.org/mboughaba/vim-lessmess)


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

Using [Plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'mboughaba/vim-lessmess'
```

## Features
* Remove trailing white space onsave or on demand.
* Replace all sequences of Tab with new string of white-space.
* Remove empty lines at the end of the file.

## Usage
There are two functions
**StripWhitespaces** and **ToggleWhitespacesDisplay**.

To remove trailing white-spaces, fix mixed indent and remove newlines at the end of file all at once
```vim
StripWhitespaces
```

Or using custom mapping in your .vimrc
```vim
nn <silent> <Leader>s :StripWhitespaces<CR>
```

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

Or using custom mapping in your .vimrc
```vim
nn <silent> <Leader>l :ToggleWhitespacesDisplay<CR>
```

## Running tests
```shell
test/vader/run
```


## Self promotion
Why this one and not the other two or three trailing white-spaces removal plugins?
- This support autoload, slowing down your ViM is not an option
- This is stupid simple and cannot go wrong
- This plugin is fully unit tested using [Vader](https://github.com/junegunn/vader.vim)
- This is still maintained (well I guess by now it is stable XD)
