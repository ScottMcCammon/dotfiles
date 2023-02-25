# zshell config file sequence:
# 1. .zshenv
# 2. .zprofile (if login)
# 3. .zshrc (if interactive)
# 4. .zlogin (if login)
# 5. .zlogout

# Path
export PATH="$PATH:$HOME/bin"

# oh-my-zsh setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=()
source $ZSH/oh-my-zsh.sh

# Homebrew setup
ARCH=`arch`
if [[ $ARCH == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Ripgrep setup
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Functions
source "$HOME/.zsh-functions"

# Aliases (after functions)
source "$HOME/.alias"
