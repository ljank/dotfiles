export CDPATH=.:~:~/workspace
export PATH=~/bin:/usr/local/bin:$PATH
export EDITOR=vim
export HISTCONTROL=ignoreboth
export BASH_SILENCE_DEPRECATION_WARNING=1

alias pong="ping 8.8.8.8"
alias less=bat

eval "$(starship init bash)"
