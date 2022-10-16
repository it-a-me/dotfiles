~/.config/shellsv2/update.pl
source ~/.config/shellsv2/export/alias.sh
source ~/.config/shellsv2/export/env.sh
source ~/.config/shellsv2/export/path.sh

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/me/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep extendedglob
bindkey -v

PS1='[%n@%~]$ '
