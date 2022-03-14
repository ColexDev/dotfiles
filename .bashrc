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

# Imports file that holds my ip for my server
. .ip

### Aliases ###

alias resume='mv Downloads/Jake_s_Resume.pdf /home/cole/misc/cole_roberts_resume.pdf'

# Package Managment with xbps
alias install='doas xbps-install -S'
alias upgrade='doas xbps-install -Su'
alias remove='doas xbps-remove -R'
alias packages='xbps-query -l'

# Mounts my portable SSD
alias mountssd='doas blkid; sleep 1; doas mount -t ntfs-3g -o rw UUID=3583DD0C22E7BC7A /home/cole/ssd/'

alias mpv='mpv --save-position-on-quit'

# root power commands
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

# Search command history
alias h='history | cut -c 8- | fzf --tac | xclip -r -selection -c'

# Record screen
alias record='ffmpeg -f x11grab -y -framerate 30 -s 1920x1080 -i :0.0+0,369 -c:v libx264 -preset superfast -crf 18 out.mp4'

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

# puts you in the last directory upon exit
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Htop alternative
alias btm='btm -g'

# Replaces find
alias find='fd -i'

alias yt='ytfzf --thumb-viewer=chafa -t'

# Website
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
export PATH=$HOME/scripts:$PATH
export HISTCONTROL=ignoreboth:erasedups

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
