""" DOTFILES_INSTALL_PATH:.config/nvim/:

"""call plug#begin('~/.vim/plugged')
"""call plug#end()

if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
    set relativenumber
    set numberwidth=4
endif