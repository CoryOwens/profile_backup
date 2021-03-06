# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Bind some keys that get mangled by different terminal emulators
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e[C":forward-char'
bind '"\e[D":backward-char'
bind '"\eOC":forward-word'
bind '"\eOD":backward-word'
bind '"\C-h":backward-kill-word'
bind '"ÿ":backward-kill-word'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
WHITE="\[\033[0;00m\]"
BLUE="\[\033[01;34m\]"
RED="\[\033[31m\]"
LGREEN="\e[92m"

source ~/posh-git-sh/git-prompt.sh

alias gitroot='git rev-parse --show-toplevel'
alias cdgit='eval "cd `gitroot`"'

title_manually_set=0

set_title_git() { 
    if [ "$title_manually_set" -eq 0 ] || [ "$1" != "-s" ]
    then 
        if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
        then
            d=$(gitroot|sed -E 's/.*\/([^/]+)/\1/')
            
        else 
            d=$(pwd)
        fi
        set_title $d
        if [ "$1" = "-s" ]
        then
            title_manually_set=0
        fi
    fi
}
set_title() { 
    title_manually_set=1
    printf '\e]2;%s\a' "$@"; 
    if ! [[ -z ${TMUX+x} ]]; then 
        tmux rename-window "$@"; 
    fi
}

PROMPT_COMMAND='__posh_git_ps1 "$([ ! -z "$VIRTUAL_ENV" ] && echo "($(basename "$VIRTUAL_ENV")) " || echo "")$GREEN\u@\h:$BLUE\w" "$ \n$WHITE";'$PROMPT_COMMAND
PROMPT_COMMAND='set_title_git -s;'$PROMPT_COMMAND
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

logout(){
    source ~/.bash_logout
    kill -9 -1
}
lock(){
    source ~/.bash_logout
    dm-tool lock
}
if [[ -n $SSH_CONNECTION ]]; then
    alias subl=rmate
    alias sublime=rmate
else
    alias subl='subl -a'
    alias sublime='subl -a'
    alias pycharm=pycharm.pl
    alias calc=gnome-calculator
fi
alias less='less -S'
git_find_and_replace(){
    echo $1
    echo $2
    git grep -lIE "$1" | xargs sed -i "s/$1/$2/g"
}

## Uncomment to launch TMUX on startup, and cleanup on close. 
# trap _trap_exit EXIT
# if command -v tmux>/dev/null; then
#     if [[ ! $TERM =~ screen ]] && [ -z $TMUX ] 
#     then
#         export tmux_cleanup_id=$$
#         # touch "$HOME/$tmux_cleanup_id.log"
#         # echo "Startup PID: $tmux_cleanup_id" >> "$HOME/$tmux_cleanup_id.log"
#         exec tmux new-session -s $tmux_cleanup_id
#     fi
# fi

# _trap_exit() { 
#     if [[ "$SHLVL" -eq 2 ]]
#     then
#         # echo "trap_exit PID: $tmux_cleanup_id" >> "$HOME/$tmux_cleanup_id.log"
#         sessions=$(tmux list-session)
#         # echo "Sessions: $sessions" >> "$HOME/$tmux_cleanup_id.log"
#         session_ids=$(echo "$sessions" | awk '{print $1}' | sed -r 's/://')
#         # echo "Session IDs: $session_ids" >> "$HOME/$tmux_cleanup_id.log"
#         session=$(echo $session_ids | grep $tmux_cleanup_id)
#         # echo "Session: $session" >> "$HOME/$tmux_cleanup_id.log"
#         if [[ "$session" != '' ]]
#         then
#             # echo "Killing session." >> "$HOME/$tmux_cleanup_id.log"
#             tmux kill-session -t $tmux_cleanup_id;
#         else
#             # echo "No session to kill." >> "$HOME/$tmux_cleanup_id.log"
#             test
#         fi
#     else
#         echo "Exit SHLVL $SHLVL"
#     fi
# }

