#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export EDITOR=nvim
PS1='[\u@\h \W]\$ '

export PATH="$PATH:$HOME/.local/bin"
alias vim=nvim
alias qtstart="qtile start -b wayland"

alias dotman='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


