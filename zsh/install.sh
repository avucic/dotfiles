#!/usr/bin/env zsh

set -e

if ! [ -e $HOME/.znap/custom/ohmyzsh/ohmyzsh/plugins ]; then
  cd ~/.znap/custom/ohmyzsh/ohmyzsh/plugins
  git clone https://github.com/MohamedElashri/exa-zsh
fi
