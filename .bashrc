#
# ~/.bashrc
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# init tools
eval "$(zoxide init --cmd cd bash)" # zoxide
eval "$(thefuck --alias)" # thefuck

# Aliases

# ls
alias ls='lsd  -F --group-directories-first'
alias la="lsd  -a -F --group-directories-first"
alias ll="lsd -F -Alh --group-directories-first --sort time"

# improved
alias grep='grep --color=auto'
alias cat="bat"
alias dig="dog"

# shorts
alias c="clear"
alias e="exit"
alias s="sudo"
alias t="touch"
alias h="history"

# castom
alias weather="curl wttr.in" # check weather
alias ports="ss -tulnp" # check ports

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
