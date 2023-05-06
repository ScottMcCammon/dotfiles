"""call plug#begin('~/.vim/plugged')
"""call plug#end()

if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
    set relativenumber
    set number
    set numberwidth=4
    set scrolloff=999
    set tabstop=4
    set shiftwidth=4
    set expandtab
endif
