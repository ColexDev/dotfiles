#
#    ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
#    ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
#    ██████╔╝███████║███████╗███████║██████╔╝██║
#    ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
# ██╗██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
# ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically runs startx when login to tty1
# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# Package Managment
alias install='doas xbps-install -S'
alias upgrade='doas xbps-install -Su'
alias remove='doas xbps-remove -R'
alias packages='xbps-query -l'

# Aliases to mount my drives
alias mountssd='doas blkid; sleep 1; doas mount UUID=3583DD0C22E7BC7A /home/cole/ssd/'

# System Maintence / Misc
alias grep='grep --color=auto'
alias po='doas poweroff'
alias rb='doas reboot'
alias ls='exa --group-directories-first'
alias la='exa -a --group-directories-first'
alias ll='exa -a --long --group-directories-first'
alias perms='doas chmod 664'

# Ngl I forget what this is for
alias doas='doas '

# Allows deleting/copying directories
alias rm='rm -r'
alias cp='cp -r'

# easier clear commands
alias cdc='cd; c'
alias c='clear; fet'
alias b='cd ..'

# Runs the last command with doas
alias pls='doas $(fc -ln -1)'

# Git
alias gc='git commit -S -m'
alias gs='git status'
alias ga='git add'
alias gp='git push'

# Programs
alias v='nvim'
alias nb='newsboat'
alias pdf='mupdf'
# puts you in the last directory upon exit
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Htop alternative
alias btm='btm -g'

# Replaces find
alias find='fd -i'

# Scripts
alias 0x0='$HOME/scripts/./0x0.sh'
alias ix='$HOME/scripts/./ix.sh'
alias fet='$HOME/scripts/./fet.sh'
alias sloc='$HOME/scripts/SLOC.sh'
alias go='$HOME/scripts/cd.sh'
alias doasedit='$HOME/scripts/doasedit.sh'

# Website
export IP=''
alias send='doas rsync -a --rsync-path="sudo rsync" ~/dev/colexdev ${IP}:/var/www/'

# Set up VIM keybinds inside of bash
set -o vi
set editing-mode vi
set keymap vi
bind -m vi-insert '\C-l':clear-screen

# Bash prompt(s)
PS1="\w > "
# PS1="[\u@\h \w] > "

# Exports (Default programs)
export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'
export VIDEO='mpv'
export IMAGE='sxiv'
export TERM=xterm-256color
export WM_NAME='LG3D'
export GPG_TTY=$(tty)

# Unlimited history size
HISTSIZE= HISTFILESIZE= #
# Functions

# Run at start
fet
