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

### Aliases ###

alias resume='mv Downloads/Jake_s_Resume.pdf /home/cole/cole_roberts_resume.pdf'

# Package Managment with xbps
alias install='doas xbps-install -S'
alias upgrade='doas xbps-install -Su'
alias remove='doas xbps-remove -R'
alias packages='xbps-query -l'

# Mounts my portable SSSD
alias mountssd='doas blkid; sleep 1; doas mount UUID=3583DD0C22E7BC7A /home/cole/ssd/'

# Auto root power commands
alias po='doas poweroff'
alias rb='doas reboot'

# variants of ls with directories listed first
alias ls='exa --group-directories-first'
alias la='exa -a --group-directories-first'
alias ll='exa -alh --group-directories-first'

# Allows owner and group to write, others can read
alias perms='doas chmod 664'

# Auto creates parent directories
alias mkdir='mkdir -pv'

# Ngl I forget what this is for
alias doas='doas '

# Allows deleting/copying directories
alias rm='rm -r'
alias cp='cp -r'

# easier clear commands
alias cdc='cd; c'
alias c='clear; fet'

# Runs the last command with doas
alias pls='doas $(fc -ln -1)'

# Git shortcuts
alias gc='git commit -S -m'
alias gs='git status'
alias ga='git add'
alias gp='git push'

# Easier typing for nvim
alias v='nvim'
alias vim='nvim'

# puts you in the last directory upon exit
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Htop alternative
alias btm='btm -g'

# Replaces find
alias find='fd -i'

# Scripts aliases
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

# Exports
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

### Functions ###

# cd up x directories
b () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# Run at start
fet
