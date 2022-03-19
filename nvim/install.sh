#!/usr/bin/env zsh

set -e

mkdir -p $HOME/.config/nvim

ln -sf "${DOTFILES_LOCATION}/nvim/init.lua" "${HOME}/.config/nvim/"
ln -sf "${DOTFILES_LOCATION}/nvim/lua" "${HOME}/.config/nvim/"

