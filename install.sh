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
# TODO: linux support
if ! command -v stow &> /dev/null
then
  brew install stow
fi


# ./bin/dotfiles install brew
# ./bin/dotfiles install vscode
./bin/dotfiles install nvim
./bin/dotfiles install nvim_user
./bin/dotfiles install git
./bin/dotfiles install tmux
./bin/dotfiles install zsh
./bin/dotfiles install lazygit
