#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1="\n\[\033[0;31m\]\342\224\214\342\224\200$([[ $? != 0 ]] && echo "[\[\033[0;37m\]\342\234\227\[\033[0;31m\]]\342\224\200")[\[\033[0;34m\]\T \$(date +%m.%d.%y)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\u\[\033[0;31m\]]\342\224\200\[\033[0;31m\][\[\033[0;33m\]\$PWD\[\033[0;31m\]]\n\342\224\224\342\224\200\342\224\200>\[\033[0m\]"

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

# Try to keep environment pollution down, EPA loves us.
unset safe_term match_lhs

