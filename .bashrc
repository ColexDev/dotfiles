#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

neofetch --ascii /home/cole/.config/neofetch/archlogo

alias c="clear ; neofetch --ascii /home/cole/.config/neofetch/archlogo"
alias po='poweroff'
alias rb='reboot'
alias please='sudo'
alias p='sudo pacman'
alias pg='sudo pacman -S'
alias pd='sudo pacman -Rns'
alias pl='sudo pacman -Q'
alias pu='sudo pacman -Syu'
alias r='ranger'
alias n='newsboat'
alias cc='calcurse'
alias tm='tmpmail'
set -o vi
set editing-mode vi
set keymap vi
bind -m vi-insert "\C-l":clear-screen
PS1="[\u@\h \w] -> "
