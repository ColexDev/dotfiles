#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias ll='ls -lAhF'
neofetch

shopt -s autocd # type in dir and it auto cd's into it
HISTSIZE= HISTFILESIZE= #

# System Maintence / Misc
alias po='poweroff'
alias rb='reboot'
alias sudo='sudo '
alias rm='rm -rf'
alias p='paru'
alias get='paru -S'
alias remove='paru -Rns'
alias packages='sudo paru -Qqet'
alias orphans='sudo paru -Qdtq'
alias cdc='cd; c'
# add password
alias server='sshpass -p "password" ssh -o StrictHostKeyChecking=no pi@colex.dev'
alias send='rsync -zarvh /home/cole/index.html pi@colex.dev:/var/www/colex/ ; rsync -zarvh
/home/cole/index.html root@colex.dev:/var/www/html/'
alias mountssd='sudo mount UUID=3942ba84-89e6-4966-b009-1a0e1b7d5ce4 /home/cole/SSD/'
alias mountflashdrive='sudo mount UUID=f23b86c3-63ac-4e21-91f6-123d74cd557b /home/cole/flashDrive/'
alias c="clear ; neofetch"

# Programs
alias r='ranger'
alias n='newsboat'
alias tm='tmpmail'
alias v='nvim'
alias vim='nvim'
alias gc='git commit -m'
alias h='htop'
alias g='gotop'
alias usage='ncdu'
alias volume='pulsemixer'


# Bash Settings
export TERM=xterm-256color
set -o vi
set editing-mode vi
set keymap vi
bind -m vi-insert "\C-l":clear-screen
# PS1="[\u@\h \w] > "
PS1="\w > "
# PS1="\[\e[1;24m\][\w]\n\[\e[0;24m\]\u@\h > "


aw() {
    search_term=$(echo $@ | sed 's/ /+/g')
    qutebrowser https://wiki.archlinux.org/index.php?search=${search_term}
}

ddg() {
    search_term=$(echo $@ | sed 's/ /+/g')
    qutebrowser https://duckduckgo.com/?q=${search_term}
}

yt() {
    search_term=$(echo $@ | sed 's/ /+/g')
    qutebrowser https://www.youtube.com/results?search_query=${search_term}
}

cheat() {
    curl "https://cheat.sh/$1"
}

