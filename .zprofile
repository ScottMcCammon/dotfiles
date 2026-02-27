# zshell config file sequence:
# 1. .zshenv
# 2. .zprofile (if login)
# 3. .zshrc (if interactive)
# 4. .zlogin (if login)
# 5. .zlogout

# Path
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.bun/bin:$PATH"


# Init OrbStack command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Homebrew setup
ARCH=`arch`
if [[ $ARCH == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# BEGIN: initialize conda (was managed by 'conda init' so integrate any future injections)
__conda_setup="$($HOME'/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# END: initialize conda
