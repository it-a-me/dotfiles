#
# ~/.bashrc
#
source ~/.config/sway/init.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export SUDO_EDITOR=nvim
PS1='[\u@\h \W]\$ '

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/opt/android-sdk/platform-tools"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"

alias ls='ls --color=auto'
alias vim=nvim
alias dotman='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mu-dlp='yt-dlp --extract-audio --audio-format mp3 --audio-quality 0'

