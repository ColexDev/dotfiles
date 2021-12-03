# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically runs startx when login to tty1
# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# Package Managment
alias packages='sudo pacman -Qqet'
alias orphans='sudo pacman -Qdtq'

# Aliases to mount my drives
alias mountssd='sudo blkid; sleep 1; sudo mount UUID=3583DD0C22E7BC7A /home/cole/SSD/'
alias mountflashdrive='sudo mount UUID=cc6a5c5b-4715-4fe0-b4de-0c9e6eff2958 /home/cole/flashDrive/'

# System Maintence / Misc
alias grep='grep --color=auto'
alias po='poweroff'
alias rb='reboot'
alias ls='exa --group-directories-first'
alias la='exa -a --group-directories-first'
alias ll='exa -a --long --group-directories-first'
alias killall='killall -I'

# Ngl I forget what this is for
alias sudo='sudo '

# Automatically deletes without asking and can delete directories
alias rm='rm -rf'

# easier clear commands
alias cdc='cd; c'
# alias c='clear; cat /home/cole/ritchie; echo ""'
alias c='clear; fet'
alias b='cd ..'

# Runs the last command with sudo
alias pls='sudo $(fc -ln -1)'

# The fuck?
eval "$(thefuck --alias)"

# Git
alias gc='git commit -S -m'
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias lg='lazygit'

# Programs
alias v='nvim'
alias sv='sudoedit'
alias nb='newsboat'
alias pdf='mupdf'

# Htop alternative, shows ram in GB instead of %
alias btm='btm -g --mem_as_value'

# Replaces find
alias find='fd -i'

# Scripts
alias 0x0='$HOME/Scripts/./0x0.sh'
alias ix='$HOME/Scripts/./ix.sh'
alias fet='$HOME/Scripts/./fet.sh'
alias sloc='$HOME/Scripts/SLOC.sh'

# Website
export IP=''
alias send='sudo rsync -a --rsync-path="sudo rsync" ~/dev/colexdev ${IP}:/var/www/'

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
export IMAGE='feh'
export TERM=xterm-256color
export WM_NAME='LG3D'

# Unlimited history size
HISTSIZE= HISTFILESIZE= #
# Functions

cheat() {
    curl "https://cheat.sh/$1"
}

# Run at start
fet
# cat /home/cole/Misc/ritchie; echo ""
