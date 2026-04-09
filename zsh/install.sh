#!/usr/bin/env bash

set -e
source "$DOTFILES_LOCATION/install.sh"

echo "🐳 Installing zsh..."

install_package eza
install_package fzf
install_package zoxide

# Znap: Fast Zsh Plugin Manager
if ! [ -e $HOME/.znap ]; then
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap
fi

if [ -e $HOME/.zshrc ]; then
  rm ~/.zshrc
fi
