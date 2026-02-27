# Dotfiles

## Installation

Fork this repository, then install via:

    $ cd $HOME
    $ git clone https://github.com/youruser/dotfiles.git .dotfiles
    $ cd .dotfiles
    $ # edit and add files
    $ # commit and push your changes
    $ ./install.sh

The install script will:
1. install homebrew packages specified in Brewfile
2. install on-my-zsh
3. create symlinks in your home directory to all the ".files"
4. create symlinks in corresponding $HOME/.config/APP directores to files in ".config/APP/" directories
5. create symlinks in $HOME/bin for all files in the repo bin directory

Existing symlinks will be re-linked. The script will NOT delete or overwrite any non-symlink files in your home or bin directories.
