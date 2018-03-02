# Dotfiles

## Installation

Fork this repository, then install via:

    $ cd $HOME
    $ git clone https://github.com/youruser/dotfiles.git .dotfiles
    $ cd .dotfiles
    $ # edit and add files
    $ # commit and push your changes
    $ ./install.sh

The install script will create symlinks in your home directory to all the ".files". It will also create symlinks in $HOME/bin for all files in the repo's bin directory.

Existing symlinks will be re-linked. The script will NOT delete or overwrite any non-symlink files in your home or bin directories.
