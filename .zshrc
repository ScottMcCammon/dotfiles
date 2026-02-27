# zshell config file sequence:
# 1. .zshenv
# 2. .zprofile (if login)
# 3. .zshrc (if interactive)
# 4. .zlogin (if login)
# 5. .zlogout

# oh-my-zsh setup
export ZSH="$HOME/.oh-my-zsh"
DEFAULT_USER=$USER
ZSH_THEME="agnoster"
plugins=()
source $ZSH/oh-my-zsh.sh
unsetopt autopushd pushdminus share_history

# Pyenv setup (deprecated - moving toward conda and uv+venv)
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# Ripgrep setup
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# NNN setup
export NNN_OPTS="AaeGgio"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG='p:preview-tui;c:cdprompt;b:-!bat "$nnn"*'
export NNN_BMS="u:$HOME;D:$HOME/Documents;d:$HOME/dotfiles"
export KITTY_LISTEN_ON="unix:$TMPDIR/kitty-$KITTY_PID"
export PAGER="less -RF"
export EDITOR=nvim
export LC_COLLATE="C" # sort hidden files on top

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Functions
source "$HOME/.zsh-functions"

# Aliases (after functions)
source "$HOME/.alias"
