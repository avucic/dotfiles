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

./bin/dotfiles install brew
./bin/dotfiles install stow
./bin/dotfiles install asdf
./bin/dotfiles install nvim
./bin/dotfiles install nvim_user
./bin/dotfiles install git
./bin/dotfiles install tmux
./bin/dotfiles install zsh
./bin/dotfiles install lazygit
