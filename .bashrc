#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# init tools
eval "$(zoxide init --cmd cd bash)" > /dev/null # zoxide
eval "$(thefuck --alias)" > /dev/null           # thefuck
eval "$(fzf --bash)" > /dev/null                # fzf
eval "$(ssh-agent -s)" > /dev/null              # ssh
# source /home/dog/.config/broot/launcher/bash/br # broot init

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
# eval "$(pyenv virtualenv-init -)"

# Aliases

# ls
alias ls='lsd  -F --group-directories-first'
alias la="lsd  -a -F --group-directories-first"
alias ll="lsd -F -Alh --group-directories-first --sort time"

# improved
alias grep='grep --color=auto'
alias cat="bat"
alias dig="dog"
alias rg="rga"

alias df="df -h"
alias free="free -h"

# shorts
alias c="clear"
alias e="exit"
alias s="sudo"
alias t="touch"
alias h="history"

# castom
alias weather="curl wttr.in" # check weather
alias myip="curl icanhazip.com"
alias ports="ss -tulnp" # check ports

# systemctl
alias es="systemctl list-unit-files --type=service --state=enabled"
alias ds="systemctl list-unit-files --type=service --state=disabled"

# for arch linux
. .bashrc.arch.sh &> /dev/null
# Rust
. "$HOME/.cargo/env" &> /dev/null

# shell view
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\t[\1]/'
}

# define colors
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
NO_COLOR="\[\033[0m\]"

# PS1
PS1="${BLUE}┌─[${GREEN}\u${BLUE}@${GREEN}\h${BLUE}]─[${GREEN}\w${BLUE}]"
PS1+="\$(if [[ -n \$(parse_git_branch) ]]; then echo -e \"\n${BLUE}│ ${YELLOW}\$(parse_git_branch)${BLUE}\"; fi)"
PS1+="\n${BLUE}└─${RED}\$${NO_COLOR} "


# ading directorys in PATH
export PATH="$PATH:~/bin:~/.local/bin:~/go/bin"

# XDG base for programs
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
export XDG_CACHE_HOME="${HOME}/.cache"
