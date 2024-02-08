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

./bin/dotfiles install stow # run first
./bin/dotfiles install asdf
./bin/dotfiles install deps # run first
./bin/dotfiles install scripts
./bin/dotfiles install config
./bin/dotfiles install bashrc
./bin/dotfiles install bat
./bin/dotfiles install git
./bin/dotfiles install envrc
./bin/dotfiles install editorconfig
./bin/dotfiles install bin
./bin/dotfiles install nvim_user
./bin/dotfiles install tmux
./bin/dotfiles install zsh
./bin/dotfiles install vifm
./bin/dotfiles install lazygit
./bin/dotfiles install lazydocker
./bin/dotfiles install todo.txt-cli
./bin/dotfiles install topydo
./bin/dotfiles install stylua
./bin/dotfiles install prettier
./bin/dotfiles install irb
./bin/dotfiles install marksman
