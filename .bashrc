# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# Package Managment
alias packages='sudo paru -Qqet'
alias orphans='sudo paru -Qdtq'

# Drives/Servers
alias mountssd='sudo blkid; sleep 1; sudo mount UUID=3583DD0C22E7BC7A /home/cole/SSD/'
alias mountflashdrive='sudo mount UUID=cc6a5c5b-4715-4fe0-b4de-0c9e6eff2958 /home/cole/flashDrive/'

# System Maintence / Misc
alias grep='grep --color=auto'
alias po='poweroff'
alias rb='reboot'
alias sudo='sudo '
alias rm='rm -rf'
alias cdc='cd; c'
alias c='clear; fet'
alias pls='sudo $(fc -ln -1)'

# Programs
alias tm='tmpmail'
alias v='nvim'
alias gc='git commit -m'
alias ls='exa --group-directories-first'
alias la='exa -a --group-directories-first'
alias ll='exa -a --long --group-directories-first'
alias btm='btm -g --mem_as_value'
alias find='fd -i'

# Scripts
alias 0x0='/home/cole/Scripts/./0x0.sh'
alias ix='/home/cole/Scripts/./ix.sh'
alias fet='/home/cole/Scripts/./fet.sh'

# Bash Settings
set -o vi
set editing-mode vi
set keymap vi
bind -m vi-insert '\C-l':clear-screen
# PS1="[\u@\h \w] > "
PS1="\w > "
export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'
export VIDEO='mpv'
export IMAGE='feh'
export TERM=xterm-256color
export WM_NAME='LG3D'
HISTSIZE= HISTFILESIZE= #

# Functions

cheat() {
    curl "https://cheat.sh/$1"
}

# Run at start
fet
