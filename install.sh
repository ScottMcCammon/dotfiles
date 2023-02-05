#!/bin/bash

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
        if [[ -h "../$f" ]]; then
            echo "updating $f"
            rm ../$f && ln -s $mydir/$f ..
        elif [[ ! -e "$HOME/$f" ]]; then
            echo "installing $f"
            ln -s $mydir/$f ..
        else
            echo "$f cannot be updated"
        fi
    fi
done

if [[ ! -e "../bin" ]]; then
    mkdir ../bin
fi
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
