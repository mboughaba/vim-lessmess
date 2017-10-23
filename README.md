# Lessmess VIM Plugin
## Motivation
Every VIM user has a custom config to remove trailing white-space. Such a trivial task isn't it?
Well the idea is move this custom logic to its own plugin without having an impact on performance. Don't expect flying space ship when you do colon write.

Keeping it stupid simple. I had the code around in my vimrc and I decided to make a plugin out of it.
If you don't mind white-space in you files this is the best time to navigate away.

## Instalation
```vim
Plugin 'mboughaba/vim-lessmess'
```

## Feature
* Remove trailing white space onsave or on demand.
* Replace all sequences of <Tab> with new string of white-space.
* Remove empty lines at the end of the file.

## Usage
There are two functions
**StripWhitespaces** and **ToggleWhitespacesDisplay**.

To enable StripWhitespaces onsave make sure to include the config below in your vimrc
```vim
let g:enable_lessmess_onsave = 1
```

To enable/disable white-space highlighting add the following config too.
```vim
let g:enable_lessmess_highlighting = 1
```
