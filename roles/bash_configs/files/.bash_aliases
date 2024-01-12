#!/bin/bash

###############################################################################

# Any shared and default aliases (terminal shortcuts) to be loaded with
# .bashrc go here.
# This is called and loaded with .bashrc
#
# Examples:
#    - alias ll="ls -la"

###############################################################################

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Change directory shortcuts
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../..'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Copy to clipboard
alias ccc='xclip -sel clip'
alias pbcopy='xclip -selection clipboard'

# Ignore potential python 2
alias python="python3"
alias pip="pip3"

# Create live server for current directory
alias pyserve="python3 -m http.server"

# Creating a python3 virtual environment
alias mkpyvenv="python3 -m venv env; source env/bin/activate"
alias env-on="source env/bin/activate"
alias env-off="deactivate"

# Reload the shell
alias reload-shell="exec $SHELL"

# VIM
alias vi="vim"

# Matlab start shortcuts
alias matlab='/usr/local/MATLAB/R2020b/bin/matlab'
alias matlab22='/usr/local/MATLAB/R2022a/bin/matlab'
alias matlab22b='/usr/local/MATLAB/R2022b/bin/matlab'
alias matlab23b='/usr/local/MATLAB/R2023b/bin/matlab'
