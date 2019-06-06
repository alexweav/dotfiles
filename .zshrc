# Set history file and size
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# Use VI controls in line editor
bindkey -v

# Init completion and prompt
autoload -Uz compinit promptinit colors vcs_info
colors
promptinit
compinit

# Autocomplete command line switches for aliases
setopt COMPLETE_ALIASES

# Include privileged commands in autocomplete if we start with sudo
zstyle ':completion::complete:*' gain-privileges 1

# Set prompt preset
prompt walters

# Report command running time if it's over 3 seconds
REPORTTIME=3

# Add commands to history as they are entered
setopt EXTENDED_HISTORY

# Don't keep duplicates in history
setopt HIST_IGNORE_ALL_DUPS

# Don't remember commands which start with whitespace
setopt HIST_IGNORE_SPACE

# Enable spellcheck
setopt CORRECT_ALL

# Enable autocomplete
zstyle ':completion:*' completer _complete _correct _approximate

# Enable color
export CLICOLOR=1

# Enable color for ls
ls --color=auto &> /dev/null && alias ls='ls --color=auto'

