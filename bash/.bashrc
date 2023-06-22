

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# My custom prompt
export PS1="\[\033[38;5;14m\][\[$(tput sgr0)\]\[\033[38;5;2m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;85m\] \[$(tput sgr0)\]\[\033[38;5;4m\]\W\[$(tput sgr0)\]\[\033[38;5;14m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

if  which exa > /dev/null 2>&1; then
	# exa is a modern ls replacement with Git integration: https://the.exa.website
	alias ls="exa --git-ignore"
	alias ll="exa --git-ignore --git -l --group"
	alias la="exa --git -la"
else
	alias ls="ls --color=always"
	alias ll="ls -l"
	alias la="ls -lA"
fi
for alias in lsl sls lsls sl l s; do alias $alias=ls; done

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# search through history with up/down arrows
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward' 2>/dev/null

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# Add ~/.local/bin to $PATH
export PATH="$HOME/.local/bin:$PATH"


# If ag is not installed, alias it to "grep -rn" (and generally force color for grep)
alias grep="grep --color=always"
which ag 2>/dev/null  || alias ag="grep -rn"

# Open file with open
alias open="xdg-open"

# A really simple password generator
alias pw='bash -c '"'"'echo `tr -dc $([ $# -gt 1 ] && echo $2 || echo "A-Za-z0-9") < /dev/urandom | head -c $([ $# -gt 0 ] && echo $1 || echo 30)`'"'"' --'

###########################
## Ubuntu-specific stuff ##
###########################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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



# Display a list of the matching files

bind "set show-all-if-ambiguous on"

# Perform partial completion on the first Tab press,
# only start cycling full results on the second Tab press

bind 'TAB':menu-complete
bind "set menu-complete-display-prefix on"

# Cycle through history based on characters already typed on the line

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# tmux alias to work with colors
alias tmux='tmux -2'

# Source local configs
if [ -f ~/.localrc ]; then
    . ~/.localrc
fi

# use vim as pager
if [[ "$(command -v nvim)" ]]; then
    export EDITOR='nvim'
    export MANPAGER='nvim --clean +Man!'
    export MANWIDTH=999
fi

