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

for i in stow yarn stylua tmuxp sqlfluff rg direnv pgformatter protobuf jq zoxide
do
	if ! command -v $i &>/dev/null; then
  brew install $i
fi
done


# ./bin/dotfiles install brew
./bin/dotfiles install stow
./bin/dotfiles install asdf
./bin/dotfiles install nvim
./bin/dotfiles install nvim_user
./bin/dotfiles install git
./bin/dotfiles install tmux
./bin/dotfiles install zsh
./bin/dotfiles install lazygit
