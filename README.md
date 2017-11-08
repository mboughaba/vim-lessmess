     ██╗     ███████╗███████╗███████╗███╗   ███╗███████╗███████╗███████╗
     ██║     ██╔════╝██╔════╝██╔════╝████╗ ████║██╔════╝██╔════╝██╔════╝
     ██║     █████╗  ███████╗███████╗██╔████╔██║█████╗  ███████╗███████╗
     ██║     ██╔══╝  ╚════██║╚════██║██║╚██╔╝██║██╔══╝  ╚════██║╚════██║
     ███████╗███████╗███████║███████║██║ ╚═╝ ██║███████╗███████║███████║
     ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

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
There are two main functions
**LessmessExecute** and **LessmessDisplayToggle**.

### Automagically remove all annoying white-spaces
White-spaces removal onsave is enabled by default. Just save the buffer and the file is clean.

### Manually remove all annoying white-spaces
First, to disable LessmessExecute **onsave** make sure to include the configuration below in your vimrc
```vim
let g:enable_lessmess_onsave = 0
```
To remove (on demand) trailing white-spaces, fix mixed indent and remove newlines at the end of file all at once
```vim
LessmessExecute
```

### Simple white-spaces highlighting
To toggle highlighting of hidden characters, use command below.
```vim
LessmessDisplayToggle
```
This is simply calling vim native toggle list, I highly believe that syntax highlighting for white-spaces is a bit overkill. So why not just use ViM built-in list.

### Configuration
1. To Enable/disable Lessmess
```vim
LessmessToggle
```

2. Plugin can be disabled per buffer. An example would disabling white-spaces trimming for all vader test files
```vim
"
" Lessmess disable by FileType
"
aug disable_lessmess
    au!
    au FileType vader let b:lessmess_disable_buffer = 1
aug end
```

3. To completely disable the plugin, setting below can be added to .vimrc
 ```vim
let g:disable_lessmess = 1
 ```

### Handy tool
When **Lessmess is disabled**, white-spaces can be removed by calling **force** execute:
```vim
LessmessForceExecute
```

### Checking plugin status
To check status of the plugin one should call
```vim
LessmessStatus
```

## Running tests
check the setup in the test folder.
```shell
test/vader/run
```


## Self promotion
Why this one and not the other two or three trailing white-spaces removal plugins?
1. This is fully autoloaded, slowing down your ViM startup time was not an option
2. This is designed with performance in mind. The plugin doesn't do live updates, it does the heavy lifting when vim is idle.
    1. Making use of Vim jobs is in the pipe.
3. Absolutely no configuration is required to get started. Everything follows the [KISS principle](https://en.wikipedia.org/wiki/KISS_principle)
4. This plugin is fully unit tested using [Vader](https://github.com/junegunn/vader.vim)
5. This running on [Travis CI](https://travis-ci.org/mboughaba/vim-lessmess)
6. This is actively maintained
