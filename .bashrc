# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically runs startx when login to tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# Imports file that holds my ip for my server
. $HOME/.ip

### Aliases ###

alias vc='vimclip'

# Package Managment with xbps
alias install='doas xbps-install -S'
alias upgrade='doas xbps-install -Su'
alias remove='doas xbps-remove -Rf'
alias packages='xpkg -m'

# Mounts my portable SSD
alias mountssd='mkdir $HOME/ssd; doas blkid; sleep 1; doas mount -t ntfs-3g -o rw UUID=3583DD0C22E7BC7A /home/cole/ssd/'
alias umountssd='doas umount $HOME/ssd; sleep 1; doas rm -rf $HOME/ssd'

# Saved my place in my videos :)
alias mpv='mpv --save-position-on-quit'

# variants of ls with directories listed first
alias ls='exa --group-directories-first'
alias la='exa -a --group-directories-first'
alias ll='exa -alh --group-directories-first'

# Allows owner and group to write, others can read
alias perms='doas chmod 664'

# Auto creates parent directories
alias mkdir='mkdir -pv'

alias screenkey='screenkey -s small -p bottom -g 600x1625'

# Search command history
alias h='history | cut -c 8- | fzf --tac | xclip -selection clipboard'

# Record screen
alias record='ffmpeg -f x11grab -y -framerate 30 -s 1920x1080 -i :0.0+0,369 -c:v libx264 -preset fast -crf 18 out.mp4'

# Allows deleting/copying directories
alias rm='rm -ir'
alias cp='cp -r'

# easier clear commands
# alias c='clear; ls'
alias c='clear; fet'

# Runs the last command with doas
alias pls='doas $(fc -ln -1)'

# Git shortcuts
alias gc='git commit -S -m'
alias gs='git status'
alias ga='git add'
alias gp='git push; git push codeberg'
alias gl='git log --stat' # -# is another flag to show how many you want (-6 will give last 6 commits)

alias yt='ytfzf --thumb-viewer=chafa -t'

alias copypw='keepassxc-cli clip -b $HOME/misc/Passwords.kdbx 0'

alias ts='tmux-open-session'
alias tss='tmux-sessionizer'
alias ta='tmux a'

alias qemu='qemu-system-x86_64'

# Set up VIM keybinds inside of bash
set -o vi
set editing-mode vi
set keymap vi
bind -m vi-insert '\C-l':clear-screen

# Bash prompt(s)
# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\w\$(parse_git_branch) ➜ "
PS1="\w $ "

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Exports
export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'
export DOAS_EDITOR='nvim' #idek if this is a thing? just having it here incase
export VIDEO='mpv'
export IMAGE='sxiv'
export TERM=xterm-256color
export WM_NAME='LG3D'
export GPG_TTY=$(tty)
export PATH=$HOME/.scripts:$PATH
export PATH=$HOME/.local/bin:$PATH
export HISTCONTROL=ignoreboth:erasedups

# Unlimited history size
HISTSIZE= HISTFILESIZE= #
HISTIGNORE="&:ls:[bf]g:exit"

# Automatically cd without prepending cd
shopt -s autocd

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
  ls
}

# normal cd, but also clears the screen
cdc() {
    if [ -z "$1" ]; then
        cd && c;
    else
        cd "$1" && c;
    fi
}

# Run at start
# ls
fet

. "$HOME/.cargo/env"

alias cf='change_folder'

change_folder() {
    # if no argument is provided, search from ~ else use argument
    [[ -z $1 ]] && DIR=~ || DIR=$1
    # choose file using rg and fzf
    CHOSEN=$(fd --strip-cwd-prefix --full-path $DIR -H -t d | fzf --preview="exa -s type --icons {}" --bind="ctrl-space:toggle-preview" --preview-window=,10:hidden)

    # quit if no path is selected else cd into the path
    if [[ -z $CHOSEN ]]; then
        echo $CHOSEN
        return 1
    else
        cd "$CHOSEN"
    fi

    # show ls output if dir has less than 61 files
    [[ $(ls | wc -l) -le 60 ]] && (pwd; ls)
    return 0
}
