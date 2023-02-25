#!/bin/bash

set -e # exit if any command fails

ARCH=`arch`
if [[ $ARCH == "arm64" ]]; then
    BREW_BIN="/opt/homebrew/bin/brew"
else
    BREW_BIN="/usr/local/bin/brew"
fi
if [[ ! -e "$BREW_BIN" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install homebrew packages from Brewfile
brew bundle

# install oh-my-zsh
if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm "$HOME/.zshrc"
fi

skipfiles=" install.sh README.md .git bin Brewfile Brewfile.lock.json "

mydir=$(basename `pwd`)
for f in $(find . -depth 1 -not -name '*.swp'); do
    f=${f:2} # trim leading "./"
    if [[ ! $skipfiles = *" $f "* ]]; then
        # grep DOTFILES_INSTALL_PATH
        install_path=".."
        mydir_prefix=""
        if [[ -f "$f" ]]; then
            dest=`sed -nr 's|.*DOTFILES_INSTALL_PATH:([.]/)?([^/]+(/[^/]+)*)/?:.*|\2|p' "$f"`
            if [[ ! -z "$dest" ]]; then
                install_path="$install_path/$dest"
                mydir_prefix=`sed -r 's|([^/]+/+)|../|g' <<< "$dest/"`
                mkdir -p "$install_path"
            fi
        fi
        if [[ -h "$install_path/$f" ]]; then
            echo "updating $install_path/$f => $mydir/$f"
            rm "$install_path/$f" && ln -s "${mydir_prefix}$mydir/$f" "$install_path"
        elif [[ ! -e "$install_path/$f" ]]; then
            echo "installing $install_path/$f => $mydir/$f"
            ln -s "${mydir_prefix}$mydir/$f" "$install_path"
        else
            echo "$install_path/$f cannot be updated"
        fi
    fi
done

mkdir -p ../bin
for f in $(find ./bin -type f -depth 1 -not -name '*.swp'); do
    f=${f:6} # trim leading "./bin/"
    if [[ -h "../bin/$f" ]]; then
        echo "updating bin/$f"
        rm ../bin/$f && ln -s ../$mydir/bin/$f ../bin/
    elif [[ ! -e "$HOME/$f" ]]; then
        echo "installing bin/$f"
        ln -s ../$mydir/bin/$f ../bin/
    else
        echo "bin/$f cannot be updated"
    fi
done
