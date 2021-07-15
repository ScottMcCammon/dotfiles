source /etc/bashrc
source $HOME/.alias

# hostname completion for SSH from known_hosts file
complete -W "$(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e 's/,.*//g' | sort | uniq)" ssh

function sam_pushd {
    pushd "${@}" >/dev/null;
    dirs -v;
}
function sam_popd {
    popd "${@}" >/dev/null;
    dirs -v;
}

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git:\1)/'
}

function better_git_diff() {
	git diff "${@}" | colordiff.py | less -iFXRS -x4
}

function better_git_show() {
	git show "${@}" | colordiff.py | less -iFXRS -x4
}

function better_ag() {
    /usr/local/bin/ag -H --color "${@}" | less -iFXRS -x4
}

function diffu() {
    diff -u "${@}" | colordiff.py | less -iFXRS -x4
}

WHITE="\[\033[0;37m\]"
BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[1;31m\]"
BLUE="\[\033[0;34m\]"
BLUE_BOLD="\[\033[1;34m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
NORM="\[\033[0m\]"

PS1="$GREEN\u$NORM@$RED\h$NORM:$BLUE\W $CYAN\$(parse_git_branch)$NORM\$ "

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'

#export PIP_REQUIRE_VIRTUALENV=true
#export WORKON_HOME=~/virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
