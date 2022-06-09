#!/usr/bin/env zsh
# credits https://github.com/benmatselby/dotfiles

set -e

###
# Installation of packages, configurations, and dotfiles.
###
DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION

###
# Install dependencies
###
# ./bin/dotfiles install brew
# ./bin/dotfiles install vscode
# ./bin/dotfiles install nvim
# ./bin/dotfiles install git
# ./bin/dotfiles install tmux
# ./bin/dotfiles install zsh
# ./bin/dotfiles install lazygit
./bin/dotfiles install foo
