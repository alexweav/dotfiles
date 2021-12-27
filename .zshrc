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

PATH=/home/alexweav/.cargo/bin:$PATH


PATH="/home/alexweav/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/alexweav/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/alexweav/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/alexweav/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/alexweav/perl5"; export PERL_MM_OPT;
