#!/usr/bin/env bash

set -e
source "$DOTFILES_LOCATION/install.sh"

echo "🐳 Installing zsh..."

install_package tmux

git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "▶️  Tmux setup"
