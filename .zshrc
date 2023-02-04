# zshell config file sequence:
# 1. .zshenv
# 2. .zprofile (if login)
# 3. .zshrc (if interactive)
# 4. .zlogin (if login)
# 5. .zlogout

# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Ripgrep setup
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Home tools
export PATH="$PATH:$HOME/bin"

# Functions
source "$HOME/.zsh-functions"

# Aliases (after functions)
source "$HOME/.alias"
